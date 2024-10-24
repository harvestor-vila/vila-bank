library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset
set.seed(123) # For reproducibility
data <- tibble(
  City = c("Metropolis", "Gotham", "Star City", "Central City", "Coast City", "Midway City", "Ivy Town", "Keystone City"),
  Population = sample(100000:800000, 8, replace = FALSE), # Population in the city
  GDP_Per_Capita = sample(30000:100000, 8, replace = FALSE), # GDP per capita in USD
  Median_Age = sample(25:45, 8, replace = FALSE) # Median age of the population
)

# Save the dataset to a text file
write.table(data, file = "generated_dataset_session_1/bubble_chart-population_and_demography.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create a bubble chart
ggplot(data, aes(x = GDP_Per_Capita, y = Population, size = Median_Age, color = City)) +
  geom_point(alpha = 0.7) +
  scale_size_continuous(range = c(3, 12)) + # Adjust the size range for better visibility
  labs(title = "Population and Demography Bubble Chart",
       x = "GDP Per Capita (USD)",
       y = "Population",
       size = "Median Age",
       color = "City") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "right") +
  guides(color = guide_legend(override.aes = list(size = 6))) # Adjust legend appearance

# Save the bubble chart as a PNG image
ggsave("generated_vis_session_1/bubble_chart-population_and_demography.png", width = 10, height = 8, units = "in")