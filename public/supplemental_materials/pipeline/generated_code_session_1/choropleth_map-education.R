library(ggplot2)
library(tidyverse)
library(dplyr)
library(choroplethr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
states <- c(state.name, "District of Columbia")
values <- sample(100:1000, length(states), replace = TRUE)
education_data <- data.frame(region = tolower(states), value = values)

# Save the dataset to a txt file
write.table(education_data, file = "generated_dataset_session_1/choropleth_map-education.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create the choropleth map
choropleth <- StateChoropleth$new(education_data)
choropleth$title = "Education Data by State"
choropleth$set_num_colors(5)
choropleth$legend = "Education Value"
choropleth$show_labels = TRUE

# Render the plot and save it as a png file
png(filename = "generated_vis_session_1/choropleth_map-education.png", width = 1024, height = 768)
choropleth$render()
dev.off()