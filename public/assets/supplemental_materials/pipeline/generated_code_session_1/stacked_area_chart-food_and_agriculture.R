library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
years <- 2000:2019
crops <- c("Wheat", "Rice", "Corn", "Soybeans")
data_points <- length(years)

# Generate random whole number values for each crop per year
values <- matrix(sample(50:200, length(crops) * data_points, replace = TRUE), ncol = data_points)
colnames(values) <- years
rownames(values) <- crops

# Convert the matrix to a data frame for ggplot
dataset <- as.data.frame(values)
dataset <- tibble(Year = rep(years, times = length(crops)),
                  Crop = rep(crops, each = data_points),
                  Production = as.vector(as.matrix(dataset)))

# Save the dataset to a txt file
write.table(dataset, file = "generated_dataset_session_1/stacked_area_chart-food_and_agriculture.txt", row.names = FALSE, sep = "\t")

# Create the stacked area chart
ggplot(dataset, aes(x = Year, y = Production, fill = Crop)) +
  geom_area(position = 'stack') +
  labs(title = "Food and Agriculture Production Over Years",
       x = "Year",
       y = "Production (in tonnes)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "right")

# Save the visualization to a png file
ggsave("generated_vis_session_1/stacked_area_chart-food_and_agriculture.png", width = 10, height = 6, units = "in")