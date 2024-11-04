library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset
set.seed(123) # For reproducibility
number_of_points <- sample(20:50, 1)
innovation_scores <- sample(100:200, number_of_points, replace = TRUE)
research_investment <- sample(1:100, number_of_points, replace = TRUE)

# Create a dataframe
innovation_data <- data.frame(InnovationScores = innovation_scores, ResearchInvestment = research_investment)

# Save the dataset to a txt file
write.table(innovation_data, file = "generated_dataset_session_1/scatterplot-innovation.txt", row.names = FALSE, col.names = TRUE)

# Create the scatterplot
scatterplot <- ggplot(innovation_data, aes(x = ResearchInvestment, y = InnovationScores)) +
  geom_point(color = "blue") +
  labs(title = "Scatterplot of Innovation Scores vs. Research Investment",
       x = "Research Investment (in millions)",
       y = "Innovation Scores") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the scatterplot image
ggsave("generated_vis_session_1/scatterplot-innovation.png", scatterplot, width = 10, height = 6, dpi = 300)