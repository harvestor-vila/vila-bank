library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # for reproducibility
data <- tibble(
  Country = c("Alandria", "Boravia", "Caledonia", "Deltora", "Euphoria", "Fernland", "Gloria"),
  GDP = sample(100:700, 7, replace = FALSE), # in billions of USD
  UnemploymentRate = sample(3:10, 7, replace = FALSE), # in percentage
  Population = sample(1:20, 7, replace = FALSE) * 1000000 # in millions
)

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/bubble_chart-economy.txt", row.names = FALSE, sep = "\t")

# Create a bubble chart
ggplot(data, aes(x = GDP, y = UnemploymentRate, size = Population, color = Country)) +
  geom_point(alpha = 0.7) +
  scale_size_continuous(range = c(3, 12)) +
  labs(title = "Bubble Chart of Economy Indicators",
       x = "GDP (in billions USD)",
       y = "Unemployment Rate (%)",
       size = "Population") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "right",
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the bubble chart as a PNG file
ggsave("generated_vis_session_1/bubble_chart-economy.png", width = 8, height = 6, dpi = 300)