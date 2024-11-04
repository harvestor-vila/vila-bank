"use client";

import { useState, useEffect } from 'react';
import Papa, { ParseResult } from 'papaparse';
import Carousel from './item-carousel';
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
  const [isPopupOpen, setIsPopupOpen] = useState(false);
  const [carouselItems, setCarouselItems] = useState<VisualizationItem[]>([]);
  const [itemsInFinalBank, setItemsInFinalBank] = useState<string[]>([]);

  useEffect(() => {
    const fetchCSV = async () => {
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
              const cell = parsedData.find((d) => d.chartType === chart && d.taskName === task);
              row[chart] = cell ? cell.value : null;
            });
            return row;
          });

          setMatrixData({ chartTypes, taskNames, matrix });
          console.log("Parsed matrix data:", { chartTypes, taskNames, matrix });
        },
      });

      const itemsResponse = await fetch('/final_bank/final_bank.csv');
      const itemsText = await itemsResponse.text();
      Papa.parse<string[]>(itemsText, {
        header: false,
        skipEmptyLines: true,
        complete: (result: ParseResult<string[]>) => {
          const items = result.data.map((row) => row[0]);
          setItemsInFinalBank(items);
          console.log("Items in final bank:", items);
        },
      });
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
    console.log(`Cell clicked: chartType = ${chartType}, taskName = ${taskName}`);
  
    const normalizedChartType = chartType.replace(/\s+/g, '_').toLowerCase();
    const normalizedTaskName = taskName.replace(/\s+/g, '_').toLowerCase();
  
    const items: VisualizationItem[] = itemsInFinalBank
      .filter((item) => {
        const [itemChart, itemTask] = item.split('-');
        const matches = 
          itemChart.trim().toLowerCase() === normalizedChartType &&
          itemTask.trim().toLowerCase() === normalizedTaskName;
        
        console.log(`Comparing: ${item} -> chart: ${itemChart}, task: ${itemTask}, matches: ${matches}`);
        
        return matches;
      })
      .map((item) => {
        const [chart, task, context] = item.split('-');
        return {
          chartType: chart.toUpperCase() as ChartType,
          task: task.replace(/_/g, ' ').toUpperCase() as VisualizationTask,
          context: context.toUpperCase() as VisualizationContext,
        };
      });
  
    console.log("Filtered items for carousel:", items);
    setCarouselItems(items);
    setIsPopupOpen(true);
  };
  
  

  const closePopup = () => {
    setIsPopupOpen(false);
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

      {isPopupOpen && (
        <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50">
          <div className="bg-white p-6 rounded-lg shadow-lg max-w-lg w-full relative">
            <button
              className="absolute top-4 right-4 text-gray-500 hover:text-gray-700"
              onClick={closePopup}
            >
              Close
            </button>
            <Carousel items={carouselItems} />
          </div>
        </div>
      )}
    </div>
  );
};

export default BlueMatrix;
