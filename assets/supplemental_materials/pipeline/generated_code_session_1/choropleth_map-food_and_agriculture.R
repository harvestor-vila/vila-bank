library(ggplot2)
library(tidyverse)
library(dplyr)
library(choroplethr)

# Create a synthetic dataset with the full names of the 50 U.S. states and 'district of columbia'
# and associate each with a random numerical value.
set.seed(123) # For reproducibility
states_data <- data.frame(
  region = tolower(c(state.name, "district of columbia")),
  value = sample(100:1000, 51, replace = TRUE)
)

# Save the dataset to a txt file
write.table(states_data, file = "generated_dataset_session_1/choropleth_map-food_and_agriculture.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create the choropleth map
choropleth <- state_choropleth(states_data, title = "Food and Agriculture Production by State", legend = "Production Units")
choropleth <- choropleth + theme(
  plot.title = element_text(hjust = 0.5),
  plot.margin = margin(1, 1, 1, 1, "cm"),
  legend.position = "bottom"
)

# Save the choropleth map to a png file
ggsave("generated_vis_session_1/choropleth_map-food_and_agriculture.png", plot = choropleth, width = 10, height = 6)