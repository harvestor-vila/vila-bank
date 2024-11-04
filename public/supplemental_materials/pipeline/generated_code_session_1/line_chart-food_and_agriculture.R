library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset with a decreasing trend
set.seed(123) # For reproducibility
data_points <- 20
years <- seq(2000, by = 1, length.out = data_points)
production <- round(runif(data_points, min = 100, max = 1000))
production <- sort(production, decreasing = TRUE)
dataset <- data.frame(Year = years, Production = production)

# Save the dataset to a txt file
write.table(dataset, file = "generated_dataset_session_1/line_chart-food_and_agriculture.txt", row.names = FALSE, sep = "\t")

# Create a line chart visualization
line_chart <- ggplot(dataset, aes(x = Year, y = Production)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 2) +
  labs(title = "Agricultural Production Over Years", x = "Year", y = "Production (in tons)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the line chart visualization as a png file
ggsave("generated_vis_session_1/line_chart-food_and_agriculture.png", line_chart, width = 8, height = 6, units = "in")

# The image is saved and not displayed as per the instructions