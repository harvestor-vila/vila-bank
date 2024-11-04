library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset with a negative correlation
set.seed(123) # For reproducibility
n <- sample(20:50, 1) # Number of data points between 20 and 50
weight <- round(runif(n, 50, 100)) # Weight in kg (random values between 50 and 100)
height <- round(200 - weight + rnorm(n, sd = 5)) # Height in cm (negatively correlated with weight)

# Create a dataframe
health_data <- data.frame(Weight = weight, Height = height)

# Save the dataset to a txt file
write.table(health_data, file = "generated_dataset_session_1/scatterplot-health.txt", row.names = FALSE)

# Create the scatterplot
scatterplot <- ggplot(health_data, aes(x = Weight, y = Height)) +
  geom_point(color = "blue") +
  ggtitle("Relationship between Weight and Height") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "none") +
  labs(x = "Weight (kg)", y = "Height (cm)")

# Save the scatterplot to a png file
ggsave("generated_vis_session_1/scatterplot-health.png", scatterplot, width = 7, height = 5, units = "in")

# The image is saved and not displayed as per the instructions