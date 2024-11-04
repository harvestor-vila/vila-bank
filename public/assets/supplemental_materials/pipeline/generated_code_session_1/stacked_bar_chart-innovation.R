library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
categories <- c("Tech", "Health", "Energy", "Education", "Finance", "Transport", "Environment", "Agriculture")
innovation_types <- c("Patents", "Research", "Startups", "Investments", "Collaborations")

data <- expand.grid(Category = categories, InnovationType = innovation_types) %>%
  mutate(Value = sample(50:200, size = n(), replace = TRUE)) %>%
  arrange(Category)

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/stacked_bar_chart-innovation.txt", row.names = FALSE, sep = "\t")

# Create the stacked bar chart
ggplot(data, aes(x = Category, y = Value, fill = InnovationType)) +
  geom_bar(stat = "identity") +
  labs(title = "Innovation Landscape by Sector", x = "Sector", y = "Number of Innovations") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "bottom",
        plot.margin = margin(1, 1, 1, 1, "cm"),
        axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_brewer(palette = "Set3") # Using a color palette that is distinct and not too bright

# Save the visualization to a png file
ggsave("generated_vis_session_1/stacked_bar_chart-innovation.png", width = 10, height = 6, units = "in")