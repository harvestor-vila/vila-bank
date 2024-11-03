library(ggplot2)
library(tidyverse)
library(dplyr)
library(choroplethr)

# Generate a synthetic dataset
set.seed(123) # For reproducibility
states <- c(state.name, "District of Columbia")
populations <- sample(500000:10000000, length(states), replace = TRUE)

# Create a dataframe
df <- data.frame(region = tolower(states), value = populations)

# Save the dataset to a txt file
write.table(df, file = "generated_dataset_session_1/choropleth_map-population_and_demography.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create the choropleth map
choropleth <- StateChoropleth$new(df)
choropleth$title = "Population and Demography of US States and District of Columbia"
choropleth$set_num_colors(5)
choropleth$legend = "Population"
choropleth$show_labels = TRUE

# Render the plot
choropleth$render()

# Save the plot as a PNG file
png(filename = "generated_vis_session_1/choropleth_map-population_and_demography.png", width = 1024, height = 768)
choropleth$render()
dev.off()