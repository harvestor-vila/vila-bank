library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset with a negative correlation
set.seed(123) # For reproducibility
n <- sample(20:50, 1) # Number of data points between 20 and 50
crop_yield <- round(runif(n, 2000, 5000)) # Crop yield in kilograms per hectare
fertilizer_use <- round((5000 - crop_yield) / 4 + runif(n, 0, 500)) # Fertilizer use in kilograms per hectare

# Combine into a data frame
data <- data.frame(
  CropYield = crop_yield,
  FertilizerUse = fertilizer_use
)

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/scatterplot-food_and_agriculture.txt", row.names = FALSE)

# Create the scatterplot visualization
scatterplot <- ggplot(data, aes(x = CropYield, y = FertilizerUse)) +
  geom_point(color = "blue") +
  ggtitle("Relationship between Crop Yield and Fertilizer Use") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "none") +
  labs(x = "Crop Yield (kg/ha)", y = "Fertilizer Use (kg/ha)")

# Save the scatterplot to a png file
ggsave("generated_vis_session_1/scatterplot-food_and_agriculture.png", scatterplot, width = 10, height = 6, units = "in")