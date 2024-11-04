library(ggplot2)
library(tidyverse)
library(dplyr)
library(treemapify)

# Create the synthetic dataset
set.seed(123) # For reproducibility
categories <- c("Mathematics", "Science", "Humanities", "Languages")
subcategories <- c("Algebra", "Geometry", "Biology", "Chemistry", "History", "Geography", "English", "Spanish")

# Ensure that the sum of percentages is 100 and no single value is more than 80
percentages <- c(15, 10, 20, 15, 10, 10, 10, 10)

# Combine into a data frame
education_data <- data.frame(
  Category = rep(categories, each = 2),
  Subcategory = subcategories,
  Percentage = percentages
)

# Save the dataset to a txt file
write.table(education_data, file = "generated_dataset_session_1/tree_map-education.txt", row.names = FALSE, sep = "\t")

# Create the tree map visualization
tree_map <- ggplot(education_data, aes(area = Percentage, fill = Category, label = Subcategory, subgroup = Category)) +
  geom_treemap() +
  geom_treemap_text(grow = FALSE, reflow = TRUE) +
  theme(legend.position = "right") +
  labs(title = "Educational Categories and Subcategories", fill = "Category")

# Save the tree map visualization to a png file
ggsave("generated_vis_session_1/tree_map-education.png", tree_map, width = 10, height = 8, units = "in")

# The image is saved and not displayed as per the instructions