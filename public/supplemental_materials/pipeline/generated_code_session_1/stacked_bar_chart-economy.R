library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate synthetic dataset
set.seed(123) # For reproducibility
sectors <- c("Agriculture", "Manufacturing", "Services", "Construction", "Technology")
years <- as.factor(2015:2022) # 8 years
data <- expand.grid(Year = years, Sector = sectors)
data$Income <- sample(100:500, size = nrow(data), replace = TRUE)

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/stacked_bar_chart-economy.txt", row.names = FALSE, sep = "\t")

# Create the stacked bar chart
ggplot(data, aes(x = Year, y = Income, fill = Sector)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Annual Income by Sector", x = "Year", y = "Income (in millions)", fill = "Sector") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(5.5, 40, 5.5, 5.5),
        legend.position = "bottom",
        axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_brewer(palette = "Set3") # Using a color palette that is distinct and not too bright

# Save the visualization to a png file
ggsave("generated_vis_session_1/stacked_bar_chart-economy.png", width = 10, height = 6, units = "in")