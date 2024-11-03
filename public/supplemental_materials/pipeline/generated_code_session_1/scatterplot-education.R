library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset
set.seed(123) # For reproducibility
number_of_points <- sample(20:50, 1)
student_data <- tibble(
  StudentID = 1:number_of_points,
  AverageGrade = sample(60:100, number_of_points, replace = TRUE), # Average grade out of 100
  StudyHours = sample(1:20, number_of_points, replace = TRUE) # Study hours per week
)

# Save the dataset to a txt file
write.table(student_data, file = "generated_dataset_session_1/scatterplot-education.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create a scatterplot visualization
scatterplot <- ggplot(student_data, aes(x = StudyHours, y = AverageGrade)) +
  geom_point(color = "blue") +
  labs(title = "Study Hours vs Average Grade of Students",
       x = "Study Hours per Week",
       y = "Average Grade") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the scatterplot as a png file
ggsave("generated_vis_session_1/scatterplot-education.png", scatterplot, width = 10, height = 6, units = "in")