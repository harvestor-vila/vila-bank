library(ggplot2)
library(tidyverse)
library(dplyr)
library(treemapify)

# Create a synthetic dataset
set.seed(123) # For reproducibility
categories <- c("Cardiology", "Neurology", "Oncology", "Pediatrics", "Orthopedics")
subcategories <- c("Arrhythmia", "Hypertension", "Stroke", "Alzheimer's", "Brain Cancer", "Spinal Cord", "Leukemia", "Breast Cancer", "General", "Vaccination", "Bone Fracture", "Arthritis")

# Ensure that the sum of all values is 100 and no single value is more than 80
values <- c(10, 15, 5, 8, 12, 6, 9, 7, 10, 8, 5, 5)

# Combine into a dataframe
data <- data.frame(
  Category = rep(categories, each = 2, length.out = length(values)),
  Subcategory = subcategories,
  Percentage = values
)

# Save the dataset
write.table(data, file = "generated_dataset_session_1/tree_map-health.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create the tree map visualization
tree_map <- ggplot(data, aes(area = Percentage, fill = Category, label = Subcategory, subgroup = Category)) +
  geom_treemap() +
  geom_treemap_text(grow = FALSE, reflow = TRUE) +
  theme(legend.position = "right") +
  labs(title = "Health Subcategories Distribution", fill = "Category")

# Save the tree map visualization
ggsave("generated_vis_session_1/tree_map-health.png", tree_map, width = 10, height = 8, units = "in")

# The image is saved and not displayed as per the instructions