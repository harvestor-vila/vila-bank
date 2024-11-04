library(ggplot2)
library(tidyverse)
library(dplyr)
library(choroplethr)

# Generate synthetic dataset
set.seed(123) # for reproducibility
states <- tolower(c(state.name, "district of columbia"))
values <- sample(100:2000, length(states), replace = TRUE) # generate random whole numbers
data <- data.frame(region = states, value = values)

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/choropleth_map-health.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create the choropleth map
choropleth <- state_choropleth(data, title = "Health Index by State", legend = "Health Index") +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "right",
        legend.key.width = unit(1, "cm"))

# Save the choropleth map as a PNG image
png(filename = "generated_vis_session_1/choropleth_map-health.png", width = 800, height = 600)
print(choropleth)
dev.off()