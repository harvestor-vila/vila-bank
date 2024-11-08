"use client";

import { useState, useEffect } from 'react';
import Papa, { ParseResult } from 'papaparse';
import ItemList from './item-list';
import { ChartType, VisualizationTask, VisualizationContext, VisualizationItem } from '@/app/utils/types';
import { fetchVisualizationItems, createMatrixData,formatEnumValue } from '@/app/utils/visualizationUtils';

interface MatrixRow {
  taskName: VisualizationTask;
  [key: string]: number | VisualizationTask | null;
}

interface MatrixData {
  chartTypes: ChartType[];
  taskNames: VisualizationTask[];
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
  const [itemsInFinalBank, setItemsInFinalBank] = useState<VisualizationItem[]>([]);
  const [selectedCell, setSelectedCell] = useState<{
    chartType: ChartType;
    taskName: VisualizationTask;
  } | null>(null);

  useEffect(() => {
    const loadData = async () => {
      const items = await fetchVisualizationItems();
      setItemsInFinalBank(items);
      setMatrixData(createMatrixData(items));
    };
  
    loadData();
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

  const handleCellClick = (chartType: ChartType, taskName: VisualizationTask) => {
    const items = itemsInFinalBank.filter(
      item => item.chartType === chartType && item.task === taskName
    );

    setSelectedItems(items);
    setSelectedCell({ chartType, taskName });
    setIsModalOpen(true);
  };

  const formatEnumValue = (value: string) => {
    return value
      .split('_')
      .map(word => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
      .join(' ');
  };

  return (
    <div className="p-8 flex flex-col items-center">
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
                  {formatEnumValue(chart)}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {matrixData.matrix.map((row, rowIndex) => (
              <tr key={`row-${rowIndex}`}>
                <td className="w-40 font-semibold bg-[#e0f7fa] border border-gray-300 p-2 text-center">
                  {formatEnumValue(row.taskName)}
                </td>
                {matrixData.chartTypes.map((chart) => (
                  <td
                    key={`${chart}-${rowIndex}`}
                    className={`w-12 h-12 border border-gray-300 cursor-pointer ${getColorClass(
                      row[chart] as number | null
                    )}`}
                    onClick={() => {
                        if (row[chart] && row[chart] !== 0)
                          handleCellClick(chart, row.taskName)
                      }
                    }
                  >
                    <div className="flex items-center justify-center h-full">
                      {row[chart] && row[chart] !== 0 ? row[chart].toString() : '-'}
                    </div>
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      )}

      {isModalOpen && selectedCell && (
        <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50">
          <div className="bg-white rounded-lg shadow-lg w-[70vw] h-[90vh] m-4 relative flex flex-col">
            {/* Header */}
            <div className="p-6 border-b border-gray-200 flex justify-between items-center">
              <h2 className="text-2xl font-bold">
                {formatEnumValue(selectedCell.chartType)} - {formatEnumValue(selectedCell.taskName)}
              </h2>
              <button
                className="text-gray-500 hover:text-gray-700 transition-colors"
                onClick={() => setIsModalOpen(false)}
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  className="h-8 w-8"
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
            
            {/* Content */}
            <div className="flex-1 p-6 overflow-y-auto">
              <ItemList items={selectedItems} />
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default BlueMatrix;