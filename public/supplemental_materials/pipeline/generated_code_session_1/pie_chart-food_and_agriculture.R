library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
food_agriculture_data <- tibble(
  Category = c("Grains", "Vegetables", "Fruits", "Meats", "Dairy"),
  Percentage = c(30, 25, 20, 15, 10)
)

# Save the dataset to a text file
write.table(food_agriculture_data, file = "generated_dataset_session_1/pie_chart-food_and_agriculture.txt", row.names = FALSE)

# Create a pie chart visualization
pie_chart <- ggplot(food_agriculture_data, aes(x = "", y = Percentage, fill = Category)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = Category), position = position_stack(vjust = 0.5)) +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm")) +
  labs(title = "Distribution of Food and Agriculture Sectors")

# Save the pie chart visualization to a PNG file
ggsave("generated_vis_session_1/pie_chart-food_and_agriculture.png", pie_chart, width = 10, height = 8, units = "in")

# The image is saved and not displayed as per the instructions