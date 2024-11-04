library(ggplot2)
library(tidyverse)
library(dplyr)
library(treemapify)

# Create a synthetic dataset
set.seed(123) # For reproducibility
categories <- c("Age_Group", "Education_Level", "Employment_Status")
subcategories <- list(
  Age_Group = c("0-14", "15-64", "65+"),
  Education_Level = c("No_Schooling", "High_School", "Bachelor_and_Above"),
  Employment_Status = c("Employed", "Unemployed", "Inactive")
)

# Expand the list into a data frame
dataset <- expand.grid(Category = categories, Subcategory = unlist(subcategories))

# Assign random percentage values
dataset$Percentage <- round(runif(nrow(dataset), 1, 20))
dataset$Percentage <- round(100 * dataset$Percentage / sum(dataset$Percentage))

# Ensure no value is more than 80%
while(any(dataset$Percentage > 80)) {
  dataset$Percentage <- round(runif(nrow(dataset), 1, 20))
  dataset$Percentage <- round(100 * dataset$Percentage / sum(dataset$Percentage))
}

# Save the dataset to a text file
write.table(dataset, file = "generated_dataset_session_1/tree_map-population_and_demography.txt", row.names = FALSE, sep = "\t")

# Create the tree map visualization
treemap <- ggplot(dataset, aes(area = Percentage, fill = Category, label = Subcategory, subgroup = Category)) +
  geom_treemap() +
  geom_treemap_text(grow = FALSE, reflow = TRUE) +
  theme(legend.position = "right") +
  labs(title = "Population and Demography - Tree Map", fill = "Category")

# Save the tree map visualization to a PNG file
ggsave("generated_vis_session_1/tree_map-population_and_demography.png", treemap, width = 10, height = 8)

# The code ends here, and the files are saved in the respective directories.