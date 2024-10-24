library(ggplot2)
library(tidyverse)
library(dplyr)
library(treemapify)

# Create synthetic dataset
set.seed(123) # For reproducibility
categories <- c("Renewable Energy", "Non-Renewable Energy", "Pollution Control", "Conservation Efforts")
subcategories <- list(
  c("Solar", "Wind", "Hydro"),
  c("Coal", "Oil", "Natural Gas"),
  c("Air Quality", "Water Treatment"),
  c("Wildlife Protection", "Forest Management")
)

# Expand categories into subcategories and assign random percentages
data_list <- map2(categories, subcategories, ~ data.frame(Category = .x, Subcategory = .y))
data <- bind_rows(data_list)
data$Value <- round(runif(nrow(data), 1, 20))
data$Value <- round(100 * data$Value / sum(data$Value))

# Ensure no single value is more than 80%
while(any(data$Value > 80)) {
  data$Value <- round(runif(nrow(data), 1, 20))
  data$Value <- round(100 * data$Value / sum(data$Value))
}

# Save dataset to txt file
write.table(data, file = "generated_dataset_session_1/tree_map-energy_and_environment.txt", row.names = FALSE, sep = "\t")

# Create tree map visualization
ggplot(data, aes(area = Value, fill = Category, label = Subcategory, subgroup = Category)) +
  geom_treemap() +
  geom_treemap_text(grow = FALSE, reflow = TRUE) +
  theme(legend.position = "right") +
  labs(title = "Energy and Environment", fill = "Category") +
  theme(plot.title = element_text(hjust = 0.5), plot.margin = margin(1, 1, 1, 1, "cm"))

# Save tree map visualization to png file
ggsave("generated_vis_session_1/tree_map-energy_and_environment.png", width = 10, height = 8, units = "in")