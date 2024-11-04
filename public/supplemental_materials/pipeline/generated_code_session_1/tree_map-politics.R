library(ggplot2)
library(tidyverse)
library(dplyr)
library(treemapify)

# Create the synthetic dataset
set.seed(123) # For reproducibility
categories <- c("Domestic Policy", "Foreign Policy", "Economic Policy")
subcategories <- c("Education", "Healthcare", "Defense", "Diplomacy", "Trade", "Taxation", "Labor", "Environment")
subcat_list <- split(subcategories, cut(seq_along(subcategories), length(categories), labels = categories))

# Ensure that each category has 2 or 3 subcategories and sum of percentages is 100
values <- c(15, 10, 20, 15, 10, 10, 10, 10)
dataset <- data.frame(Category = rep(categories, sapply(subcat_list, length)), 
                      Subcategory = unlist(subcat_list), 
                      Percentage = values)

# Save the dataset
write.table(dataset, file = "generated_dataset_session_1/tree_map-politics.txt", row.names = FALSE, col.names = TRUE)

# Create the tree map visualization
treemap <- ggplot(dataset, aes(area = Percentage, fill = Category, label = Subcategory, subgroup = Category)) +
  geom_treemap(colour = "black") +
  geom_treemap_text(grow = FALSE, reflow = TRUE) +
  theme(legend.position = "right") +
  labs(title = "Political Policy Distribution", fill = "Policy Area")

# Save the tree map visualization
ggsave("generated_vis_session_1/tree_map-politics.png", treemap, width = 10, height = 8)

# The code ends here, and the image is saved without displaying it as per the instructions.