library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
years <- 2000:2019
categories <- c("Tech_Advancements", "Research_Development", "Patent_Filings", "New_Startups")
data_points <- length(years)

# Generate random data for each category
dataset <- map_dfr(categories, function(category) {
  tibble(
    Year = years,
    Category = category,
    Value = sample(50:200, data_points, replace = TRUE)
  )
})

# Save the dataset to a txt file
write.table(dataset, file = "generated_dataset_session_1/stacked_area_chart-innovation.txt", row.names = FALSE, sep = "\t")

# Create the stacked area chart
ggplot(dataset, aes(x = Year, y = Value, fill = Category)) +
  geom_area(position = 'stack') +
  scale_x_continuous(breaks = years, labels = as.character(years)) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.position = "bottom",
    plot.margin = margin(1, 1, 1, 1, "cm")
  ) +
  labs(
    title = "Innovation Trends Over Time",
    x = "Year",
    y = "Number of Innovations",
    fill = "Category"
  )

# Save the visualization as a PNG file
ggsave("generated_vis_session_1/stacked_area_chart-innovation.png", width = 10, height = 6, units = "in")