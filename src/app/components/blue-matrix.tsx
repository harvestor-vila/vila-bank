"use client";

import { useState, useEffect } from 'react';
import Papa, { ParseResult } from 'papaparse';
import ItemList from './item-list'; 
import { ChartType, VisualizationTask, VisualizationContext, VisualizationItem } from '@/app/types';

interface CSVRow {
  combo: string;
  n: string;
}

interface MatrixRow {
  taskName: string;
  [key: string]: number | string | null;
}

interface MatrixData {
  chartTypes: string[];
  taskNames: string[];
  matrix: MatrixRow[];
}

const BlueMatrix = () => {
  const [matrixData, setMatrixData] = useState<MatrixData>({
    chartTypes: [],
    taskNames: [],
    matrix: [],
  });
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedItems, setSelectedItems] = useState<VisualizationItem[]>([]);
  const [itemsInFinalBank, setItemsInFinalBank] = useState<string[]>([]);
  const [selectedCell, setSelectedCell] = useState<{
    chartType: string;
    taskName: string;
  } | null>(null);

  useEffect(() => {
    const fetchCSV = async () => {
      try {
        // Fetch and parse the count data
        const response = await fetch('/final_bank/final_bank_count_by_charttypetaskcombo.csv');
        const csvText = await response.text();
        
        Papa.parse<CSVRow>(csvText, {
          header: true,
          skipEmptyLines: true,
          complete: (result: ParseResult<CSVRow>) => {
            const data = result.data;
            const parsedData = data.map((row) => ({
              chartType: row.combo.split('-')[0].trim(),
              taskName: row.combo.split('-')[1].trim(),
              value: Number(row.n),
            }));

            const chartTypes = [...new Set(parsedData.map((d) => d.chartType))];
            const taskNames = [...new Set(parsedData.map((d) => d.taskName))];

            const matrix = taskNames.map((task) => {
              const row: MatrixRow = { taskName: task };
              chartTypes.forEach((chart) => {
                const cell = parsedData.find(
                  (d) => d.chartType === chart && d.taskName === task
                );
                row[chart] = cell ? cell.value : null;
              });
              return row;
            });

            setMatrixData({ chartTypes, taskNames, matrix });
          },
        });

        // Fetch and parse the items data
        const itemsResponse = await fetch('/final_bank/final_bank.csv');
        const itemsText = await itemsResponse.text();
        
        Papa.parse<string[]>(itemsText, {
          header: false,
          skipEmptyLines: true,
          complete: (result: ParseResult<string[]>) => {
            const items = result.data
              .slice(1)  // Skip header row if present
              .map((row) => row[0]);
            setItemsInFinalBank(items);
          },
        });
      } catch (error) {
        console.error('Error fetching CSV data:', error);
      }
    };

    fetchCSV();
  }, []);

  const getColorClass = (value: number | null) => {
    if (value === null) return 'bg-white';

    const colorMap: { [key: number]: string } = {
      0: 'bg-white text-black',
      1: 'bg-[#e0f7fa] text-black',
      2: 'bg-[#b2ebf2] text-black',
      3: 'bg-[#80deea] text-black',
      4: 'bg-[#4dd0e1] text-white',
      5: 'bg-[#26c6da] text-white',
      6: 'bg-[#00bcd4] text-white',
      7: 'bg-[#00acc1] text-white',
      8: 'bg-[#0097a7] text-white',
      9: 'bg-[#00838f] text-white',
    };

    return colorMap[value] || 'bg-white text-black';
  };

  const handleCellClick = (chartType: string, taskName: string) => {
    const normalizedChartType = chartType.replace(/\s+/g, '_').toLowerCase();
    const normalizedTaskName = taskName.replace(/\s+/g, '_').toLowerCase();
    
    // Filter items for this cell
    const items: VisualizationItem[] = itemsInFinalBank
      .filter((item) => {
        const [itemChart, itemTask] = item.split('-');
        return (
          itemChart.trim().toLowerCase() === normalizedChartType &&
          itemTask.trim().toLowerCase() === normalizedTaskName
        );
      })
      .map((item) => {
        const [chart, task, context] = item.split('-');
        return {
          chartType: chart.toUpperCase() as ChartType,
          task: task.toUpperCase() as VisualizationTask,
          context: context.toUpperCase() as VisualizationContext,
        };
      });

    setSelectedItems(items);
    setSelectedCell({ chartType, taskName });
    setIsModalOpen(true);
  };

  return (
    <div className="p-8 flex flex-col items-center">
      {/* Matrix Table */}
      {matrixData.matrix.length > 0 && (
        <table className="w-full border-collapse mt-4 text-sm table-fixed">
          <thead>
            <tr>
              <th className="w-40 bg-gray-100 font-semibold border border-gray-300 p-2 text-center">
                Task \\ Chart Type
              </th>
              {matrixData.chartTypes.map((chart) => (
                <th
                  key={chart}
                  className="w-24 bg-gray-100 font-semibold border border-gray-300 p-2 text-center"
                >
                  {chart}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {matrixData.matrix.map((row, rowIndex) => (
              <tr key={`row-${rowIndex}`}>
                <td className="w-40 font-semibold bg-[#e0f7fa] border border-gray-300 p-2 text-center">
                  {row.taskName}
                </td>
                {matrixData.chartTypes.map((chart) => (
                  <td
                    key={`${chart}-${rowIndex}`}
                    className={`w-12 h-12 border border-gray-300 cursor-pointer ${getColorClass(
                      row[chart] as number | null
                    )}`}
                    onClick={() => handleCellClick(chart, row.taskName)}
                  >
                    <div className="flex items-center justify-center h-full">
                      {row[chart] !== null ? row[chart].toString() : '-'}
                    </div>
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      )}

      {/* Modal with ItemList */}
      {isModalOpen && selectedCell && (
        <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50 overflow-y-auto">
          <div className="bg-white rounded-lg shadow-lg w-full max-w-6xl m-4 relative">
            <div className="p-4 border-b">
              <h2 className="text-xl font-bold">
                {selectedCell.chartType} - {selectedCell.taskName}
              </h2>
              <button
                className="absolute top-4 right-4 text-gray-500 hover:text-gray-700"
                onClick={() => setIsModalOpen(false)}
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  className="h-6 w-6"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M6 18L18 6M6 6l12 12"
                  />
                </svg>
              </button>
            </div>
            <div className="p-4 max-h-[80vh] overflow-y-auto">
              <ItemList items={selectedItems} />
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default BlueMatrix;