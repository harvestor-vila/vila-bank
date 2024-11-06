'use client';
import BlueMatrix from "./components/blue-matrix";
// import ItemList from "./components/item-list";
import { ChartType, VisualizationTask, VisualizationContext } from '@/app/types';

export default function Home() {

  return (
    <div className="min-h-screen">
      <BlueMatrix />
    </div>
  );
}