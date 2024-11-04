library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
education_data <- data.frame(
  Category = c("Elementary", "Middle School", "High School", "Undergraduate", "Postgraduate"),
  Percentage = c(25, 20, 30, 15, 10)
)

# Save the dataset to a txt file
write.table(education_data, file = "generated_dataset_session_1/pie_chart-education.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create a pie chart visualization
pie_chart <- ggplot(education_data, aes(x = "", y = Percentage, fill = Category)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = Category), position = position_stack(vjust = 0.5)) +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm")) +
  labs(title = "Distribution of Education Levels")

# Save the pie chart as a png file
ggsave("generated_vis_session_1/pie_chart-education.png", pie_chart, width = 10, height = 8, units = "in")

# The image is saved and not displayed as per the instructions