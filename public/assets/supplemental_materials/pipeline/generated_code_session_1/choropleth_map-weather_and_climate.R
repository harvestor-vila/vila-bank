library(ggplot2)
library(tidyverse)
library(dplyr)
library(choroplethr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
states <- c(state.name, "District of Columbia")
values <- sample(50:100, length(states), replace = TRUE) # Generate random whole numbers
data <- data.frame(region = tolower(states), value = values)

# Save the dataset
write.table(data, file = "generated_dataset_session_1/choropleth_map-weather_and_climate.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create the choropleth map
choropleth <- StateChoropleth$new(data)
choropleth$title = "Average Temperature by State"
choropleth$set_num_colors(1)
choropleth$legend = "Average Temperature"
choropleth$show_labels = TRUE

# Render the choropleth map and save it as a PNG file
png(filename = "generated_vis_session_1/choropleth_map-weather_and_climate.png", width = 800, height = 600)
choropleth$render()
dev.off()