library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset with a left-skewed distribution
set.seed(123) # For reproducibility
population_ages <- rbinom(n = 1000, size = 100, prob = 0.3)
population_ages <- sort(population_ages, decreasing = TRUE) # To ensure left skewness
df <- data.frame(Age = population_ages)

# Save the dataset to a txt file
write.table(df, file = "generated_dataset_session_1/histogram-population_and_demography.txt", row.names = FALSE)

# Create the histogram visualization
histogram_plot <- ggplot(df, aes(x = Age)) +
  geom_histogram(bins = 15, fill = "blue", color = "black") +
  labs(title = "Population Age Distribution",
       x = "Age",
       y = "Number of People") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the histogram visualization as a PNG file
ggsave("generated_vis_session_1/histogram-population_and_demography.png", histogram_plot, width = 10, height = 6)

# The code ends here, and the files have been saved in the respective directories.