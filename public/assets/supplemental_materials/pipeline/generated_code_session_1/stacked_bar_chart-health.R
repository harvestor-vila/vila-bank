library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # for reproducibility
categories <- c("Cardio", "Strength", "Flexibility", "Balance", "Endurance")
clinics <- paste("Clinic", 1:8)
data <- expand.grid(Clinic = clinics, Category = categories)
data$Patients <- sample(50:200, size = nrow(data), replace = TRUE)

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/stacked_bar_chart-health.txt", row.names = FALSE, sep = "\t")

# Create the stacked bar chart
ggplot(data, aes(x = Clinic, y = Patients, fill = Category)) +
  geom_bar(stat = "identity") +
  labs(title = "Patient Distribution by Health Category and Clinic",
       x = "Clinic",
       y = "Number of Patients",
       fill = "Health Category") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "bottom",
        plot.margin = margin(1, 1, 1, 1, "cm"),
        axis.text.x = element_text(angle = 45, hjust = 1)) +
  coord_flip()

# Save the visualization to a png file
ggsave("generated_vis_session_1/stacked_bar_chart-health.png", width = 10, height = 6, units = "in")