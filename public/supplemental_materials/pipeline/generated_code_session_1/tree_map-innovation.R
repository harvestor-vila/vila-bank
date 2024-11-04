library(ggplot2)
library(tidyverse)
library(dplyr)
library(treemapify)

# Create the synthetic dataset
set.seed(123) # For reproducibility
categories <- c("Technology", "Healthcare", "Energy", "Education")
subcategories <- c("AI", "Robotics", "Biotech", "Pharma", "Renewables", "Oil & Gas", "E-learning", "EdTech")

# Ensure that the sum of all values is 100 and no single value is more than 80
values <- c(15, 10, 20, 5, 12, 8, 15, 15)
dataset <- data.frame(
  Category = rep(categories, each = 2),
  Subcategory = subcategories,
  Percentage = values
)

# Save the dataset to a txt file
write.table(dataset, file = "generated_dataset_session_1/tree_map-innovation.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create the tree map visualization
tree_map <- ggplot(dataset, aes(area = Percentage, fill = Category, label = Subcategory, subgroup = Category)) +
  geom_treemap(colour = "black") +
  geom_treemap_text(grow = FALSE, reflow = TRUE) +
  theme(legend.position = "right") +
  labs(title = "Innovation Sectors and Subsectors", fill = "Category")

# Save the tree map visualization to a png file
ggsave("generated_vis_session_1/tree_map-innovation.png", tree_map, width = 10, height = 8, units = "in")

# The code ends here, and the image is saved without displaying it