"use client";

import { useState, useEffect } from 'react';
import Papa, { ParseResult } from 'papaparse';
import styles from '../styles/BlueMatrix.module.css';

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

  useEffect(() => {
    const fetchCSV = async () => {
      const response = await fetch('/assets//final_bank/final_bank_count_by_charttypetaskcombo.csv');
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
        },
      });
    };

    fetchCSV();
  }, []);

  const getColor = (value: number | null) => {
    if (value === null) return '#ffffff';
    const blueShades = [
      '#ffffff', // 0 - white
      '#e0f7fa', // 1
      '#b2ebf2', // 2
      '#80deea', // 3
      '#4dd0e1', // 4
      '#26c6da', // 5
      '#00bcd4', // 6
      '#00acc1', // 7
      '#0097a7', // 8
      '#00838f', // 9 - deep blue
    ];
    return blueShades[value];
  };

  return (
    <div className={styles.container}>
      {matrixData.matrix.length > 0 && (
        <table className={styles.matrixTable}>
          <thead>
            <tr>
              <th>Task \\ Chart Type</th>
              {matrixData.chartTypes.map((chart) => (
                <th key={chart}>{chart}</th>
              ))}
            </tr>
          </thead>
          <tbody>
            {matrixData.matrix.map((row, rowIndex) => (
              <tr key={`row-${rowIndex}`}>
                <td>{row.taskName}</td>
                {matrixData.chartTypes.map((chart) => (
                  <td
                    key={`${chart}-${rowIndex}`}
                    style={{
                      backgroundColor: getColor(row[chart] as number | null),
                      color: row[chart] !== null && (row[chart] as number) >= 5 ? '#fff' : '#000',
                      textAlign: 'center',
                    }}
                  >
                    {row[chart] !== null ? row[chart].toString() : '-'}
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
};

export default BlueMatrix;
