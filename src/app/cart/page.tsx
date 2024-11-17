'use client';

import { useCart } from '@/app/context/cart-context';
import JSZip from 'jszip';
import { saveAs } from 'file-saver';

const CartPage = () => {
  const { cart, removeFromCart, clearCart } = useCart();

  const handleDownload = async () => {
    const zip = new JSZip();

    for (const item of cart) {
      try {
        const imageResponse = await fetch(item.imageFileName);
        const imageBlob = await imageResponse.blob();
        zip.file(`images/${item.imageFileName.split('/').pop()}`, imageBlob);

        const textResponse = await fetch(item.textFileName);
        const textContent = await textResponse.text();
        zip.file(`texts/${item.textFileName.split('/').pop()}`, textContent);
      } catch (error) {
        console.error('Error fetching file:', error);
      }
    }

    const zipBlob = await zip.generateAsync({ type: 'blob' });
    saveAs(zipBlob, 'visualizations.zip');
  };

  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold mb-4">Cart</h1>
      {cart.length === 0 ? (
        <p>No items in the cart.</p>
      ) : (
        <>
          <ul className="mb-4">
            {cart.map((item, index) => (
              <li key={index} className="flex justify-between items-center mb-2">
                <div>
                  <p>{item.imageFileName}</p>
                  <p>{item.textFileName}</p>
                </div>
                <button
                  onClick={() => removeFromCart(item)}
                  className="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded"
                >
                  Remove
                </button>
              </li>
            ))}
          </ul>
          <button
            onClick={handleDownload}
            className="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded mr-2"
          >
            Download as Zip
          </button>
          <button
            onClick={clearCart}
            className="bg-gray-500 hover:bg-gray-600 text-white px-4 py-2 rounded"
          >
            Clear Cart
          </button>
        </>
      )}
    </div>
  );
};

export default CartPage;
