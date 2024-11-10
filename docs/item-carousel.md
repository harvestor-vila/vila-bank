# Carousel Component

## Overview
The Carousel component is a React component that provides a slideshow-like interface for displaying visualization items. It includes navigation controls and a progress indicator, allowing users to browse through a collection of items.

## Features
- Circular navigation (wraps around at ends)
- Previous/Next navigation buttons
- Progress indicator showing current position
- Responsive design
- Accessibility-friendly controls
- Smooth transitions
- Empty state handling

## Props
| Prop | Type | Description | Default |
|------|------|-------------|---------|
| items | Array<CarouselItem> | Array of items to display | Required |
| initialIndex | number | Starting index for carousel | 0 |
| onBackClick | () => void | Optional callback for back navigation | undefined |

### CarouselItem Interface
```typescript
interface CarouselItem {
  chartType: ChartType;
  task: VisualizationTask;
  context: VisualizationContext;
}
```

## Usage Example
```tsx
import { Carousel } from './components';

const items = [
  {
    chartType: "BAR_CHART",
    task: "COMPARE_VALUES",
    context: "BUSINESS"
  },
  // ... more items
];

function ExampleUsage() {
  return (
    <Carousel 
      items={items}
      initialIndex={0}
      onBackClick={() => console.log('Back clicked')}
    />
  );
}
```

## Component Structure
```
Carousel
├── Current Item Display
│   └── Item Component
├── Navigation Controls
│   ├── Previous Button
│   └── Next Button
└── Progress Indicator
```

## Styling
The component uses Tailwind CSS for styling with:
- Fixed maximum width for consistent display
- Rounded corners for visual appeal
- Shadow effects for depth
- Hover states for interactive elements
- Semi-transparent background for progress indicator
- Responsive layout adjustments

## Navigation
- Circular navigation pattern
- Left/right arrow buttons
- Visual feedback on hover
- Keyboard accessibility
- Current position indicator

## Accessibility Features
- ARIA labels for navigation buttons
- Keyboard navigation support
- Clear visual indicators
- Sufficient contrast ratios
- Semantic HTML structure

## Error Handling
- Handles empty item arrays gracefully
- Prevents navigation beyond bounds
- Safe state updates

## Performance Considerations
- Minimal state management
- Efficient re-renders
- Optimized navigation logic
- Smooth transitions

## Dependencies
- React
- Lucide React (for icons)
- Tailwind CSS (for styling)

## State Management
The component manages:
- Current item index
- Navigation state
- Circular navigation logic

## Best Practices
1. Initialize with a valid index
2. Provide meaningful alt text for items
3. Ensure keyboard accessibility
4. Maintain consistent item dimensions
5. Handle empty states appropriately

## Future Improvements
Potential enhancements could include:
1. Touch/swipe navigation support
2. Animation transitions between items
3. Autoplay functionality
4. Thumbnail navigation
5. Custom navigation events
6. Infinite scroll behavior
7. Loading states
8. Zoom functionality
9. Gesture controls
10. Custom transition effects

## Related Components
- Item Component
- Navigation Controls
- Progress Indicator

## Testing Considerations
- Navigation logic
- Empty state handling
- Keyboard accessibility
- Touch interactions
- Responsive behavior