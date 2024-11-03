library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
data_points <- sample(5:8, 1) # Number of data points between 5 and 8
temperature <- sample(60:100, data_points, replace = TRUE) # Temperature in Fahrenheit
humidity <- round((1 - scale(temperature)) * 100) # Humidity in percentage, negatively correlated with temperature
precipitation <- sample(0:20, data_points, replace = TRUE) # Precipitation in mm
location <- paste("Location", LETTERS[1:data_points]) # Location names

dataset <- data.frame(Location = location,
                      Temperature = temperature,
                      Humidity = humidity,
                      Precipitation = precipitation)

# Save the dataset to a text file
write.table(dataset, file = "generated_dataset_session_1/bubble_chart-weather_and_climate.txt", row.names = FALSE, sep = "\t")

# Create the bubble chart
ggplot(dataset, aes(x = Temperature, y = Humidity, size = Precipitation, color = Location)) +
  geom_point(alpha = 0.7) +
  scale_size_continuous(range = c(3, 12)) + # Adjust the size range to prevent too much overlap
  labs(title = "Weather and Climate Bubble Chart",
       x = "Temperature (°F)",
       y = "Humidity (%)",
       size = "Precipitation (mm)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "right") +
  guides(color = guide_legend(override.aes = list(size = 5))) # Adjust legend appearance

# Save the bubble chart as a PNG image
ggsave("generated_vis_session_1/bubble_chart-weather_and_climate.png", width = 8, height = 6, units = "in")