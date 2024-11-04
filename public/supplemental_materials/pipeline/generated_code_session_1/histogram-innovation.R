library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset with right-skewed distribution
set.seed(123) # For reproducibility
innovation_scores <- rpois(100, lambda = 5) + rexp(100, rate = 0.2)
innovation_scores <- round(innovation_scores)
innovation_data <- data.frame(InnovationScore = innovation_scores)

# Save the dataset to a txt file
write.table(innovation_data, file = "generated_dataset_session_1/histogram-innovation.txt", row.names = FALSE)

# Create the histogram visualization
histogram_plot <- ggplot(innovation_data, aes(x = InnovationScore)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black") +
  labs(title = "Distribution of Innovation Scores",
       x = "Innovation Score",
       y = "Number of Observations") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(5.5, 5.5, 5.5, 5.5))

# Save the histogram visualization to a png file
ggsave("generated_vis_session_1/histogram-innovation.png", histogram_plot, width = 10, height = 8)