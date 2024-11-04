library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset with a symmetric distribution
set.seed(123) # For reproducibility
temperature_values <- rnorm(1000, mean = 70, sd = 10) # Generate normal distribution
temperature_values <- round(temperature_values) # Round to whole numbers
temperature_values <- temperature_values[temperature_values >= 50 & temperature_values <= 90] # Filter for a realistic temperature range

# Create a dataframe
weather_data <- data.frame(DailyAverageTemperature = temperature_values)

# Save the dataset to a txt file
write.table(weather_data, file = "generated_dataset_session_1/histogram-weather_and_climate.txt", row.names = FALSE, col.names = TRUE)

# Create the histogram
histogram_plot <- ggplot(weather_data, aes(x = DailyAverageTemperature)) +
  geom_histogram(binwidth = 2, color = "black", fill = "skyblue") +
  labs(title = "Histogram of Daily Average Temperatures",
       x = "Temperature (°F)",
       y = "Frequency") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the histogram as a png file
ggsave("generated_vis_session_1/histogram-weather_and_climate.png", histogram_plot, width = 10, height = 8, units = "in")

# The code ends here, and the image is saved without displaying it