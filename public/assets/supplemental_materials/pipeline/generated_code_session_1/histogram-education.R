library(tidyverse)
library(ggplot2)
library(dplyr)

# Generate a right-skewed dataset
set.seed(123) # For reproducibility
scores <- rbinom(n = 1000, size = 100, prob = 0.4) + 50
education_data <- data.frame(TestScores = scores)

# Save the dataset to a txt file
write.table(education_data, file = "generated_dataset_session_1/histogram-education.txt", row.names = FALSE)

# Create the histogram
histogram_plot <- ggplot(education_data, aes(x = TestScores)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black") +
  labs(title = "Distribution of Standardized Test Scores",
       x = "Test Score",
       y = "Number of Students") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(5.5, 5.5, 5.5, 5.5),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 10))

# Save the histogram plot as a png file
ggsave("generated_vis_session_1/histogram-education.png", histogram_plot, width = 10, height = 6)

# The code ends here, and the image is saved without displaying it