library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset with a single numerical column that is left-skewed
set.seed(123) # For reproducibility
data_size <- 1000
health_data <- data.frame(
  CholesterolLevel = rexp(data_size, rate = 0.1) + 150
)

# Ensure all values are whole numbers
health_data$CholesterolLevel <- floor(health_data$CholesterolLevel)

# Save the dataset to a txt file
write.table(health_data, file = "generated_dataset_session_1/histogram-health.txt", row.names = FALSE, col.names = TRUE)

# Create the histogram visualization
histogram_plot <- ggplot(health_data, aes(x = CholesterolLevel)) +
  geom_histogram(bins = 10, fill = "blue", color = "black") +
  labs(title = "Distribution of Cholesterol Levels",
       x = "Cholesterol Level",
       y = "Number of People") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the histogram visualization as a PNG file
ggsave("generated_vis_session_1/histogram-health.png", histogram_plot, width = 10, height = 6, units = "in")