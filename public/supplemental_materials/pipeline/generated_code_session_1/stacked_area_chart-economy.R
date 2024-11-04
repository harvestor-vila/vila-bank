library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset
set.seed(123) # For reproducibility
years <- 2000:2019
sectors <- c("Agriculture", "Manufacturing", "Services", "Construction")
data_points <- length(years)

# Create a dataframe with the synthetic data
economy_data <- expand.grid(Year = years, Sector = sectors) %>%
  mutate(Value = sample(100:500, size = n(), replace = TRUE)) %>%
  arrange(Year, Sector)

# Save the dataset to a txt file
write.table(economy_data, file = "generated_dataset_session_1/stacked_area_chart-economy.txt", row.names = FALSE, sep = "\t")

# Create a stacked area chart
ggplot(economy_data, aes(x = Year, y = Value, fill = Sector)) +
  geom_area(position = 'stack') +
  scale_x_continuous(breaks = years, labels = as.character(years)) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "bottom",
        plot.margin = margin(1, 1, 1, 1, "cm")) +
  labs(title = "Economic Sectors Growth Over Time",
       x = "Year",
       y = "Value (in millions)",
       fill = "Sector")

# Save the visualization to a png file
ggsave("generated_vis_session_1/stacked_area_chart-economy.png", width = 10, height = 6, units = "in")