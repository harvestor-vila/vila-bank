'use client';

import { useState } from 'react';
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
  const [selectedItem, setSelectedItem] = useState<number | null>(null);
  const { cart, addToCart, removeFromCart } = useCart();

  const toggleCartItem = (index: number) => {
    const item = items[index];

    const cartItem = {
      imageFileName: generateImagePath(item.chartType, item.context),
      textFileName: generateTextPath(item.chartType, item.task, item.context),
    };

    const isInCart = cart.some(cartItem => cartItem.imageFileName === generateImagePath(item.chartType, item.context));

    if (isInCart) {
      removeFromCart(cartItem);
    } else {
      addToCart(cartItem);
    }
  };

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 p-6">
      {items.map((item, index) => {
        const isInCart = cart.some(cartItem => cartItem.imageFileName === generateImagePath(item.chartType, item.context));

        return (
          <div
            key={`${item.chartType}-${item.task}-${item.context}-${index}`}
            className="bg-white rounded-lg shadow-lg overflow-hidden hover:shadow-xl transition-shadow"
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
            <button
              onClick={() => toggleCartItem(index)}
              className={`mt-2 px-4 py-2 rounded-lg ${
                isInCart ? 'bg-red-500 hover:bg-red-600' : 'bg-green-500 hover:bg-green-600'
              } text-white transition`}
            >
              {isInCart ? 'Remove from Cart' : 'Add to Cart'}
            </button>
          </div>
        );
      })}
    </div>
  );
};

export default ItemList;
