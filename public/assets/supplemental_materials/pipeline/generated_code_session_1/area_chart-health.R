library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
data_points <- 20
health_data <- tibble(
  Day = 1:data_points,
  PatientsRecovered = cumsum(sample(5:15, data_points, replace = TRUE)) # Cumulative sum to ensure increasing trend
)

# Save the dataset to a txt file
write.table(health_data, file = "generated_dataset_session_1/area_chart-health.txt", row.names = FALSE)

# Create an area chart
area_chart <- ggplot(health_data, aes(x = Day, y = PatientsRecovered)) +
  geom_area(fill = "skyblue", alpha = 0.5) +
  labs(title = "Number of Patients Recovered Over Time", x = "Day", y = "Patients Recovered") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "none")

# Save the area chart as a png file
ggsave("generated_vis_session_1/area_chart-health.png", area_chart, width = 10, height = 6, units = "in")