library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset for the context of innovation
set.seed(123) # For reproducibility
data_points <- 20
innovation_data <- tibble(
  Year = 2000 + 1:data_points,
  Innovations = sample(50:150, data_points, replace = TRUE) # Random whole numbers
)

# Save the dataset to a text file
write.table(innovation_data, file = "generated_dataset_session_1/area_chart-innovation.txt", row.names = FALSE)

# Create an area chart visualization
area_chart <- ggplot(innovation_data, aes(x = Year, y = Innovations)) +
  geom_area(fill = "skyblue", alpha = 0.5) +
  labs(title = "Innovation Trends Over Time", x = "Year", y = "Number of Innovations") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "none")

# Save the area chart as a PNG image
ggsave("generated_vis_session_1/area_chart-innovation.png", area_chart, width = 8, height = 6, units = "in")

# The image is saved and not displayed as per the instructions