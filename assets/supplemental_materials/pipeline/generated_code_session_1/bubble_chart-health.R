library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset with three numerical values and negative correlation between two of them
set.seed(123) # For reproducibility
data_points <- 5 + sample(0:3, 1) # Number of data points between 5 and 8
health_data <- tibble(
  Age = sample(20:80, data_points, replace = TRUE),
  SystolicBP = sample(110:180, data_points, replace = TRUE),
  CholesterolLevel = sample(150:300, data_points, replace = TRUE),
  PatientID = paste("Patient", seq(1, data_points))
)

# Introduce negative correlation by sorting one variable and reversing the other
health_data <- health_data %>%
  arrange(Age) %>%
  mutate(SystolicBP = sort(SystolicBP, decreasing = TRUE))

# Save the dataset to a txt file
write.table(health_data, file = "generated_dataset_session_1/bubble_chart-health.txt", row.names = FALSE, sep = "\t")

# Create a bubble chart
bubble_chart <- ggplot(health_data, aes(x = Age, y = SystolicBP, size = CholesterolLevel, color = PatientID)) +
  geom_point(alpha = 0.7) +
  scale_size_continuous(range = c(3, 15)) + # Adjust the size range to prevent too much overlap
  labs(title = "Health Data: Age vs Systolic Blood Pressure", x = "Age (years)", y = "Systolic Blood Pressure (mmHg)", size = "Cholesterol Level (mg/dL)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "right",
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the bubble chart as a png file
ggsave("generated_vis_session_1/bubble_chart-health.png", bubble_chart, width = 10, height = 6, dpi = 300)