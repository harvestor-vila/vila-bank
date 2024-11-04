library(ggplot2)
library(tidyverse)
library(dplyr)
library(choroplethr)

# Create a synthetic dataset with the full names of the 50 U.S. states and 'district of columbia'
state_names <- tolower(c(state.name, "district of columbia"))
values <- sample(100:1000, length(state_names), replace = TRUE) # Generate random whole numbers for each state
data <- data.frame(region = state_names, value = values)

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/choropleth_map-energy_and_environment.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create a choropleth map
choropleth <- state_choropleth(data, title = "Energy Consumption by State", legend = "Energy Units")
choropleth <- choropleth + theme(plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the choropleth map to a png file
ggsave("generated_vis_session_1/choropleth_map-energy_and_environment.png", plot = choropleth, width = 10, height = 6, units = "in")