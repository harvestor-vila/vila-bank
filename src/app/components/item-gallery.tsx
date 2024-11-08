'use client';
import { useEffect, useState } from 'react';
import { ChartType, VisualizationTask, VisualizationContext, VisualizationItem } from '@/app/utils/types';
import { fetchVisualizationItems, getFilterOptions, filterItems, formatEnumValue } from '@/app/utils/visualizationUtils';
import { ChevronFirst, ChevronLast } from 'lucide-react';
import ItemList from './item-list';
import Item from './item';

const ITEMS_PER_PAGE = 24;
const VISIBLE_PAGE_BUTTONS = 5;

const ItemGallery = () => {
  const [items, setItems] = useState<VisualizationItem[]>([]);
  const [filteredItems, setFilteredItems] = useState<VisualizationItem[]>([]);
  const [currentPage, setCurrentPage] = useState(1);
  const [filters, setFilters] = useState({
    chartType: null as ChartType | null,
    task: null as VisualizationTask | null,
    context: null as VisualizationContext | null
  });
  const [filterOptions, setFilterOptions] = useState({
    chartTypes: [] as ChartType[],
    tasks: [] as VisualizationTask[],
    contexts: [] as VisualizationContext[]
  });
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const loadItems = async () => {
      const fetchedItems = await fetchVisualizationItems();
      setItems(fetchedItems);
      setFilteredItems(fetchedItems);
      setFilterOptions(getFilterOptions(fetchedItems));
      setIsLoading(false);
    };

    loadItems();
  }, []);

  useEffect(() => {
    setFilteredItems(filterItems(items, filters));
    setCurrentPage(1);
  }, [items, filters]);

  const handleFilterChange = (
    filterType: 'chartType' | 'task' | 'context',
    value: string | null
  ) => {
    setFilters(prev => ({
      ...prev,
      [filterType]: value ? value : null
    }));
  };

  // Pagination calculations
  const totalPages = Math.ceil(filteredItems.length / ITEMS_PER_PAGE);
  const startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
  const endIndex = startIndex + ITEMS_PER_PAGE;
  const currentItems = filteredItems.slice(startIndex, endIndex);

  // Calculate visible page numbers
  const getVisiblePageNumbers = () => {
    let start = Math.max(currentPage - Math.floor(VISIBLE_PAGE_BUTTONS / 2), 1);
    let end = start + VISIBLE_PAGE_BUTTONS - 1;

    if (end > totalPages) {
      end = totalPages;
      start = Math.max(end - VISIBLE_PAGE_BUTTONS + 1, 1);
    }

    return Array.from({ length: end - start + 1 }, (_, i) => start + i);
  };

  const handlePageChange = (pageNumber: number) => {
    setCurrentPage(pageNumber);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-500" />
      </div>
    );
  }

  return (
    <div className="p-8">
      {/* Filters */}
      <div className="mb-8 grid grid-cols-1 md:grid-cols-3 gap-4">
        {/* Chart Type Filter */}
        <div className="flex flex-col">
          <label className="text-sm font-medium mb-2">Chart Type</label>
          <select
            className="border rounded-lg p-2"
            onChange={(e) => handleFilterChange('chartType', e.target.value || null)}
            value={filters.chartType || ''}
          >
            <option value="">All Chart Types</option>
            {filterOptions.chartTypes.map(type => (
              <option key={type} value={type}>
                {formatEnumValue(type)}
              </option>
            ))}
          </select>
        </div>

        {/* Task Filter */}
        <div className="flex flex-col">
          <label className="text-sm font-medium mb-2">Task</label>
          <select
            className="border rounded-lg p-2"
            onChange={(e) => handleFilterChange('task', e.target.value || null)}
            value={filters.task || ''}
          >
            <option value="">All Tasks</option>
            {filterOptions.tasks.map(task => (
              <option key={task} value={task}>
                {formatEnumValue(task)}
              </option>
            ))}
          </select>
        </div>

        {/* Context Filter */}
        <div className="flex flex-col">
          <label className="text-sm font-medium mb-2">Context</label>
          <select
            className="border rounded-lg p-2"
            onChange={(e) => handleFilterChange('context', e.target.value || null)}
            value={filters.context || ''}
          >
            <option value="">All Contexts</option>
            {filterOptions.contexts.map(context => (
              <option key={context} value={context}>
                {formatEnumValue(context)}
              </option>
            ))}
          </select>
        </div>
      </div>

      {/* Results Count */}
      <div className="mb-4">
        {filteredItems.length > 0 && (<p className="text-gray-600">
          Showing {startIndex + 1}-{Math.min(endIndex, filteredItems.length)} of {filteredItems.length} items
        </p>)}
      </div>

      {/* Displaying Items */}
      {filteredItems.length === 0 ? (
        <div className="flex flex-col items-center justify-center h-64">
          <p className="text-xl text-gray-500 font-medium mb-2">No items available</p>
          <p className="text-gray-400">Try adjusting your filters :(</p>
          <button
            onClick={() => setFilters({
              chartType: null,
              task: null,
              context: null
            })}
            className="mt-4 px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition-colors"
          >
            Reset Filters
          </button>
        </div>
      ) : filteredItems.length === 1 ? (
        <Item chartType={filteredItems[0].chartType} task={filteredItems[0].task} context={filteredItems[0].context} />
      ) : (
        <>
          <ItemList items={currentItems} />
          
          {/* Modified Pagination Controls */}
          {totalPages > 1 && (
            <div className="mt-8 flex justify-center gap-2">
              {/* First Page Button */}
              <button
                onClick={() => handlePageChange(1)}
                disabled={currentPage === 1}
                className="px-3 py-2 border rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50"
                aria-label="First page"
              >
                <ChevronFirst className="h-4 w-4" />
              </button>

              {/* Previous Button */}
              <button
                onClick={() => handlePageChange(currentPage - 1)}
                disabled={currentPage === 1}
                className="px-4 py-2 border rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50"
              >
                Previous
              </button>

              {/* Page Numbers */}
              {getVisiblePageNumbers().map((page) => (
                <button
                  key={page}
                  onClick={() => handlePageChange(page)}
                  className={`px-4 py-2 border rounded-lg hover:bg-gray-50 ${
                    currentPage === page ? 'bg-blue-500 text-white hover:bg-blue-600' : ''
                  }`}
                >
                  {page}
                </button>
              ))}

              {/* Next Button */}
              <button
                onClick={() => handlePageChange(currentPage + 1)}
                disabled={currentPage === totalPages}
                className="px-4 py-2 border rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50"
              >
                Next
              </button>

              {/* Last Page Button */}
              <button
                onClick={() => handlePageChange(totalPages)}
                disabled={currentPage === totalPages}
                className="px-3 py-2 border rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50"
                aria-label="Last page"
              >
                <ChevronLast className="h-4 w-4" />
              </button>
            </div>
          )}
        </>
      )}
    </div>
  );
};

export default ItemGallery;