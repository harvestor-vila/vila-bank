'use client';
import { useState } from 'react';
import Item from './item';
import { ChevronLeft, ChevronRight } from 'lucide-react';
import { ChartType, VisualizationTask, VisualizationContext } from '@/app/utils/types';

interface CarouselProps {
  items: Array<{
    chartType: ChartType;
    task: VisualizationTask;
    context: VisualizationContext;
  }>;
  initialIndex?: number;
  onBackClick?: () => void;
}

const Carousel = ({ items, initialIndex = 0 }: CarouselProps) => {
  const [currentIndex, setCurrentIndex] = useState(initialIndex);

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
      <div className="overflow-hidden bg-white rounded-lg">
        <div className="pb-10">
          <Item {...items[currentIndex]} />
        </div>
      </div>

        {/* Navigation Buttons */}
        <div className="absolute top-60 left-0 right-0 flex items-center justify-between px-4 -translate-y-1/2">
          <button
            onClick={goToPrevious}
            className="z-10 p-2 bg-[#b2ebf2] rounded-full shadow-lg hover:bg-[#80deea] transition-colors"
            aria-label="Previous item"
          >
            <ChevronLeft className="w-6 h-6" />
          </button>
          <button
            onClick={goToNext}
            className="z-10 p-2 bg-[#b2ebf2] rounded-full shadow-lg hover:bg-[#80deea] transition-colors"
            aria-label="Next item"
          >
            <ChevronRight className="w-6 h-6" />
          </button>
        </div>
      </div>
  );
};

export default Carousel;