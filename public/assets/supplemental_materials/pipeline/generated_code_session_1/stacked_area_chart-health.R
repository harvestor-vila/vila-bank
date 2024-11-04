library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset
set.seed(123) # For reproducibility
groups <- c("Cardiovascular", "Respiratory", "Infectious", "Neurological")
years <- 2001:2020
data_points <- length(years)

# Create a dataframe with the synthetic data
health_data <- expand.grid(Year = years, Group = groups) %>%
  mutate(Value = sample(100:500, size = n(), replace = TRUE)) %>%
  arrange(Year, Group)

# Save the dataset to a text file
write.table(health_data, file = "generated_dataset_session_1/stacked_area_chart-health.txt", row.names = FALSE, sep = "\t")

# Create the stacked area chart
ggplot(health_data, aes(x = Year, y = Value, fill = Group)) +
  geom_area(position = 'stack') +
  scale_fill_brewer(palette = "Pastel1") +
  theme_minimal() +
  theme(legend.position = "bottom",
        plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm")) +
  labs(title = "Health Trends Over Time",
       x = "Year",
       y = "Number of Cases",
       fill = "Condition")

# Save the visualization to a PNG file
ggsave("generated_vis_session_1/stacked_area_chart-health.png", width = 10, height = 6, units = "in")