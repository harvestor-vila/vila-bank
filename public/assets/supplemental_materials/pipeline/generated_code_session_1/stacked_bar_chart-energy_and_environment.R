library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
energy_sources <- c("Solar", "Wind", "Hydro", "Nuclear", "Fossil")
countries <- paste("Country", LETTERS[1:8])
data <- expand.grid(Country = countries, Source = energy_sources)
data$Production <- sample(100:1000, size = nrow(data), replace = TRUE)

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/stacked_bar_chart-energy_and_environment.txt", row.names = FALSE, sep = "\t")

# Create the stacked bar chart
ggplot(data, aes(x = Country, y = Production, fill = Source)) +
  geom_bar(stat = "identity") +
  labs(title = "Energy Production by Source and Country", x = "Country", y = "Energy Production (GWh)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "bottom",
        plot.margin = margin(1, 1, 1, 1, "cm")) +
  scale_fill_brewer(palette = "Set3") # To avoid overcrowding color legends

# Save the visualization to a png file
ggsave("generated_vis_session_1/stacked_bar_chart-energy_and_environment.png", width = 10, height = 6, units = "in")