library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # for reproducibility
data_points <- sample(5:8, 1) # number of data points
country_names <- c("Alberia", "Borland", "Cyprum", "Deltana", "Ephoria", "Fernland", "Grevia", "Hestoria")
countries <- sample(country_names, data_points)

# Generate data with negative correlation
energy_consumption <- sample(100:200, data_points) # in terawatt-hours
co2_emissions <- round((1 / runif(data_points, min = 0.005, max = 0.01)) * 1000 - energy_consumption) # in million metric tons
renewable_percentage <- sample(10:60, data_points) # percentage of renewable energy

# Create a dataframe
dataset <- data.frame(
  Country = countries,
  EnergyConsumption = energy_consumption,
  CO2Emissions = co2_emissions,
  RenewablePercentage = renewable_percentage
)

# Save the dataset
write.table(dataset, file = "generated_dataset_session_1/bubble_chart-energy_and_environment.txt", row.names = FALSE, sep = "\t")

# Create the bubble chart
bubble_chart <- ggplot(dataset, aes(x = EnergyConsumption, y = CO2Emissions, size = RenewablePercentage, color = Country)) +
  geom_point(alpha = 0.7) +
  scale_size_continuous(range = c(3, 12)) +
  labs(title = "Energy Consumption vs. CO2 Emissions by Country",
       x = "Energy Consumption (TWh)",
       y = "CO2 Emissions (Million Metric Tons)",
       size = "Renewable Energy (%)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "right",
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the bubble chart image
ggsave("generated_vis_session_1/bubble_chart-energy_and_environment.png", bubble_chart, width = 8, height = 6, dpi = 300)