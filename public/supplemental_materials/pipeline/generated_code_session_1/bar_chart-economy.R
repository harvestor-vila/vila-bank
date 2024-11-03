library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
economy_data <- tibble(
  Sector = c("Agriculture", "Manufacturing", "Services", "Construction", "Transportation", 
             "Retail", "Wholesale", "Finance", "Education", "Healthcare", "Technology", 
             "Energy", "Mining", "Real_Estate", "Government"),
  GDP_Contribution = sample(100:500, 15, replace = TRUE) # Random whole numbers
)

# Save the dataset to a txt file
write.table(economy_data, file = "generated_dataset_session_1/bar_chart-economy.txt", row.names = FALSE, col.names = TRUE)

# Create the bar chart visualization
ggplot(economy_data, aes(x = reorder(Sector, GDP_Contribution), y = GDP_Contribution, fill = "blue")) +
  geom_bar(stat = "identity") +
  labs(title = "GDP Contribution by Sector", x = "Sector", y = "GDP Contribution (in billions)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "none",
        axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(5.5, 5.5, 5.5, 5.5, "points")) +
  scale_fill_identity()

# Save the bar chart as a png file
ggsave("generated_vis_session_1/bar_chart-economy.png", width = 10, height = 6, units = "in")