library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
education_data <- tibble(
  Program = c("Engineering", "Business", "Biology", "Education", "Computer Science",
              "Psychology", "Medicine", "Law", "Art", "History"),
  Graduates = sample(50:200, 10, replace = TRUE) # Generate random whole numbers
)

# Save the dataset to a txt file
write.table(education_data, file = "generated_dataset_session_1/bar_chart-education.txt", row.names = FALSE)

# Create a bar chart visualization
bar_chart <- ggplot(education_data, aes(x = Program, y = Graduates, fill = "blue")) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Number of Graduates by Program", x = "Educational Program", y = "Number of Graduates") +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.position = "none",
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.margin = margin(5.5, 5.5, 5.5, 5.5, "points")
  ) +
  scale_fill_identity()

# Save the bar chart image
ggsave("generated_vis_session_1/bar_chart-education.png", bar_chart, width = 10, height = 6, dpi = 300)