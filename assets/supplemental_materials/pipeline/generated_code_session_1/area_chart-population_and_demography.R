library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
years <- seq(2000, 2019)
population <- round(runif(20, min = 1000, max = 5000))
population <- sort(population, decreasing = TRUE) # Ensure a decreasing trend
data <- data.frame(Year = years, Population = population)

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/area_chart-population_and_demography.txt", row.names = FALSE, sep = "\t")

# Create an area chart
area_chart <- ggplot(data, aes(x = Year, y = Population)) +
  geom_area(fill = "skyblue", alpha = 0.5) +
  labs(title = "Population Trend Over Years", x = "Year", y = "Population") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), # Center the title
        plot.margin = margin(1, 1, 1, 1, "cm"), # Set margins
        legend.position = "none") # No legend needed

# Save the area chart as a png file
ggsave("generated_vis_session_1/area_chart-population_and_demography.png", area_chart, width = 8, height = 6, units = "in")

# Note: The actual creation of folders and file saving will depend on the R session's working directory.