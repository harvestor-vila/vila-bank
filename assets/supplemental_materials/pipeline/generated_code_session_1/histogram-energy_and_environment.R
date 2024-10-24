library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a left-skewed dataset
set.seed(123) # For reproducibility
data <- data.frame(
  EnergyConsumption = c(rexp(200, rate = 0.1), rnorm(50, mean = 50, sd = 5))
)

# Ensure all values are whole numbers and the distribution is left-skewed
data$EnergyConsumption <- floor(data$EnergyConsumption[data$EnergyConsumption > 0])

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/histogram-energy_and_environment.txt", row.names = FALSE)

# Create the histogram
histogram_plot <- ggplot(data, aes(x = EnergyConsumption)) +
  geom_histogram(bins = 15, fill = "blue", color = "black") +
  labs(title = "Histogram of Energy Consumption",
       x = "Energy Consumption (MWh)",
       y = "Frequency") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the histogram as a png file
ggsave("generated_vis_session_1/histogram-energy_and_environment.png", histogram_plot, width = 10, height = 6)

# The code ends here, and the image is saved without displaying it