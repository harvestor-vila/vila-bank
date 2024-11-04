library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset
set.seed(123) # For reproducibility
days <- 1:20
temperatures <- round(runif(20, min=50, max=100)) # Random whole numbers between 50 and 100
weather_data <- data.frame(Day = days, Temperature = temperatures)

# Save the dataset to a txt file
write.table(weather_data, file = "generated_dataset_session_1/line_chart-weather_and_climate.txt", row.names = FALSE, col.names = TRUE)

# Create a line chart visualization
ggplot(weather_data, aes(x = Day, y = Temperature)) +
  geom_line() +
  geom_point() +
  labs(title = "Daily Average Temperature Over 20 Days", x = "Day", y = "Temperature (°F)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), # Center the title
        plot.margin = margin(1, 1, 1, 1, "cm")) # Set margins

# Save the visualization as a png file
ggsave("generated_vis_session_1/line_chart-weather_and_climate.png", width = 8, height = 6, units = "in")