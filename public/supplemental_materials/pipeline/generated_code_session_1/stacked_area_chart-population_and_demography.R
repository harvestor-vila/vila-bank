library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
years <- seq(2000, 2019)
age_groups <- c("0-14", "15-24", "25-64", "65+")
data_points <- length(years)

population_data <- expand.grid(Year = years, Age_Group = age_groups) %>%
  mutate(Population = round(runif(n = n(), min = 1000, max = 100000)))

# Save the dataset to a text file
write.table(population_data, file = "generated_dataset_session_1/stacked_area_chart-population_and_demography.txt", row.names = FALSE, sep = "\t")

# Create a stacked area chart
ggplot(population_data, aes(x = Year, y = Population, fill = Age_Group)) +
  geom_area(position = 'stack') +
  scale_x_continuous(breaks = years, labels = as.character(years)) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "bottom") +
  labs(title = "Population Distribution by Age Group Over Time",
       x = "Year",
       y = "Population",
       fill = "Age Group")

# Save the visualization to a PNG file
ggsave("generated_vis_session_1/stacked_area_chart-population_and_demography.png", width = 10, height = 6, units = "in")