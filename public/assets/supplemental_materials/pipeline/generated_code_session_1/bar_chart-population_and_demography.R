library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
age_groups <- c("0-14", "15-24", "25-44", "45-64", "65+")
population <- sample(1000:5000, length(age_groups), replace = TRUE)
dataset <- data.frame(Age_Group = age_groups, Population = population)

# Save the dataset to a txt file
write.table(dataset, file = "generated_dataset_session_1/bar_chart-population_and_demography.txt", row.names = FALSE)

# Create a bar chart
ggplot(dataset, aes(x = Age_Group, y = Population, fill = "Population")) +
  geom_bar(stat = "identity", color = "black", fill = "steelblue") +
  labs(title = "Population Distribution by Age Group", x = "Age Group", y = "Population") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "none",
        plot.margin = margin(5.5, 5.5, 5.5, 5.5, "points")) +
  scale_y_continuous(expand = expansion(mult = c(0.05, 0.1))) # To ensure all labels are displayed fully

# Save the bar chart image
ggsave("generated_vis_session_1/bar_chart-population_and_demography.png", width = 8, height = 6, dpi = 300)