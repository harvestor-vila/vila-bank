library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
products <- c("Wheat", "Corn", "Rice", "Barley", "Soybeans", "Oats", "Rye", "Millet")
regions <- c("North", "South", "East", "West")

data <- expand.grid(Product = products, Region = regions) %>%
  mutate(Production = sample(100:1000, size = n(), replace = TRUE)) %>%
  arrange(Product)

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/stacked_bar_chart-food_and_agriculture.txt", row.names = FALSE, sep = "\t")

# Create the stacked bar chart
ggplot(data, aes(x = Product, y = Production, fill = Region)) +
  geom_bar(stat = "identity") +
  labs(title = "Agricultural Production by Product and Region", x = "Product", y = "Production (in tons)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "bottom",
        plot.margin = margin(1, 1, 1, 1, "cm"),
        axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_brewer(palette = "Set3")

# Save the visualization to a png file
ggsave("generated_vis_session_1/stacked_bar_chart-food_and_agriculture.png", width = 10, height = 6, units = "in")