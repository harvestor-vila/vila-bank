import { ChartType, VisualizationTask, VisualizationContext, VisualizationItem } from '@/app/utils/types';

// Helper function to get enum value by string value
export const getEnumValueByString = <T extends { [key: string]: string }>(
  enumObj: T,
  value: string
): T[keyof T] | null => {
  const enumKey = Object.entries(enumObj).find(([_, val]) => val === value)?.[0];
  return enumKey ? enumObj[enumKey as keyof T] : null;
};

// Format enum values for display
export const formatEnumValue = (value: string) => {
  return value
    .split('_')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
    .join(' ');
};

// Function to fetch and parse visualization items
export const fetchVisualizationItems = async (): Promise<VisualizationItem[]> => {
  try {
    const response = await fetch('/final_bank/final_bank.csv');
    const csvText = await response.text();
    const lines = csvText.split('\n').slice(1); // Skip header
    
    const items: VisualizationItem[] = [];
    
    for (const line of lines) {
      if (!line.trim()) continue;
      
      const [chartTypeStr, taskStr, contextStr] = line.trim().split('-');
      
      const chartType = getEnumValueByString(ChartType, chartTypeStr);
      const task = getEnumValueByString(VisualizationTask, taskStr);
      const context = getEnumValueByString(VisualizationContext, contextStr);

      if (chartType && task && context) {
        items.push({
          chartType: chartType as ChartType,
          task: task as VisualizationTask,
          context: context as VisualizationContext
        });
      }
    }

    return items;
  } catch (error) {
    console.error('Error fetching visualization items:', error);
    return [];
  }
};

// Function to get unique values for filters
export const getFilterOptions = (items: VisualizationItem[]) => {
  return {
    chartTypes: Array.from(new Set(items.map(item => item.chartType))),
    tasks: Array.from(new Set(items.map(item => item.task))),
    contexts: Array.from(new Set(items.map(item => item.context)))
  };
};

// Function to filter items based on selected filters
export const filterItems = (
  items: VisualizationItem[],
  filters: {
    chartType?: ChartType | null;
    task?: VisualizationTask | null;
    context?: VisualizationContext | null;
  }
) => {
  return items.filter(item => {
    if (filters.chartType && item.chartType !== filters.chartType) return false;
    if (filters.task && item.task !== filters.task) return false;
    if (filters.context && item.context !== filters.context) return false;
    return true;
  });
};

// Function to create matrix data from items
export const createMatrixData = (items: VisualizationItem[]) => {
  const chartTypes = Array.from(new Set(items.map(item => item.chartType)));
  const taskNames = Array.from(new Set(items.map(item => item.task)));

  const matrix = taskNames.map(task => {
    const row: { taskName: VisualizationTask; [key: string]: number | VisualizationTask | null } = 
      { taskName: task };
    
    chartTypes.forEach(chart => {
      const count = items.filter(
        item => item.chartType === chart && item.task === task
      ).length;
      row[chart] = count;
    });
    
    return row;
  });

  return {
    chartTypes,
    taskNames,
    matrix
  };
};