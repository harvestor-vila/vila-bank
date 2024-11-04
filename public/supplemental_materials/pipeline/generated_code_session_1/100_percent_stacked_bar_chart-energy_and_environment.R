library(ggplot2)
library(tidyverse)
library(dplyr)
library(scales)

# Create a synthetic dataset
set.seed(123) # For reproducibility
categories <- c("Solar", "Wind", "Hydro", "Nuclear", "Fossil Fuels")
years <- c("2019", "2020", "2021")

data <- expand.grid(Category = categories, Year = years) %>%
  mutate(Percentage = runif(n = nrow(.), min = 0, max = 100)) %>%
  group_by(Year) %>%
  mutate(Percentage = round(Percentage / sum(Percentage) * 100)) %>%
  ungroup()

# Adjust the percentages so that each year sums to 100
data <- data %>%
  group_by(Year) %>%
  mutate(Residual = 100 - sum(Percentage),
         Percentage = if_else(row_number() == n(), Percentage + Residual, Percentage)) %>%
  ungroup() %>%
  select(-Residual)

# Save the dataset
write.table(data, file = "generated_dataset_session_1/100_percent_stacked_bar_chart-energy_and_environment.txt", row.names = FALSE, sep = "\t")

# Create a 100 percent stacked bar chart
ggplot(data, aes(x = Year, y = Percentage, fill = Category)) +
  geom_bar(stat = "identity", position = "fill") +
  scale_y_continuous(labels = percent_format(), breaks = seq(0, 1, 0.2)) +
  labs(title = "Energy Source Distribution Over Years", x = "Year", y = "Percentage", fill = "Energy Source") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(10, 10, 10, 10),
        legend.position = "bottom")

# Save the visualization
ggsave("generated_vis_session_1/100_percent_stacked_bar_chart-energy_and_environment.png", width = 10, height = 6, units = "in")