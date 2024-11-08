'use client';
import { useState } from 'react';
import Image from 'next/image';
import { ChartType, VisualizationTask, VisualizationContext } from '@/app/utils/types';
import { formatTaskString, formatEnumValue } from '@/app/utils/formatStringUtils';
import Carousel from '@/app/components/item-carousel';

interface ItemListProps {
  items: Array<{
    chartType: ChartType;
    task: VisualizationTask;
    context: VisualizationContext;
  }>;
}

const ItemList = ({ items }: ItemListProps) => {
  const [selectedItem, setSelectedItem] = useState<number | null>(null);

  if (selectedItem !== null) {
    return (
      <div>
        <button
          onClick={() => setSelectedItem(null)}
          className="mb-6 flex items-center gap-1 px-3 py-3 bg-[#b2ebf2] hover:bg-[#80deea] rounded-lg shadow transition-colors"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
          >
            <path d="m15 18-6-6 6-6"/>
          </svg>
          Back to List
        </button>
        <Carousel 
          items={items} 
          initialIndex={selectedItem}
          onBackClick={() => setSelectedItem(null)}
        />
      </div>
    );
  }

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 p-6">
      {items.map((item, index) => (
        <button
          key={`${item.chartType}-${item.task}-${item.context}-${index}`}
          onClick={() => setSelectedItem(index)}
          className="bg-white rounded-lg shadow-lg overflow-hidden hover:shadow-xl transition-shadow"
        >
          <div className="relative w-full h-48">
            <Image
              src={`/candidate_bank/108_visualization_component/${item.chartType}-${item.context}.png`}
              alt={`${item.chartType} visualization`}
              fill
              style={{ objectFit: 'contain' }}
              className="p-4"
            />
          </div>
          <div className="p-4 text-left">
            <h2 className="text-lg mb-2">
              {formatTaskString(item.task) + " - " + formatEnumValue(item.context)}
            </h2>
          </div>
        </button>
      ))}
    </div>
  );
};

export default ItemList;