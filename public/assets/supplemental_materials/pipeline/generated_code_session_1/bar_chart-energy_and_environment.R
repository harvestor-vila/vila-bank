library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
energy_sources <- c("Solar", "Wind", "Hydro", "Nuclear", "Coal", "Natural Gas", "Biomass", "Geothermal")
energy_production <- sample(100:500, length(energy_sources), replace = TRUE) # Random whole numbers
dataset <- data.frame(EnergySource = energy_sources, Production = energy_production)

# Save the dataset to a text file
write.table(dataset, file = "generated_dataset_session_1/bar_chart-energy_and_environment.txt", row.names = FALSE, sep = "\t")

# Create the bar chart
bar_chart <- ggplot(dataset, aes(x = EnergySource, y = Production, fill = I("steelblue"))) +
  geom_bar(stat = "identity") +
  labs(title = "Energy Production by Source", x = "Energy Source", y = "Production (GWh)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(5.5, 5.5, 5.5, 5.5),
        legend.position = "none")

# Save the bar chart as a PNG image
ggsave("generated_vis_session_1/bar_chart-energy_and_environment.png", bar_chart, width = 10, height = 6, units = "in")

# The image is saved and not displayed as per the instructions