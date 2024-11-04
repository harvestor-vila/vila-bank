'use client';
import Carousel from '@/app/item-carousel';
import { ChartType, VisualizationTask, VisualizationContext } from '@/app/types';

export default function Home() {
  const items = [
    {
      chartType: ChartType.BAR,
      task: VisualizationTask.MAKE_COMPARISONS,
      context: VisualizationContext.ENERGY
    },
    {
      chartType: ChartType.BAR,
      task: VisualizationTask.MAKE_COMPARISONS,
      context: VisualizationContext.HEALTH
    },
    {
      chartType: ChartType.BAR,
      task: VisualizationTask.MAKE_COMPARISONS,
      context: VisualizationContext.POPULATION
    },
    {
      chartType: ChartType.BAR,
      task: VisualizationTask.MAKE_COMPARISONS,
      context: VisualizationContext.WEATHER
    },
    {
      chartType: ChartType.BAR,
      task: VisualizationTask.MAKE_COMPARISONS,
      context: VisualizationContext.FOOD
    },
    {
      chartType: ChartType.BAR,
      task: VisualizationTask.MAKE_COMPARISONS,
      context: VisualizationContext.ECONOMY
    },
    {
      chartType: ChartType.BAR,
      task: VisualizationTask.MAKE_COMPARISONS,
      context: VisualizationContext.POLITICS
    },
    {
      chartType: ChartType.BAR,
      task: VisualizationTask.MAKE_COMPARISONS,
      context: VisualizationContext.EDUCATION
    },
    {
      chartType: ChartType.BAR,
      task: VisualizationTask.MAKE_COMPARISONS,
      context: VisualizationContext.INNOVATION
    },
  ];

  return (
    <div className="min-h-screen p-8 sm:p-20">
      <Carousel items={items} />
    </div>
  );
}