library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
health_data <- tibble(
  Disease = c("Hypertension", "Diabetes", "Asthma", "Obesity", "Heart Disease", "Stroke", "Cancer", "Arthritis", "Hepatitis", "Tuberculosis"),
  Cases = sample(50:500, 10, replace = TRUE) # Generate random whole numbers for cases
)

# Save the dataset to a txt file
write.table(health_data, file = "generated_dataset_session_1/bar_chart-health.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create a bar chart visualization
bar_chart <- ggplot(health_data, aes(x = Disease, y = Cases, fill = "skyblue")) +
  geom_bar(stat = "identity", color = "black", show.legend = FALSE) +
  theme_minimal() +
  labs(title = "Number of Cases by Disease", x = "Disease", y = "Number of Cases") +
  theme(
    plot.title = element_text(hjust = 0.5),
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.margin = margin(5.5, 5.5, 5.5, 5.5, "pt")
  ) +
  scale_fill_identity()

# Save the bar chart visualization as a png
ggsave("generated_vis_session_1/bar_chart-health.png", bar_chart, width = 10, height = 6, units = "in")

# The code ends here, and the files are saved in the respective folders.