library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
num_data_points <- sample(5:8, 1) # Number of data points between 5 and 8

# Generate data with negative correlation and whole numbers
innovation_score <- round(runif(num_data_points, 50, 100))
research_budget <- round((100 - (innovation_score - 50)) * runif(num_data_points, 1, 2))
market_impact <- round(runif(num_data_points, 10, 50))

# Combine into a data frame
dataset <- data.frame(
  InnovationScore = innovation_score,
  ResearchBudget = research_budget,
  MarketImpact = market_impact
)

# Save the dataset to a txt file
write.table(dataset, file = "generated_dataset_session_1/bubble_chart-innovation.txt", row.names = FALSE)

# Create the bubble chart
bubble_chart <- ggplot(dataset, aes(x = InnovationScore, y = ResearchBudget, size = MarketImpact)) +
  geom_point(aes(color = as.factor(InnovationScore)), alpha = 0.7) +
  scale_size_continuous(range = c(3, 15)) + # Adjust bubble sizes
  labs(title = "Innovation vs. Research Budget Impact Analysis",
       x = "Innovation Score",
       y = "Research Budget (in thousands)",
       size = "Market Impact",
       color = "Innovation Score") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "right",
        legend.box = "vertical") +
  guides(color = guide_legend(override.aes = list(size = 6))) # Ensure that legend is not overcrowded

# Save the bubble chart as a PNG file
ggsave("generated_vis_session_1/bubble_chart-innovation.png", bubble_chart, width = 8, height = 6, dpi = 300)