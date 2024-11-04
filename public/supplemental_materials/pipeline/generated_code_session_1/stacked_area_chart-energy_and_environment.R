library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
data_points <- 20
groups <- c("Solar", "Wind", "Hydro", "Nuclear", "Fossil")
years <- seq(2000, by = 1, length.out = data_points)

energy_data <- expand.grid(Year = years, Source = groups) %>%
  mutate(Value = sample(50:500, size = n(), replace = TRUE)) %>%
  arrange(Source, Year)

# Save the dataset to a txt file
write.table(energy_data, file = "generated_dataset_session_1/stacked_area_chart-energy_and_environment.txt", row.names = FALSE, sep = "\t")

# Create a stacked area chart
ggplot(energy_data, aes(x = Year, y = Value, fill = Source)) +
  geom_area(position = 'stack') +
  scale_fill_brewer(palette = "Spectral") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "bottom") +
  labs(title = "Energy Production by Source Over Time",
       x = "Year",
       y = "Energy Production (GWh)",
       fill = "Source")

# Save the visualization to a png file
ggsave("generated_vis_session_1/stacked_area_chart-energy_and_environment.png", width = 10, height = 6, units = "in")