library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
innovation_data <- tibble(
  Innovation = c("AI", "Blockchain", "IoT", "5G", "Biotech", "Nanotech", "Robotics", "Quantum Computing", "VR/AR", "Renewable Energy"),
  Investments = sample(100:500, 10, replace = TRUE) # Random whole numbers between 100 and 500
)

# Save the dataset to a text file
write.table(innovation_data, file = "generated_dataset_session_1/bar_chart-innovation.txt", row.names = FALSE, sep = "\t")

# Create a bar chart visualization
bar_chart <- ggplot(innovation_data, aes(x = Innovation, y = Investments, fill = "blue")) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Investments in Innovation Sectors", x = "Sector", y = "Investment (in millions)") +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5),
        plot.margin = margin(5.5, 5.5, 5.5, 5.5, "points")) +
  scale_fill_manual(values = "blue")

# Save the bar chart as a PNG file
ggsave("generated_vis_session_1/bar_chart-innovation.png", bar_chart, width = 10, height = 6, units = "in")

# The image is saved and not displayed as per the instructions