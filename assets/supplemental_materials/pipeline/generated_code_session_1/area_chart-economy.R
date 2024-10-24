library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset
set.seed(123) # For reproducibility
data_points <- 20
economy_data <- tibble(
  Year = 2000 + (1:data_points),
  GDP = round(runif(data_points, min = 100, max = 1000))
)

# Ensure the dataset has a decreasing trend
economy_data <- economy_data %>%
  arrange(desc(GDP)) %>%
  mutate(GDP = cummax(GDP))

# Save the dataset to a txt file
write.table(economy_data, file = "generated_dataset_session_1/area_chart-economy.txt", row.names = FALSE, sep = "\t")

# Create an area chart
area_chart <- ggplot(economy_data, aes(x = Year, y = GDP)) +
  geom_area(fill = "skyblue", alpha = 0.5) +
  geom_line(color = "blue") +
  labs(title = "Economy Area Chart", x = "Year", y = "GDP (in Billions)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the area chart as a png file
ggsave("generated_vis_session_1/area_chart-economy.png", area_chart, width = 8, height = 6)