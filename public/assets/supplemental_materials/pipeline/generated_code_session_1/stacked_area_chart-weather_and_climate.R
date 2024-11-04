library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
days <- seq(1, 20) # Assuming 20 days for the dataset
temperature <- sample(15:30, 20, replace = TRUE) # Temperature values
precipitation <- sample(0:10, 20, replace = TRUE) # Precipitation values
wind_speed <- sample(5:20, 20, replace = TRUE) # Wind speed values

weather_data <- data.frame(
  Day = days,
  Temperature = temperature,
  Precipitation = precipitation,
  WindSpeed = wind_speed
)

# Save the dataset to a txt file
write.table(weather_data, file = "generated_dataset_session_1/stacked_area_chart-weather_and_climate.txt", row.names = FALSE, sep = "\t")

# Reshape the data for stacked area chart
weather_data_long <- weather_data %>%
  pivot_longer(cols = -Day, names_to = "Variable", values_to = "Value")

# Create the stacked area chart
stacked_area_chart <- ggplot(weather_data_long, aes(x = Day, y = Value, fill = Variable)) +
  geom_area(position = 'stack') +
  scale_fill_brewer(palette = "Set3") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(10, 10, 10, 10),
        legend.position = "bottom") +
  labs(title = "Weather and Climate Data Over 20 Days",
       x = "Day",
       y = "Value",
       fill = "Variable")

# Save the visualization to a png file
ggsave("generated_vis_session_1/stacked_area_chart-weather_and_climate.png", stacked_area_chart, width = 10, height = 6, units = "in")