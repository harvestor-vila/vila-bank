import { ChevronFirst, ChevronLast } from 'lucide-react';

interface PaginationProps {
  currentPage: number;
  totalPages: number;
  visiblePageButtons?: number;
  onPageChange: (page: number) => void;
}

const Pagination = ({ 
  currentPage, 
  totalPages, 
  visiblePageButtons = 5,
  onPageChange 
}: PaginationProps) => {
  // Calculate visible page numbers
  const getVisiblePageNumbers = () => {
    let start = Math.max(currentPage - Math.floor(visiblePageButtons / 2), 1);
    let end = start + visiblePageButtons - 1;

    if (end > totalPages) {
      end = totalPages;
      start = Math.max(end - visiblePageButtons + 1, 1);
    }

    return Array.from({ length: end - start + 1 }, (_, i) => start + i);
  };

  if (totalPages <= 1) return null;

  return (
    <div className="flex justify-center gap-1 sm:gap-2">
      {/* First Page Button */}
      <button
        onClick={() => onPageChange(1)}
        disabled={currentPage === 1}
        className="px-1.5 py-1 sm:px-3 sm:py-2 border rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50"
        aria-label="First page"
      >
        <ChevronFirst className="h-3 w-3 sm:h-4 sm:w-4" />
      </button>

      {/* Previous Button */}
      <button
        onClick={() => onPageChange(currentPage - 1)}
        disabled={currentPage === 1}
        className="px-2 py-1 sm:px-4 sm:py-2 border rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50 text-sm sm:text-base"
      >
        Prev
      </button>

      {/* Page Numbers */}
      {getVisiblePageNumbers().map((page) => (
        <button
          key={page}
          onClick={() => onPageChange(page)}
          className={`px-2 py-1 sm:px-4 sm:py-2 border rounded-lg hover:bg-gray-50 text-sm sm:text-base ${
            currentPage === page ? 'bg-[#b2ebf2] hover:bg-[#80deea]' : ''
          }`}
        >
          {page}
        </button>
      ))}

      {/* Next Button */}
      <button
        onClick={() => onPageChange(currentPage + 1)}
        disabled={currentPage === totalPages}
        className="px-2 py-1 sm:px-4 sm:py-2 border rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50 text-sm sm:text-base"
      >
        Next
      </button>

      {/* Last Page Button */}
      <button
        onClick={() => onPageChange(totalPages)}
        disabled={currentPage === totalPages}
        className="px-1.5 py-1 sm:px-3 sm:py-2 border rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50"
        aria-label="Last page"
      >
        <ChevronLast className="h-3 w-3 sm:h-4 sm:w-4" />
      </button>
    </div>
  );
};

export default Pagination;