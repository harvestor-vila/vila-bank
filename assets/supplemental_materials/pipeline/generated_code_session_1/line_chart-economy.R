library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
data_points <- 20
years <- seq(2000, by = 1, length.out = data_points)
gdp_growth <- sample(0:10, data_points, replace = TRUE) # Random GDP growth rates with no trend

economy_data <- data.frame(Year = years, GDP_Growth = gdp_growth)

# Save the dataset to a txt file
write.table(economy_data, file = "generated_dataset_session_1/line_chart-economy.txt", row.names = FALSE, col.names = TRUE)

# Create the line chart visualization
line_chart <- ggplot(economy_data, aes(x = Year, y = GDP_Growth)) +
  geom_line() +
  geom_point() +
  labs(title = "Annual GDP Growth Rates", x = "Year", y = "GDP Growth (%)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the line chart as a png file
ggsave("generated_vis_session_1/line_chart-economy.png", line_chart, width = 8, height = 6)