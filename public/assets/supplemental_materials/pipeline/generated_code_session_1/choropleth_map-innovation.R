# Load necessary libraries
library(ggplot2)
library(tidyverse)
library(dplyr)
library(choroplethr)

# Create a synthetic dataset for the context of innovation
set.seed(123) # For reproducibility
states <- c(state.name, "District of Columbia")
innovation_scores <- sample(50:500, length(states), replace = TRUE) # Generate random scores
dataset <- data.frame(region = tolower(states), value = innovation_scores)

# Save the dataset to a txt file
write.table(dataset, file = "generated_dataset_session_1/choropleth_map-innovation.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create the choropleth map visualization
choropleth <- StateChoropleth$new(dataset)
choropleth$title = "Innovation Scores by State"
choropleth$set_num_colors(5)
choropleth$legend = "Innovation Score"
choropleth$show_labels = TRUE # Show state abbreviations

# Render the plot and save it as a PNG file
png(filename = "generated_vis_session_1/choropleth_map-innovation.png", width = 1024, height = 768)
choropleth$render()
dev.off()