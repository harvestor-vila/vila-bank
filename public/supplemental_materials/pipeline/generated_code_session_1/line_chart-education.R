library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset
set.seed(123) # For reproducibility
academic_years <- paste0("Year ", 2001:2020)
enrollments <- sample(50:150, 20, replace = TRUE) # Random whole numbers between 50 and 150
education_data <- data.frame(AcademicYear = academic_years, Enrollment = enrollments)

# Save the dataset to a txt file
write.table(education_data, file = "generated_dataset_session_1/line_chart_education.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create the line chart visualization
line_chart <- ggplot(education_data, aes(x = AcademicYear, y = Enrollment)) +
  geom_line(group = 1, color = "blue") +
  geom_point(color = "red") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), plot.margin = margin(1, 1, 1, 1, "cm")) +
  labs(title = "Enrollment Over Academic Years", x = "Academic Year", y = "Number of Students") +
  scale_x_discrete(limits = education_data$AcademicYear)

# Save the line chart as a png file
ggsave("generated_vis_session_1/line_chart_education.png", line_chart, width = 10, height = 6, units = "in")