library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
data_points <- 20
energy_data <- tibble(
  Time = 1:data_points,
  EnergyConsumption = sample(100:200, data_points, replace = TRUE) # Random whole numbers
)

# Save the dataset to a txt file
write.table(energy_data, file = "generated_dataset_session_1/line_chart-energy_and_environment.txt", row.names = FALSE)

# Create the line chart visualization
line_chart <- ggplot(energy_data, aes(x = Time, y = EnergyConsumption)) +
  geom_line() +
  geom_point() +
  labs(title = "Energy Consumption Over Time",
       x = "Time (Arbitrary Units)",
       y = "Energy Consumption (GWh)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the line chart visualization as a PNG file
ggsave("generated_vis_session_1/line_chart-energy_and_environment.png", line_chart, width = 8, height = 6, units = "in")

# The image is saved and not displayed as per the instructions.