library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate synthetic dataset
set.seed(123) # For reproducibility
weather_data <- tibble(
  City = c("City1", "City2", "City3", "City4", "City5", "City6", "City7", "City8", "City9", "City10",
           "City11", "City12", "City13", "City14", "City15", "City16", "City17", "City18", "City19", "City20"),
  Average_Temperature = sample(50:100, 20, replace = TRUE) # Random whole numbers between 50 and 100
)

# Save the dataset to a txt file
write.table(weather_data, file = "generated_dataset_session_1/bar_chart-weather_and_climate.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create the bar chart visualization
bar_chart <- ggplot(weather_data, aes(x = City, y = Average_Temperature, fill = "Temperature")) +
  geom_bar(stat = "identity", color = "blue", fill = "blue", show.legend = FALSE) +
  theme_minimal() +
  labs(title = "Average Temperature by City", x = "City", y = "Average Temperature (°F)") +
  theme(plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(5.5, 5.5, 5.5, 5.5, "points"))

# Save the bar chart image to a png file
ggsave("generated_vis_session_1/bar_chart-weather_and_climate.png", bar_chart, width = 10, height = 6, units = "in")

# The image is saved and not displayed as per the instructions