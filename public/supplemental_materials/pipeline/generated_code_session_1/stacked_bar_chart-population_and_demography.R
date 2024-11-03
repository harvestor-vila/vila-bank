library(ggplot2)
library(tidyverse)
library(dplyr)

# Create synthetic dataset
set.seed(123) # For reproducibility
age_groups <- c("0-14", "15-24", "25-54", "55-74", "75+")
regions <- paste("Region", LETTERS[1:8])
population_data <- expand.grid(Region = regions, AgeGroup = age_groups) %>%
  mutate(Population = sample(10000:50000, size = 40, replace = TRUE)) %>%
  arrange(Region, AgeGroup)

# Save the dataset to a text file
write.table(population_data, file = "generated_dataset_session_1/stacked_bar_chart-population_and_demography.txt", row.names = FALSE, sep = "\t")

# Create the stacked bar chart
ggplot(population_data, aes(x = Region, y = Population, fill = AgeGroup)) +
  geom_bar(stat = "identity") +
  labs(title = "Population Distribution by Region and Age Group", x = "Region", y = "Population") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "bottom",
        plot.margin = margin(5.5, 5.5, 5.5, 5.5, "points"),
        axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_brewer(palette = "Set3")

# Save the visualization to a PNG file
ggsave("generated_vis_session_1/stacked_bar_chart-population_and_demography.png", width = 10, height = 6, units = "in")