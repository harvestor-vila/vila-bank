library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
years <- seq(2000, 2019)
graduates <- round(runif(20, min = 50, max = 1000))
graduates <- cumsum(graduates) # Ensure an increasing trend
education_data <- data.frame(Year = years, Graduates = graduates)

# Save the dataset to a txt file
write.table(education_data, file = "generated_dataset_session_1/area_chart-education.txt", row.names = FALSE, sep = "\t")

# Create an area chart visualization
area_chart <- ggplot(education_data, aes(x = Year, y = Graduates)) +
  geom_area(fill = "skyblue", alpha = 0.5) +
  geom_line(color = "blue") +
  labs(title = "Number of Graduates Over Years", x = "Year", y = "Number of Graduates") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(5.5, 5.5, 5.5, 5.5, "points"),
        legend.position = "none")

# Save the area chart visualization to a png file
ggsave("generated_vis_session_1/area_chart-education.png", area_chart, width = 10, height = 6, units = "in")

# The image is saved and not displayed as per the instructions