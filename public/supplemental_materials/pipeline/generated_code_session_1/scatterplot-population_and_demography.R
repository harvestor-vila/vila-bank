library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset with a negative correlation
set.seed(123) # For reproducibility
num_data_points <- sample(20:50, 1)
population <- sample(1000:5000, num_data_points, replace = TRUE)
median_age <- round(runif(num_data_points, min = 20, max = 80))
dataset <- data.frame(Population = population, Median_Age = median_age)

# Introduce a negative correlation
dataset <- dataset %>% 
  arrange(Population) %>% 
  mutate(Median_Age = rev(Median_Age))

# Save the dataset to a txt file
write.table(dataset, file = "generated_dataset_session_1/scatterplot-population_and_demography.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create the scatterplot visualization
scatterplot <- ggplot(dataset, aes(x = Population, y = Median_Age)) +
  geom_point(color = "blue") +
  labs(title = "Population vs Median Age", x = "Population", y = "Median Age") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the scatterplot image to a png file
ggsave("generated_vis_session_1/scatterplot-population_and_demography.png", scatterplot, width = 10, height = 6, units = "in")