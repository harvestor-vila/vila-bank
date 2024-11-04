'use client';
import BlueMatrix from "./components/blue-matrix";
import ItemList from "@/app/item-list";
import { ChartType, VisualizationTask, VisualizationContext } from '@/app/types';

export default function Home() {

  return (
    <div className="min-h-screen p-8 sm:p-20">
      <ItemList items={items} />
      <BlueMatrix />
    </div>
  );
}