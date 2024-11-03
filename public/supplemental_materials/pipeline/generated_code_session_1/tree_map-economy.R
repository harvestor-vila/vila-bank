library(ggplot2)
library(treemapify)
library(dplyr)
library(tidyverse)

# Create a synthetic dataset
set.seed(123) # For reproducibility
categories <- c("Agriculture", "Manufacturing", "Services", "Technology")
subcategories <- c("Crops", "Livestock", "Textiles", "Machinery", "Retail", "Finance", "Software", "Hardware")

# Ensure that each category has two or three subcategories and the sum of all values is 100
values <- c(10, 5, 15, 10, 20, 15, 15, 10)
dataset <- data.frame(
  Category = rep(categories, each = 2),
  Subcategory = subcategories,
  Percentage = values
)

# Save the dataset to a txt file
write.table(dataset, file = "generated_dataset_session_1/tree_map-economy.txt", row.names = FALSE, sep = "\t")

# Create a tree map visualization
treemap <- ggplot(dataset, aes(area = Percentage, fill = Category, label = Subcategory, subgroup = Category)) +
  geom_treemap(colour = "black") +
  geom_treemap_text(grow = FALSE, reflow = TRUE) +
  theme(legend.position = "right") +
  labs(title = "Economy Breakdown by Sector", fill = "Category")

# Save the tree map visualization to a png file
ggsave("generated_vis_session_1/tree_map-economy.png", treemap, width = 10, height = 8)

# The code ends here, and the image is saved without displaying it.