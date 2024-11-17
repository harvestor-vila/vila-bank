// src/app/utils/fileUtils.ts
export const generateImagePath = (chartType: string, context: string) =>
    `/candidate_bank/108_visualization_component/${chartType}-${context}.png`;
  
  export const generateTextPath = (chartType: string, task: string, context: string) =>
    `/candidate_bank/1404_textual_component/${chartType}-${task}-${context}.txt`;
  