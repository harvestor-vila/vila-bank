library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset
set.seed(123) # For reproducibility
years <- 2000:2019
num_years <- length(years)
categories <- c("Elementary", "Middle_School", "High_School", "College")
num_categories <- length(categories)

# Create random enrollment numbers for each category and year
enrollments <- matrix(sample(100:500, num_years * num_categories, replace = TRUE), ncol = num_categories)
colnames(enrollments) <- categories

# Convert the matrix to a data frame
df <- as.data.frame(enrollments)
df$Year <- years

# Reshape the data frame for ggplot
df_long <- gather(df, key = "Education_Level", value = "Enrollment", -Year)

# Save the dataset to a text file
write.table(df_long, file = "generated_dataset_session_1/stacked_area_chart-education.txt", row.names = FALSE, sep = "\t")

# Create the stacked area chart
p <- ggplot(df_long, aes(x = Year, y = Enrollment, fill = Education_Level)) +
  geom_area(position = 'stack') +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Enrollment Over Years by Education Level",
       x = "Year",
       y = "Enrollment") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "bottom",
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the visualization to a PNG file
ggsave("generated_vis_session_1/stacked_area_chart-education.png", p, width = 10, height = 6, units = "in")