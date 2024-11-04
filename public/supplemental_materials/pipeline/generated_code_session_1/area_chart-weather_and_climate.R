library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset
set.seed(123) # For reproducibility
days <- 1:20
temperature <- round(runif(20, min=50, max=100))
temperature <- cummax(temperature) # Ensure an increasing trend

weather_data <- data.frame(Day = days, AverageTemperature = temperature)

# Save the dataset
write.table(weather_data, file = "generated_dataset_session_1/area_chart-weather_and_climate.txt", row.names = FALSE)

# Create an area chart
ggplot(weather_data, aes(x = Day, y = AverageTemperature)) +
  geom_area(fill = "skyblue", alpha = 0.5) +
  geom_line(color = "blue") +
  labs(title = "Average Daily Temperature Over 20 Days", x = "Day", y = "Average Temperature (°F)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the visualization
ggsave("generated_vis_session_1/area_chart-weather_and_climate.png", width = 8, height = 6)