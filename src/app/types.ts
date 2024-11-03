// types.ts
export enum VisualizationTask {
    MAKE_COMPARISONS = "make_comparisons",
    IDENTIFY_RANGE = "identify_range",
    RETRIEVE_VALUE = "retrieve_value",
    LOCATE_VALUE = "locate_value",
    IDENTIFY_LABELS_OF_SCALES = "identify_labels_of_scales",
    DESCRIBE_TOPIC = "describe_the_topic_of_the_visualization",
    ESTIMATE_DIFFERENCE = "estimate_the_difference_between_two_values_of_the_same_type",
    ESTIMATE_RATIO = "estimate_the_ratio_of_one_value_to_another_value_of_the_same_type",
    ESTIMATE_AVERAGE = "estimate_the_average_of_multiple_values_of_the_same_type",
    DESCRIBE_TREND = "describe_trend_or_correlation",
    DESCRIBE_CHARACTERISTICS = "describe_the_characteristics_of_an_alternative_chart_type",
    JUDGE_VISUALIZATION = "judge_which_visualization_design_is_more_appropriate_for_a_task",
    JUDGE_TASK = "judge_which_task_this_visualization_design_best_supports"
  }
  
  export enum ChartType {
    LINE = "line_chart",
    BAR = "bar_chart",
    STACKED_BAR = "stacked_bar_chart",
    HUNDRED_PERCENT_STACKED_BAR = "100_percent_stacked_bar_chart",
    AREA = "area_chart",
    STACKED_AREA = "stacked_area_chart",
    SCATTER = "scatterplot",
    BUBBLE = "bubble_chart",
    PIE = "pie_chart",
    HISTOGRAM = "histogram",
    CHOROPLETH = "choropleth_map",
    TREE = "tree_map"
  }
  
  export enum VisualizationContext {
    HEALTH = "health",
    POPULATION = "population_and_demography",
    ENERGY = "energy_and_environment",
    WEATHER = "weather_and_climate",
    FOOD = "food_and_agriculture",
    ECONOMY = "economy",
    POLITICS = "politics",
    EDUCATION = "education",
    INNOVATION = "innovation"
  }
  
  export interface VisualizationItem {
    chartType: ChartType;
    task: VisualizationTask;
    context: VisualizationContext;
  }