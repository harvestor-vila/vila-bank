library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
food_items <- c("Wheat", "Rice", "Corn", "Soybeans", "Potatoes", "Barley", "Cassava", "Sorghum", "Yams", "Oats")
production_values <- sample(100:1000, length(food_items), replace = TRUE) # Random whole numbers between 100 and 1000

# Create a dataframe
food_production <- data.frame(Item = food_items, Production = production_values)

# Save the dataset to a txt file
write.table(food_production, file = "generated_dataset_session_1/bar_chart-food_and_agriculture.txt", row.names = FALSE, sep = "\t")

# Create a bar chart
bar_chart <- ggplot(food_production, aes(x = Item, y = Production, fill = "skyblue")) +
  geom_bar(stat = "identity", color = "black") +
  theme_minimal() +
  labs(title = "Food and Agriculture Production", x = "Food Item", y = "Production (in tonnes)") +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "none",
        axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(5.5, 40, 5.5, 5.5)) +
  scale_fill_identity()

# Save the bar chart as a PNG file
ggsave("generated_vis_session_1/bar_chart-food_and_agriculture.png", bar_chart, width = 10, height = 6, units = "in")