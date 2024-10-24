library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
schools <- paste("School", LETTERS[1:8])
average_test_score <- round(runif(8, 60, 100)) # Scores between 60 and 100
number_of_students <- round(runif(8, 200, 1000), -1) # Students between 200 and 1000
school_funding <- round(runif(8, 1, 10)) * 1e6 # Funding between 1M and 10M

education_data <- data.frame(School = schools,
                             Average_Test_Score = average_test_score,
                             Number_of_Students = number_of_students,
                             School_Funding = school_funding)

# Save the dataset
write.table(education_data, file = "generated_dataset_session_1/bubble_chart-education.txt", row.names = FALSE, sep = "\t")

# Create the bubble chart
bubble_chart <- ggplot(education_data, aes(x = Average_Test_Score, y = Number_of_Students, size = School_Funding, color = School)) +
  geom_point(alpha = 0.7) +
  scale_size_continuous(range = c(3, 15)) +
  labs(title = "Education Bubble Chart", x = "Average Test Score", y = "Number of Students", size = "School Funding") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "right",
        plot.margin = unit(c(1, 1, 1, 1), "cm"))

# Save the bubble chart image
ggsave("generated_vis_session_1/bubble_chart-education.png", bubble_chart, width = 10, height = 6, dpi = 300)