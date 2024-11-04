library(ggplot2)
library(tidyverse)
library(dplyr)
library(scales)

# Create a synthetic dataset
education_data <- tibble(
  School = c('Greenwood Elementary', 'Lakeside High', 'Hilltop Middle'),
  Math = c(30, 25, 35),
  Science = c(25, 30, 25),
  English = c(20, 25, 15),
  History = c(15, 10, 15),
  Arts = c(10, 10, 10)
)

# Convert to long format for ggplot
education_long <- education_data %>%
  gather(key = "Subject", value = "Percentage", -School)

# Normalize the data so that each bar sums to 100%
education_long <- education_long %>%
  group_by(School) %>%
  mutate(Percentage = Percentage / sum(Percentage))

# Plot the 100 percent stacked bar chart
education_plot <- ggplot(education_long, aes(x = School, y = Percentage, fill = Subject)) +
  geom_bar(stat = "identity", position = "fill") +
  scale_y_continuous(labels = percent_format(), breaks = seq(0, 1, 0.2)) +
  labs(title = "Subject Distribution by School", x = "School", y = "Percentage") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(10, 10, 10, 10),
        legend.position = "bottom")

# Save the dataset
write.table(education_data, file = "generated_dataset_session_1/100_percent_stacked_bar_chart-education.txt", row.names = FALSE, sep = "\t")

# Save the visualization
ggsave("generated_vis_session_1/100_percent_stacked_bar_chart-education.png", education_plot, width = 10, height = 6, units = "in")

# The image is saved and not displayed as per the instructions