library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
politics_data <- tibble(
  Party = c("Conservative", "Liberal", "Socialist", "Green", "Libertarian"),
  Percentage = c(35, 30, 15, 10, 10)
)

# Save the dataset to a txt file
write.table(politics_data, file = "generated_dataset_session_1/pie_chart-politics.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create a pie chart
pie_chart <- ggplot(politics_data, aes(x = "", y = Percentage, fill = Party)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = Party), position = position_stack(vjust = 0.5)) +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm")) +
  labs(title = "Political Party Distribution")

# Save the pie chart image
ggsave("generated_vis_session_1/pie_chart-politics.png", pie_chart, width = 10, height = 8, units = "in")