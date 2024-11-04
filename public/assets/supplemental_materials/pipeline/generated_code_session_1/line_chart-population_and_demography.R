library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
years <- seq(2000, 2019)
population <- round(runif(20, min=1000000, max=10000000))
population <- cumsum(population) # Ensure an increasing trend
dataset <- data.frame(Year = years, Population = population)

# Save the dataset to a txt file
write.table(dataset, file = "generated_dataset_session_1/line_chart-population_and_demography.txt", row.names = FALSE, sep = "\t")

# Create the line chart
line_chart <- ggplot(dataset, aes(x = Year, y = Population)) +
  geom_line(color = "blue") +
  geom_point(color = "red") +
  labs(title = "Population Growth Over Years", x = "Year", y = "Population") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the line chart as a png file
ggsave("generated_vis_session_1/line_chart-population_and_demography.png", line_chart, width = 8, height = 6)