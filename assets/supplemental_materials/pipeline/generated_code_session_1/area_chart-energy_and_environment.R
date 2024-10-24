library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset with a decreasing trend
set.seed(123) # For reproducibility
data_points <- 20
values <- round(runif(data_points, min=100, max=1000))
values <- sort(values, decreasing = TRUE)
years <- seq(2000, by = 1, length.out = data_points)

energy_env_data <- data.frame(Year = years, EnergyConsumption = values)

# Save the dataset to a txt file
write.table(energy_env_data, file = "generated_dataset_session_1/area_chart-energy_and_environment.txt", row.names = FALSE, col.names = TRUE)

# Create an area chart visualization
ggplot(energy_env_data, aes(x = Year, y = EnergyConsumption)) +
  geom_area(fill = "skyblue", alpha = 0.5) +
  labs(title = "Energy Consumption Over Time", x = "Year", y = "Energy Consumption (GWh)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "none") +
  scale_x_continuous(breaks = energy_env_data$Year)

# Save the visualization to a png file
ggsave("generated_vis_session_1/area_chart-energy_and_environment.png", width = 8, height = 6, units = "in")