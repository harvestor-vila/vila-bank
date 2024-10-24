# Load necessary libraries
library(ggplot2)
library(tidyverse)
library(dplyr)
library(scales)

# Create a synthetic dataset
set.seed(123) # For reproducibility
age_groups <- c("0-14", "15-24", "25-54", "55-74", "75+")
genders <- c("Male", "Female")
population_data <- expand.grid(Age_Group = age_groups, Gender = genders)

# Assign random percentages that sum to 100 for each gender
population_data <- population_data %>%
  group_by(Gender) %>%
  mutate(Percentage = round(runif(n = n(), min = 0, max = 100))) %>%
  ungroup() %>%
  group_by(Gender) %>%
  mutate(Percentage = round(Percentage / sum(Percentage) * 100)) %>%
  ungroup()

# Ensure that each bar sums up to 100
population_data <- population_data %>%
  group_by(Gender) %>%
  mutate(Sum_Percentage = sum(Percentage)) %>%
  ungroup()

# Adjust the last group to make the sum exactly 100
population_data <- population_data %>%
  group_by(Gender) %>%
  mutate(Percentage = ifelse(row_number() == n(), 100 - sum(Percentage[-n()]), Percentage)) %>%
  ungroup()

# Save the dataset to a txt file
write.table(population_data, file = "generated_dataset_session_1/100_percent_stacked_bar_chart-population_and_demography.txt", row.names = FALSE, sep = "\t")

# Create the 100 percent stacked bar chart
ggplot(population_data, aes(x = Gender, y = Percentage, fill = Age_Group)) +
  geom_bar(stat = "identity", position = "fill") +
  scale_y_continuous(labels = percent_format(), breaks = seq(0, 1, 0.2)) +
  labs(title = "Population Distribution by Age Group and Gender", x = "Gender", y = "Percentage") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(10, 10, 10, 10),
        legend.position = "bottom") +
  guides(fill = guide_legend(title = "Age Group"))

# Save the visualization to a png file
ggsave("generated_vis_session_1/100_percent_stacked_bar_chart-population_and_demography.png", width = 10, height = 6, units = "in")