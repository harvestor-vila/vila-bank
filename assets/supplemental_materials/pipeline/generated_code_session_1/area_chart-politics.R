library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset
set.seed(123) # For reproducibility
data_points <- 20
political_data <- tibble(
  Year = seq(2000, by = 1, length.out = data_points),
  Votes = sample(100:500, data_points, replace = TRUE) # Random whole numbers
)

# Save the dataset to a txt file
write.table(political_data, file = "generated_dataset_session_1/area_chart-politics.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create an area chart
area_chart <- ggplot(political_data, aes(x = Year, y = Votes)) +
  geom_area(fill = "skyblue", alpha = 0.5) +
  labs(title = "Political Party Votes Over Time", x = "Year", y = "Votes") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), # Center the title
        plot.margin = margin(1, 1, 1, 1, "cm"), # Set margins
        legend.position = "none") # No legend required

# Save the area chart as a PNG file
ggsave("generated_vis_session_1/area_chart-politics.png", area_chart, width = 8, height = 6, units = "in")

# The image is saved and not displayed as per the instructions