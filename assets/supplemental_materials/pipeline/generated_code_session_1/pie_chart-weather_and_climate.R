library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
weather_data <- tibble(
  Climate_Category = c("Tropical", "Arid", "Temperate", "Cold", "Polar"),
  Percentage = c(20, 15, 30, 25, 10) # Ensure these sum to 100
)

# Save the dataset to a txt file
write.table(weather_data, file = "generated_dataset_session_1/pie_chart-weather_and_climate.txt", row.names = FALSE)

# Create a pie chart
pie_chart <- ggplot(weather_data, aes(x = "", y = Percentage, fill = Climate_Category)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = Climate_Category), position = position_stack(vjust = 0.5)) +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm")) +
  labs(title = "Climate Category Distribution")

# Save the pie chart image to a png file
ggsave("generated_vis_session_1/pie_chart-weather_and_climate.png", pie_chart, width = 10, height = 8, units = "in")