library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
data <- tibble(
  Crop = c("Wheat", "Rice", "Corn", "Barley", "Soybean", "Oats", "Rye"),
  Production = sample(50:100, 7), # in thousands of tonnes
  Yield = round(Production * runif(7, 1, 1.5)), # in thousands of tonnes per hectare
  Profit = round(Production * runif(7, 0.5, 1.5)) # in thousands of dollars
)

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/bubble_chart-food_and_agriculture.txt", row.names = FALSE, col.names = TRUE)

# Create the bubble chart
ggplot(data, aes(x = Production, y = Yield, size = Profit, color = Crop)) +
  geom_point(alpha = 0.7) +
  scale_size_continuous(range = c(3, 12)) +
  labs(title = "Crop Production vs Yield and Profit",
       x = "Production (thousands of tonnes)",
       y = "Yield (thousands of tonnes per hectare)",
       size = "Profit (thousands of dollars)",
       color = "Crop") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "right",
        legend.box.margin = margin(0, 0, 0, 20))

# Save the bubble chart as a PNG file
ggsave("generated_vis_session_1/bubble_chart-food_and_agriculture.png", width = 8, height = 6, units = "in")