library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
health_data <- tibble(
  Category = c("Exercise", "Diet", "Sleep", "Hydration", "Stress Management"),
  Percentage = c(30, 25, 20, 15, 10)
)

# Save the dataset to a txt file
write.table(health_data, file = "generated_dataset_session_1/pie_chart-health.txt", row.names = FALSE, sep = "\t")

# Create a pie chart visualization
pie_chart <- ggplot(health_data, aes(x = "", y = Percentage, fill = Category)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = Category), position = position_stack(vjust = 0.5)) +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm")) +
  labs(title = "Health-Related Activities Distribution")

# Save the pie chart image to a png file
ggsave("generated_vis_session_1/pie_chart-health.png", pie_chart, width = 10, height = 8, units = "in")