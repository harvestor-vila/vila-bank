library(ggplot2)
library(tidyverse)
library(dplyr)
library(scales)

# Create a synthetic dataset
set.seed(123) # For reproducibility
categories <- c("Vegetables", "Fruits", "Grains", "Meat", "Dairy")
years <- c("2019", "2020", "2021")

data <- expand.grid(Category = categories, Year = years) %>%
  mutate(Percentage = round(runif(n = nrow(.), min = 0, max = 100))) %>%
  group_by(Year) %>%
  mutate(Percentage = round(Percentage / sum(Percentage) * 100)) %>%
  ungroup()

# Adjust the last category to make sure each year sums up to 100
data <- data %>%
  group_by(Year) %>%
  mutate(Adjustment = 100 - cumsum(Percentage)) %>%
  mutate(Percentage = if_else(row_number() == n(), Percentage + Adjustment, Percentage)) %>%
  select(-Adjustment)

# Save the dataset
write.table(data, file = "generated_dataset_session_1/100_percent_stacked_bar_chart-food_and_agriculture.txt", row.names = FALSE, sep = "\t")

# Create the 100 percent stacked bar chart
ggplot(data, aes(x = Year, y = Percentage/100, fill = Category)) +
  geom_bar(stat = "identity", position = "fill") +
  scale_y_continuous(labels = percent_format(), breaks = seq(0, 1, 0.2)) +
  labs(title = "Distribution of Food and Agriculture Categories Over Years", x = "Year", y = "Percentage") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "bottom",
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the visualization
ggsave("generated_vis_session_1/100_percent_stacked_bar_chart-food_and_agriculture.png", width = 8, height = 6)