library(ggplot2)
library(tidyverse)
library(dplyr)
library(scales)

# Create a synthetic dataset
set.seed(123) # For reproducibility
health_categories <- c("Diet", "Exercise", "Sleep", "Hydration", "Stress Management")
groups <- c("Young Adults", "Adults", "Seniors")

data <- expand.grid(Category = health_categories, Group = groups) %>%
  mutate(Percentage = round(runif(n = nrow(.), min = 0, max = 100))) %>%
  group_by(Group) %>%
  mutate(Percentage = round(Percentage / sum(Percentage) * 100)) %>%
  ungroup()

# Adjusting the last category to make sure each group sums up to 100
data <- data %>%
  group_by(Group) %>%
  mutate(Adjustment = 100 - cumsum(Percentage)) %>%
  mutate(Percentage = ifelse(row_number() == n(), Percentage + Adjustment, Percentage)) %>%
  select(-Adjustment)

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/100_percent_stacked_bar_chart-health.txt", row.names = FALSE, sep = "\t")

# Create the 100 percent stacked bar chart
ggplot(data, aes(x = Group, y = Percentage / 100, fill = Category)) +
  geom_bar(stat = "identity", position = "fill") +
  scale_y_continuous(labels = percent_format(), breaks = seq(0, 1, 0.2)) +
  labs(title = "Health Focus Areas by Age Group", x = "Age Group", y = "Percentage") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "bottom",
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the visualization to a png file
ggsave("generated_vis_session_1/100_percent_stacked_bar_chart-health.png", width = 10, height = 6, units = "in")