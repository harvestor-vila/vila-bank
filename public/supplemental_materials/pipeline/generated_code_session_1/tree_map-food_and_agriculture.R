library(ggplot2)
library(tidyverse)
library(dplyr)
library(treemapify)

# Create synthetic dataset
set.seed(123) # For reproducibility
categories <- c("Fruits", "Vegetables", "Grains")
subcategories <- list(
  Fruits = c("Apples", "Bananas", "Oranges"),
  Vegetables = c("Tomatoes", "Carrots", "Lettuces"),
  Grains = c("Rice", "Wheat", "Corn")
)

# Expand categories into subcategories and assign percentages
data <- map2_df(categories, subcategories, ~ data.frame(Category = .x, Subcategory = .y))
data$Percentage <- round(runif(nrow(data), 1, 80), 0)
data$Percentage <- round(100 * data$Percentage / sum(data$Percentage), 0)

# Adjust the percentages to sum up to 100
diff <- 100 - sum(data$Percentage)
data$Percentage[1] <- data$Percentage[1] + diff

# Save the dataset
write.table(data, file = "generated_dataset_session_1/tree_map-food_and_agriculture.txt", row.names = FALSE, sep = "\t")

# Create the tree map visualization
gg <- ggplot(data, aes(area = Percentage, fill = Category, label = Subcategory, subgroup = Category)) +
  geom_treemap() +
  geom_treemap_text(grow = FALSE, reflow = TRUE) +
  theme(legend.position = "right") +
  labs(title = "Tree Map of Food and Agriculture Categories", fill = "Category")

# Save the visualization
ggsave("generated_vis_session_1/tree_map-food_and_agriculture.png", plot = gg, width = 10, height = 8, units = "in")