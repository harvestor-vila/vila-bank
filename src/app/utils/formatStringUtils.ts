/**
 * Maps VisualizationTask enum values to their formatted display strings
 * Converts strings like "make_comparisons" to "Make Comparisons"
 * 
 * @param {string} task - The task string to format
 * @returns {string} Formatted task string
 */
export function formatTaskString(task: string): string {
    // Special case mappings for specific tasks that need custom formatting
    const specialCases: Record<string, string> = {
      'describe_the_topic_of_the_visualization': 'Describe Topic',
      'estimate_the_difference_between_two_values_of_the_same_type': 'Estimate Difference',
      'estimate_the_ratio_of_one_value_to_another_value_of_the_same_type': 'Estimate Ratio',
      'estimate_the_average_of_multiple_values_of_the_same_type': 'Estimate Average',
      'describe_trend_or_correlation': 'Describe Trend',
      'describe_the_characteristics_of_an_alternative_chart_type': 'Describe Chart Characteristics',
      'judge_which_visualization_design_is_more_appropriate_for_a_task': 'Judge Visualization Design',
      'judge_which_task_this_visualization_design_best_supports': 'Judge Task Support'
    };
  
    // Check if task has a special case mapping
    if (specialCases[task]) {
      return specialCases[task];
    }
  
    // For regular cases, split by underscore, capitalize each word, and join with space
    return task
      .split('_')
      .map(word => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
      .join(' ');
}

/**
 * Maps VisualizationContext enum values to their formatted display strings
 * Converts strings like "health" to "Health"
 * 
 * @param {string} context - The context string to format
 * @returns {string} Formatted context string
 */
export const formatEnumValue = (value: string) => {
    return value
      .split('_')
      .map(word => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
      .join(' ');
  };