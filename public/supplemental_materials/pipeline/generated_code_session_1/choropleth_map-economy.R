library(choroplethr)
library(tidyverse)

# Create a synthetic dataset
set.seed(123) # for reproducibility
states <- c(state.name, "District of Columbia")
values <- sample(10000:99999, length(states), replace = TRUE) # generate random whole numbers
data <- data.frame(region = tolower(states), value = values)

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/choropleth_map-economy.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create a choropleth map
choropleth <- state_choropleth(data, title = "Economy Indicator by State", legend = "Economic Value") +
  theme(plot.title = element_text(hjust = 0.5), # center the title
        plot.margin = margin(1, 1, 1, 1, "cm"), # set margins
        legend.position = "bottom") # position the legend at the bottom

# Save the choropleth map to a png file
ggsave("generated_vis_session_1/choropleth_map-economy.png", choropleth, width = 10, height = 6)