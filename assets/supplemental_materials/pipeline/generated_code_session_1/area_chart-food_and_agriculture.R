library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
data_points <- 20
dataset <- tibble(
  Year = seq(2000, by = 1, length.out = data_points),
  Production = sample(100:200, data_points, replace = TRUE) # Random whole numbers between 100 and 200
)

# Save the dataset to a text file
write.table(dataset, file = "generated_dataset_session_1/area_chart-food_and_agriculture.txt", row.names = FALSE)

# Create an area chart
area_chart <- ggplot(dataset, aes(x = Year, y = Production)) +
  geom_area(fill = "skyblue", alpha = 0.5) +
  labs(title = "Agricultural Production Over Years",
       x = "Year",
       y = "Production (in tons)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the area chart as a PNG file
ggsave("generated_vis_session_1/area_chart-food_and_agriculture.png", area_chart, width = 10, height = 6, units = "in")

# The image is saved and not displayed as per the instructions