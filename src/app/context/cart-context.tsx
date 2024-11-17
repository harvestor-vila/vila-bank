// context/cart-context.ts
'use client';

import { createContext, useContext, useState, ReactNode } from 'react';

interface CartItem {
  imageFileName: string;
  textFileName: string;
}

interface CartContextType {
  cart: CartItem[];
  addToCart: (item: CartItem) => void;
  removeFromCart: (item: CartItem) => void;
  clearCart: () => void;
}

const CartContext = createContext<CartContextType | undefined>(undefined);

export const CartProvider = ({ children }: { children: ReactNode }) => {
  const [cart, setCart] = useState<CartItem[]>([]);

  const addToCart = (item: CartItem) => setCart(prev => [...prev, item]);
  const removeFromCart = (item: CartItem) =>
    setCart(prev => prev.filter(cartItem => cartItem.imageFileName !== item.imageFileName));
  const clearCart = () => setCart([]);

  return (
    <CartContext.Provider value={{ cart, addToCart, removeFromCart, clearCart }}>
      {children}
    </CartContext.Provider>
  );
};

export const useCart = () => {
  const context = useContext(CartContext);
  if (!context)
    throw new Error('useCart must be used within a CartProvider');
  return context;
};
