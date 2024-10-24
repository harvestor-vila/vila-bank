library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
data_points <- 20
health_data <- tibble(
  Day = 1:data_points,
  Heart_Rate = sample(60:100, data_points, replace = TRUE) # Random whole numbers between 60 and 100
)

# Save the dataset to a txt file
write.table(health_data, file = "generated_dataset_session_1/line_chart-health.txt", row.names = FALSE, col.names = TRUE)

# Create the line chart visualization
line_chart <- ggplot(health_data, aes(x = Day, y = Heart_Rate)) +
  geom_line(color = "blue") +
  geom_point(color = "red") +
  labs(title = "Daily Heart Rate Measurements", x = "Day", y = "Heart Rate (bpm)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(5.5, 5.5, 5.5, 5.5, "points"),
        legend.position = "none")

# Save the line chart as a PNG image
ggsave("generated_vis_session_1/line_chart-health.png", line_chart, width = 8, height = 6, units = "in")

# The image is saved and not displayed as per the instructions