'use client';

import Image from 'next/image';
import { ChartType, VisualizationTask, VisualizationContext } from '@/app/utils/types';
import { formatTaskString, formatEnumValue } from '@/app/utils/formatStringUtils';
import { useCart } from '@/app/context/cart-context';
import { generateImagePath, generateTextPath } from '@/app/utils/fileUtils';

interface ItemListProps {
  items: Array<{
    chartType: ChartType;
    task: VisualizationTask;
    context: VisualizationContext;
  }>;
}

const ItemList = ({ items }: ItemListProps) => {
  const { cart, addToCart, removeFromCart } = useCart();

  const toggleCartItem = (index: number) => {
    const item = items[index];

    const cartItem = {
      imageFileName: generateImagePath(item.chartType, item.context), // Visual component
      textFileName: generateTextPath(item.chartType, item.task, item.context), // Textual component
    };

    const isInCart = cart.some(cartItem => cartItem.textFileName === generateTextPath(item.chartType, item.task, item.context));

    if (isInCart) {
      removeFromCart(cartItem);
    } else {
      addToCart(cartItem);
    }
  };

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 p-6">
      {items.map((item, index) => {
        // Check if the textual component is in the cart
        const isInCart = cart.some(cartItem => cartItem.textFileName === generateTextPath(item.chartType, item.task, item.context));

        return (
          <div
            key={`${item.chartType}-${item.task}-${item.context}-${index}`}
            className="relative bg-white rounded-lg shadow-lg overflow-hidden hover:shadow-xl transition-shadow"
          >
            <div className="relative w-full h-48">
              <Image
                src={generateImagePath(item.chartType, item.context)}
                alt={`${item.chartType} visualization`}
                fill
                style={{ objectFit: 'contain' }}
                className="p-4"
              />
            </div>
            <div className="p-4 text-left text-lg mb-1">
              <h2 className="text-lg">{"Task: " + formatTaskString(item.task)}</h2>
              <h2 className="text-lg">{"Context: " + formatEnumValue(item.context)}</h2>
            </div>

            {/* Tick Mark for Selection */}
            <label className="absolute top-4 right-4">
              <input
                type="checkbox"
                checked={isInCart}
                onChange={() => toggleCartItem(index)}
                className="hidden"
              />
              <div
                className={`w-6 h-6 rounded-full border-2 border-green-500 flex items-center justify-center ${
                  isInCart ? 'bg-green-500' : 'bg-white'
                }`}
              >
                {isInCart && (
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="16"
                    height="16"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="white"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  >
                    <path d="M20 6L9 17l-5-5" />
                  </svg>
                )}
              </div>
            </label>
          </div>
        );
      })}
    </div>
  );
};

export default ItemList;
