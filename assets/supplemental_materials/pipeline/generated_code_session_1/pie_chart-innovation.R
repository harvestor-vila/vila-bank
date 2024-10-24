library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
innovation_data <- tibble(
  Category = c("Product Innovation", "Process Innovation", "Marketing Innovation", "Organizational Innovation"),
  Percentage = c(25, 30, 20, 25)
)

# Save the dataset to a txt file
write.table(innovation_data, file = "generated_dataset_session_1/pie_chart-innovation.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create a pie chart visualization
pie_chart <- ggplot(innovation_data, aes(x = "", y = Percentage, fill = Category)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = Category), position = position_stack(vjust = 0.5)) +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm")) +
  labs(title = "Innovation Categories Distribution")

# Save the pie chart as a PNG file
ggsave("generated_vis_session_1/pie_chart-innovation.png", pie_chart, width = 10, height = 8, units = "in")