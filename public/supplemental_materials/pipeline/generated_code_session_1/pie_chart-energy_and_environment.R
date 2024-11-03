library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
energy_sources <- c("Solar", "Wind", "Hydro", "Nuclear", "Coal", "Natural Gas")
percentages <- c(20, 25, 15, 10, 20, 10) # Ensure they sum to 100 for a pie chart
energy_data <- data.frame(Source = energy_sources, Percentage = percentages)

# Save the dataset to a txt file
write.table(energy_data, file = "generated_dataset_session_1/pie_chart-energy_and_environment.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create the pie chart
pie_chart <- ggplot(energy_data, aes(x = "", y = Percentage, fill = Source)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = Source), position = position_stack(vjust = 0.5)) +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm")) +
  labs(title = "Energy Sources Distribution")

# Save the pie chart image to a png file
ggsave("generated_vis_session_1/pie_chart-energy_and_environment.png", pie_chart, width = 10, height = 8, units = "in")

# The image is saved and not displayed as per the instructions