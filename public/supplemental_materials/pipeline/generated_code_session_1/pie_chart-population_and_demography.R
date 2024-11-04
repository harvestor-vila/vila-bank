library(tidyverse)
library(ggplot2)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
population_data <- tibble(
  Category = c("Youth", "Adults", "Seniors"),
  Percentage = c(35, 50, 15) # These are dummy percentages
)

# Save the dataset to a txt file
write.table(population_data, file = "generated_dataset_session_1/pie_chart-population_and_demography.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create a pie chart visualization
pie_chart <- ggplot(population_data, aes(x = "", y = Percentage, fill = Category)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = Category), position = position_stack(vjust = 0.5)) +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm")) +
  labs(title = "Population Distribution by Category")

# Save the pie chart image to a png file
ggsave("generated_vis_session_1/pie_chart-population_and_demography.png", pie_chart, width = 8, height = 6, units = "in")