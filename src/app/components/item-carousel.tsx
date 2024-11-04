'use client';
import { useState } from 'react';
import Item from '@/app/item';
import { ChevronLeft, ChevronRight } from 'lucide-react';
import { ChartType, VisualizationTask, VisualizationContext } from '@/app/types';

interface CarouselProps {
  items: Array<{
    chartType: ChartType;
    task: VisualizationTask;
    context: VisualizationContext;
  }>;
  initialIndex?: number;
  onBackClick?: () => void;
}

const formatCategoryName = (chartType: string, task: string) => {
  const chartName = chartType.split('_').map(word => 
    word.charAt(0).toUpperCase() + word.slice(1)
  ).join(' ');
  
  const taskName = task.split('_').map(word => 
    word.charAt(0).toUpperCase() + word.slice(1)
  ).join(' ');
  
  return `${chartName} - ${taskName}`;
};

const Carousel = ({ items, initialIndex = 0, onBackClick }: CarouselProps) => {
  const [currentIndex, setCurrentIndex] = useState(initialIndex);
  const chartType = items[currentIndex].chartType;
  const task = items[currentIndex].task;

  const goToPrevious = () => {
    setCurrentIndex((prevIndex) => 
      prevIndex === 0 ? items.length - 1 : prevIndex - 1
    );
  };

  const goToNext = () => {
    setCurrentIndex((prevIndex) => 
      prevIndex === items.length - 1 ? 0 : prevIndex + 1
    );
  };

  if (!items.length) {
    return (
      <div className="flex items-center justify-center h-96 bg-gray-50">
        <p className="text-gray-500">No items to display</p>
      </div>
    );
  }

  return (
    <div className="relative max-w-4xl mx-auto">
      <h2 className="text-2xl font-bold mb-6">
        {formatCategoryName(chartType, task)}
      </h2>
      
      {/* Current Item */}
      <div className="overflow-hidden bg-white rounded-lg shadow-lg">
        <Item {...items[currentIndex]} />
      </div>

      {/* Navigation Buttons */}
      <div className="absolute inset-y-0 left-0 right-0 flex items-center justify-between">
        <button
          onClick={goToPrevious}
          className="p-2 ml-4 bg-white rounded-full shadow-lg hover:bg-gray-100 transition-colors"
          aria-label="Previous item"
        >
          <ChevronLeft className="w-6 h-6" />
        </button>
        <button
          onClick={goToNext}
          className="p-2 mr-4 bg-white rounded-full shadow-lg hover:bg-gray-100 transition-colors"
          aria-label="Next item"
        >
          <ChevronRight className="w-6 h-6" />
        </button>
      </div>

      {/* Slide Counter */}
      <div className="absolute -bottom-10 left-1/2 transform -translate-x-1/2 bg-black/50 text-white px-3 py-1 rounded-full text-sm">
        {currentIndex + 1} / {items.length}
      </div>
    </div>
  );
};

export default Carousel;
