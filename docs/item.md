# Item Component

## Overview
The Item component is a React component that displays a visualization item consisting of an image, a question, multiple choice options, and an answer. It's designed to work with educational or assessment content related to data visualization.

## Features
- Displays visualization images with error handling
- Loads and parses question text, choices, and answers from a text file
- Responsive layout with proper spacing and styling
- Graceful error handling for both image and text content

## Props
The component accepts the following props:

| Prop | Type | Description |
|------|------|-------------|
| chartType | ChartType | The type of chart being displayed (e.g., bar, line, pie) |
| task | VisualizationTask | The visualization task associated with the item |
| context | VisualizationContext | The context in which the visualization is being used |

## State Management
The component manages several pieces of state:
- `question` (string): Stores the question text
- `choices` (string[]): Stores the multiple choice options
- `answer` (string): Stores the correct answer
- `imageError` (boolean): Tracks whether the image failed to load

## File Structure
The component expects files to be organized in the following structure:
```
/public
  /candidate_bank
    /1404_textual_component
      /{chartType}-{task}-{context}.txt
    /108_visualization_component
      /{chartType}-{context}.png
```

## Text File Format
The component expects text files to follow this format:
```
part 1: [question text]
part 2:
[choice 1]
[choice 2]
[choice 3]
...
part 3: [answer]
```

## Usage Example
```tsx
import { Item } from './components';

function ExampleUsage() {
  return (
    <Item
      chartType="BAR_CHART"
      task="COMPARE_VALUES"
      context="BUSINESS"
    />
  );
}
```

## Error Handling
The component implements error handling for:
1. Failed image loads
2. Failed text content fetching
3. Invalid text file formatting
4. Missing content

## Styling
The component uses Tailwind CSS classes for styling and includes:
- Responsive image container with fixed height
- Proper spacing between elements
- Background colors for content sections
- Bold headers for different content sections

## Dependencies
- React
- Next.js (for Image component)
- Tailwind CSS (for styling)

## Performance Considerations
- Uses Next.js Image component with priority loading
- Implements proper error boundaries
- Minimal re-renders through proper state management
- Efficient text parsing implementation

## Accessibility
- Proper alt text for images
- Semantic HTML structure
- Clear visual hierarchy
- Readable text contrast

## Future Improvements
Potential enhancements could include:
1. Adding loading states for text content
2. Implementing retry mechanisms for failed loads
3. Adding animation for content transitions
4. Implementing zoom functionality for images
5. Adding keyboard navigation for choices