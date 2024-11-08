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
      {/* Current Item with extra padding at bottom */}
      <div className="overflow-hidden bg-white rounded-lg">
        <div className="pb-10"> {/* Added padding bottom wrapper */}
          <Item {...items[currentIndex]} />
        </div>
      </div>

      {/* Navigation Buttons */}
      <div className="absolute inset-y-0 left-0 right-0 flex items-center justify-between">
        <button
          onClick={goToPrevious}
          className="p-2 -ml-10 bg-[#b2ebf2] rounded-full shadow-lg hover:bg-[#80deea] transition-colors"
          aria-label="Previous item"
        >
          <ChevronLeft className="w-6 h-6" />
        </button>
        <button
          onClick={goToNext}
          className="p-2 -mr-10 bg-[#b2ebf2] rounded-full shadow-lg hover:bg-[#80deea] transition-colors"
          aria-label="Next item"
        >
          <ChevronRight className="w-6 h-6" />
        </button>
      </div>

      {/* Slide Counter */}
      <div className="absolute bottom-4 left-1/2 transform -translate-x-1/2 bg-black/50 text-white px-3 py-1 rounded-full text-sm z-10">
        {currentIndex + 1} / {items.length}
      </div>
    </div>
  );
};

export default Carousel;