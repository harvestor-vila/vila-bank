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
        // Create a folder for each item
        const folderName = item.textFileName.split('/').pop()?.replace('.txt', '') || 'item';
        const itemFolder = zip.folder(folderName);

        if (!itemFolder) {
          console.error('Failed to create folder in zip:', folderName);
          continue;
        }

        // Fetch and add the image file to the folder
        const imageResponse = await fetch(item.imageFileName);
        if (imageResponse.ok) {
          const imageBlob = await imageResponse.blob();
          itemFolder.file(`visualization.png`, imageBlob);
        } else {
          console.warn(`Failed to fetch image: ${item.imageFileName}`);
        }

        // Fetch and add the text file to the folder
        const textResponse = await fetch(item.textFileName);
        if (textResponse.ok) {
          const textContent = await textResponse.text();
          itemFolder.file(`description.txt`, textContent);
        } else {
          console.warn(`Failed to fetch text: ${item.textFileName}`);
        }
      } catch (error) {
        console.error('Error processing item:', error);
      }
    }

    // Generate and download the zip file
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
