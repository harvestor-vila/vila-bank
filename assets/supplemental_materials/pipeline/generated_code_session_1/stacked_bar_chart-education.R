library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
schools <- paste("School", LETTERS[1:8])
grades <- c("Grade 9", "Grade 10", "Grade 11", "Grade 12")
data <- expand.grid(School = schools, Grade = grades)
data$Students <- sample(50:200, size = nrow(data), replace = TRUE)

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/stacked_bar_chart-education.txt", row.names = FALSE, sep = "\t")

# Create the stacked bar chart
ggplot(data, aes(x = School, y = Students, fill = Grade)) +
  geom_bar(stat = "identity") +
  labs(title = "Student Distribution by Grade and School", x = "School", y = "Number of Students") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "bottom",
        plot.margin = margin(1, 1, 1, 1, "cm")) +
  scale_fill_brewer(palette = "Pastel1") # Using a color palette that is not too bright

# Save the visualization to a png file
ggsave("generated_vis_session_1/stacked_bar_chart-education.png", width = 10, height = 6, units = "in")