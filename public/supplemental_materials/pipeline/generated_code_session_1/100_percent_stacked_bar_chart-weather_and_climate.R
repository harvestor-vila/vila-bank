library(ggplot2)
library(tidyverse)
library(dplyr)
library(scales)

# Create a synthetic dataset
set.seed(123) # For reproducibility
weather_types <- c("Sunny", "Cloudy", "Rainy", "Snowy", "Windy")
locations <- c("Location_A", "Location_B", "Location_C", "Location_D")

data <- expand.grid(Location = locations, Weather = weather_types) %>%
  mutate(Percentage = sample(1:100, size = n(), replace = TRUE)) %>%
  group_by(Location) %>%
  mutate(Percentage = round(Percentage / sum(Percentage), 2)) %>%
  ungroup()

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/100_percent_stacked_bar_chart-weather_and_climate.txt", row.names = FALSE, sep = "\t")

# Create a 100 percent stacked bar chart
ggplot(data, aes(x = Location, y = Percentage, fill = Weather)) +
  geom_bar(stat = "identity", position = "fill") +
  scale_y_continuous(labels = percent_format(), breaks = seq(0, 1, 0.2)) +
  labs(title = "Weather Distribution by Location", x = "Location", y = "Percentage") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(10, 10, 10, 10),
        legend.position = "bottom")

# Save the visualization to a png file
ggsave("generated_vis_session_1/100_percent_stacked_bar_chart-weather_and_climate.png", width = 8, height = 6)