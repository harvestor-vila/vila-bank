# Load necessary libraries
library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
data_points <- 20
years <- seq(2000, by = 1, length.out = data_points)
approval_ratings <- round(runif(data_points, min = 30, max = 70))
approval_ratings <- sort(approval_ratings, decreasing = TRUE)
politics_data <- data.frame(Year = years, ApprovalRating = approval_ratings)

# Save the dataset to a txt file
write.table(politics_data, file = "generated_dataset_session_1/line_chart-politics.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create the line chart visualization
line_chart <- ggplot(politics_data, aes(x = Year, y = ApprovalRating)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 2) +
  labs(title = "Approval Rating Over Years", x = "Year", y = "Approval Rating (%)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(5.5, 5.5, 5.5, 5.5),
        legend.position = "none")

# Save the visualization as a PNG file
ggsave("generated_vis_session_1/line_chart-politics.png", line_chart, width = 10, height = 6, units = "in")