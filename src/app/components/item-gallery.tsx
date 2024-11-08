'use client';
import { useEffect, useState } from 'react';
import { ChartType, VisualizationTask, VisualizationContext, VisualizationItem } from '@/app/utils/types';
import { fetchVisualizationItems, getFilterOptions, filterItems } from '@/app/utils/visualizationUtils';
import { formatEnumValue, formatTaskString } from '@/app/utils/formatStringUtils';
import ItemList from './item-list';
import Item from './item';
import Pagination from './pagination';

const ITEMS_PER_PAGE = 18;

const ItemGallery = () => {
  const [items, setItems] = useState<VisualizationItem[]>([]);
  const [filteredItems, setFilteredItems] = useState<VisualizationItem[]>([]);
  const [currentPage, setCurrentPage] = useState(1);
  const [filters, setFilters] = useState({
    chartType: null as ChartType | null,
    task: null as VisualizationTask | null,
    context: null as VisualizationContext | null
  });
  const [filterOptions, setFilterOptions] = useState({
    chartTypes: [] as ChartType[],
    tasks: [] as VisualizationTask[],
    contexts: [] as VisualizationContext[]
  });
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const loadItems = async () => {
      const fetchedItems = await fetchVisualizationItems();
      setItems(fetchedItems);
      setFilteredItems(fetchedItems);
      setFilterOptions(getFilterOptions(fetchedItems));
      setIsLoading(false);
    };

    loadItems();
  }, []);

  useEffect(() => {
    setFilteredItems(filterItems(items, filters));
    setCurrentPage(1);
  }, [items, filters]);

  const handleFilterChange = (
    filterType: 'chartType' | 'task' | 'context',
    value: string | null
  ) => {
    setFilters(prev => ({
      ...prev,
      [filterType]: value ? value : null
    }));
  };

  // Pagination calculations
  const totalPages = Math.ceil(filteredItems.length / ITEMS_PER_PAGE);
  const startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
  const endIndex = startIndex + ITEMS_PER_PAGE;
  const currentItems = filteredItems.slice(startIndex, endIndex);

  const handlePageChange = (pageNumber: number) => {
    setCurrentPage(pageNumber);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-[#80deea]" />
      </div>
    );
  }

  return (
    <div className="p-8">
      {/* Filters */}
      <div className="mb-8 grid grid-cols-1 md:grid-cols-3 gap-4">
        {/* Chart Type Filter */}
        <div className="flex flex-col">
          <label className="text-sm font-medium mb-2">Chart Type</label>
          <select
            className="border rounded-lg p-2 focus:outline-none"
            onChange={(e) => handleFilterChange('chartType', e.target.value || null)}
            value={filters.chartType || ''}
          >
            <option value="">All Chart Types</option>
            {filterOptions.chartTypes.map(type => (
              <option key={type} value={type}>
                {formatEnumValue(type)}
              </option>
            ))}
          </select>
        </div>

        {/* Task Filter */}
        <div className="flex flex-col">
          <label className="text-sm font-medium mb-2">Task</label>
          <select
            className="border rounded-lg p-2 focus:outline-none"
            onChange={(e) => handleFilterChange('task', e.target.value || null)}
            value={filters.task || ''}
          >
            <option value="">All Tasks</option>
            {filterOptions.tasks.map(task => (
              <option key={task} value={task}>
                {formatTaskString(task)}
              </option>
            ))}
          </select>
        </div>

        {/* Context Filter */}
        <div className="flex flex-col">
          <label className="text-sm font-medium mb-2">Context</label>
          <select
            className="border rounded-lg p-2 focus:outline-none"
            onChange={(e) => handleFilterChange('context', e.target.value || null)}
            value={filters.context || ''}
          >
            <option value="">All Contexts</option>
            {filterOptions.contexts.map(context => (
              <option key={context} value={context}>
                {formatEnumValue(context)}
              </option>
            ))}
          </select>
        </div>
      </div>

      {/* Results Count and Top Pagination */}
      <div className="mb-4 flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
        {filteredItems.length > 0 && (
          <p className="text-sm sm:text-base text-gray-600">
            Showing {startIndex + 1}-{Math.min(endIndex, filteredItems.length)} of {filteredItems.length} items
          </p>
        )}
        <Pagination
          currentPage={currentPage}
          totalPages={totalPages}
          onPageChange={handlePageChange}
        />
      </div>

      {/* Displaying Items */}
      {filteredItems.length === 0 ? (
        <div className="flex flex-col items-center justify-center h-64">
          <p className="text-xl text-black-500 font-medium mb-2">No items available</p>
          <p className="text-gray-500">Try adjusting your filters :(</p>
          <button
            onClick={() => setFilters({
              chartType: null,
              task: null,
              context: null
            })}
            className="mt-4 px-4 py-2 bg-[#b2ebf2] hover:bg-[#80deea] rounded-lg transition-colors"
          >
            Reset Filters
          </button>
        </div>
      ) : filteredItems.length === 1 ? (
        <Item chartType={filteredItems[0].chartType} task={filteredItems[0].task} context={filteredItems[0].context} />
      ) : (
        <>
          <ItemList items={currentItems} />
          
          {/* Bottom Pagination */}
          <div className="mt-4 sm:mt-8">
            <Pagination
              currentPage={currentPage}
              totalPages={totalPages}
              onPageChange={handlePageChange}
            />
          </div>
        </>
      )}
    </div>
  );
};

export default ItemGallery;