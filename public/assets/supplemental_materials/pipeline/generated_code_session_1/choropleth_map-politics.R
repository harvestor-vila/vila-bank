library(tidyverse)
library(ggplot2)
library(dplyr)
library(choroplethr)

# Generate a synthetic dataset
set.seed(123) # For reproducibility
states <- c(state.name, "District of Columbia")
values <- sample(100:1000, length(states), replace = TRUE) # Generate random whole numbers
data <- data.frame(region = tolower(states), value = values)

# Save the dataset to a text file
write.table(data, file = "generated_dataset_session_1/choropleth_map-politics.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create the choropleth map
choropleth <- state_choropleth(data, title = "Political Context - Synthetic Data Choropleth Map", legend = "Value")

# Save the choropleth map to a PNG file
png(filename = "generated_vis_session_1/choropleth_map-politics.png", width = 800, height = 600)
print(choropleth)
dev.off()