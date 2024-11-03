library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset with a decreasing trend
set.seed(123) # For reproducibility
data_points <- 20
years <- seq(2000, by = 1, length.out = data_points)
innovation_scores <- round(runif(data_points, min = 100, max = 1000))
innovation_scores <- sort(innovation_scores, decreasing = TRUE)
dataset <- data.frame(Year = years, Innovation_Score = innovation_scores)

# Save the dataset to a txt file
write.table(dataset, file = "generated_dataset_session_1/line_chart-innovation.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create a line chart visualization
line_chart <- ggplot(dataset, aes(x = Year, y = Innovation_Score)) +
  geom_line(group = 1, color = "blue") +
  geom_point(size = 2, color = "red") +
  labs(title = "Innovation Score Over Years", x = "Year", y = "Innovation Score") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(5.5, 5.5, 5.5, 5.5),
        legend.position = "none")

# Save the line chart visualization as a png file
ggsave("generated_vis_session_1/line_chart-innovation.png", line_chart, width = 8, height = 6, units = "in")