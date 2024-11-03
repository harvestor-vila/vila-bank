library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset with two numerical values with a positive correlation
set.seed(123) # For reproducibility
data_points <- sample(20:50, 1) # Number of data points between 20 and 50
temperature <- sample(60:100, data_points, replace = TRUE) # Temperature in Fahrenheit
humidity <- round(temperature * 0.75 - runif(data_points, min = 0, max = 10)) # Humidity in percentage

weather_data <- data.frame(Temperature = temperature, Humidity = humidity)

# Save the dataset to a txt file
write.table(weather_data, file = "generated_dataset_session_1/scatterplot-weather_and_climate.txt", row.names = FALSE)

# Create a scatterplot
scatterplot <- ggplot(weather_data, aes(x = Temperature, y = Humidity)) +
  geom_point(color = "blue") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), # Center the title
        plot.margin = margin(1, 1, 1, 1, "cm")) + # Set margins
  labs(title = "Scatterplot of Temperature vs Humidity",
       x = "Temperature (°F)",
       y = "Humidity (%)")

# Save the scatterplot as a png file
ggsave("generated_vis_session_1/scatterplot-weather_and_climate.png", scatterplot, width = 8, height = 6, units = "in")