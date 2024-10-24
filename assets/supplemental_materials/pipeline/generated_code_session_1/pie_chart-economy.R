library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset for the economy context
economy_data <- tibble(
  Sector = c("Agriculture", "Manufacturing", "Services", "Construction", "Technology"),
  Percentage = c(15, 25, 40, 10, 10)
)

# Ensure the dataset only contains whole numbers
economy_data <- economy_data %>% mutate(Percentage = as.integer(Percentage))

# Save the dataset to a txt file
write.table(economy_data, file = "generated_dataset_session_1/pie_chart-economy.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create a pie chart visualization
pie_chart <- ggplot(economy_data, aes(x = "", y = Percentage, fill = Sector)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = Sector), position = position_stack(vjust = 0.5)) +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm")) +
  labs(title = "Economic Sector Distribution")

# Save the pie chart image to a png file
ggsave("generated_vis_session_1/pie_chart-economy.png", pie_chart, width = 10, height = 8, units = "in")