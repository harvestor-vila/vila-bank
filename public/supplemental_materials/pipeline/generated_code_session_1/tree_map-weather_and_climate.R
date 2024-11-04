library(ggplot2)
library(tidyverse)
library(dplyr)
library(treemapify)

# Create a synthetic dataset
set.seed(123) # for reproducibility
categories <- c("Temperature", "Precipitation", "Wind")
subcategories <- c("High", "Moderate", "Low")
combinations <- expand.grid(Category = categories, Subcategory = subcategories)
combinations <- combinations %>% filter(!(Category == "Wind" & Subcategory == "Low")) # Ensure we have less than 15 data points

# Assign random percentages ensuring they sum to 100 and no value is more than 80
set.seed(123)
values <- runif(nrow(combinations) - 1, min = 1, max = 20)
remaining_value <- 100 - sum(values)
values <- c(values, remaining_value)
values <- ifelse(values > 80, 80, values)
values <- round(values / sum(values) * 100)
combinations$Percentage <- values

# Save the dataset to a text file
write.table(combinations, file = "generated_dataset_session_1/tree_map-weather_and_climate.txt", row.names = FALSE, sep = "\t")

# Create the tree map visualization
gg <- ggplot(combinations, aes(area = Percentage, fill = Category, label = Subcategory, subgroup = Category)) +
  geom_treemap(colour = "black") +
  geom_treemap_text(grow = FALSE, reflow = TRUE) +
  theme(legend.position = "right") +
  labs(title = "Weather and Climate Data", fill = "Category")

# Save the tree map visualization to a PNG file
ggsave("generated_vis_session_1/tree_map-weather_and_climate.png", plot = gg, width = 10, height = 8)

# The image is saved and not displayed as per the instructions