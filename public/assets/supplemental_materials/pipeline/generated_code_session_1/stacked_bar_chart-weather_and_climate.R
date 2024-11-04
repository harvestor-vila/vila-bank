library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
weather_data <- tibble(
  City = rep(c("CityA", "CityB", "CityC", "CityD", "CityE", "CityF", "CityG", "CityH"), each = 5),
  Climate_Factor = rep(c("Precipitation", "Humidity", "Wind", "Temperature", "Sunshine"), times = 8),
  Value = sample(20:100, 40, replace = TRUE) # Random whole numbers between 20 and 100
)

# Save the dataset to a txt file
write.table(weather_data, file = "generated_dataset_session_1/stacked_bar_chart-weather_and_climate.txt", row.names = FALSE, sep = "\t")

# Create a stacked bar chart
ggplot(weather_data, aes(x = City, y = Value, fill = Climate_Factor)) +
  geom_bar(stat = "identity") +
  labs(title = "Weather and Climate Factors by City", x = "City", y = "Value") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "bottom",
        plot.margin = margin(1, 1, 1, 1, "cm")) +
  scale_fill_brewer(palette = "Set3") # To avoid overcrowding colors

# Save the visualization to a png file
ggsave("generated_vis_session_1/stacked_bar_chart-weather_and_climate.png", width = 10, height = 6, units = "in")