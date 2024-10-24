library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset
set.seed(123) # For reproducibility
n <- sample(20:50, 1) # Number of data points between 20 and 50
energy_consumption <- sample(100:500, n, replace = TRUE) # Energy consumption in MWh
carbon_emission <- sample(200:1000, n, replace = TRUE) # Carbon emission in metric tons

# Create a dataframe
dataset <- data.frame(EnergyConsumption = energy_consumption, CarbonEmission = carbon_emission)

# Save the dataset to a txt file
write.table(dataset, file = "generated_dataset_session_1/scatterplot-energy_and_environment.txt", row.names = FALSE)

# Create the scatterplot
scatterplot <- ggplot(dataset, aes(x = EnergyConsumption, y = CarbonEmission)) +
  geom_point(color = "blue") +
  labs(title = "Energy Consumption vs. Carbon Emission",
       x = "Energy Consumption (MWh)",
       y = "Carbon Emission (metric tons)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the scatterplot as a PNG image
ggsave("generated_vis_session_1/scatterplot-energy_and_environment.png", scatterplot, width = 10, height = 6, units = "in")