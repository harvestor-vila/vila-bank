library(ggplot2)
library(tidyverse)
library(dplyr)
library(scales)

# Create a synthetic dataset
set.seed(123) # for reproducibility
categories <- c("Product_Development", "Process_Innovation", "Service_Innovation", "Marketing_Innovation")
companies <- paste("Company", LETTERS[1:5])
data <- expand.grid(Company = companies, Category = categories)

# Assign random percentages that sum up to 100 for each company
data$Percentage <- runif(nrow(data))
data <- data %>%
  group_by(Company) %>%
  mutate(Percentage = Percentage / sum(Percentage)) %>%
  ungroup()

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/100_percent_stacked_bar_chart-innovation.txt", row.names = FALSE, sep = "\t")

# Create the 100 percent stacked bar chart
ggplot(data, aes(x = Company, y = Percentage, fill = Category)) +
  geom_bar(stat = "identity", position = "fill") +
  scale_y_continuous(labels = percent_format(), breaks = seq(0, 1, 0.2)) +
  labs(title = "Innovation Distribution by Company", x = "Company", y = "Percentage") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "bottom",
        plot.margin = margin(5.5, 5.5, 5.5, 5.5),
        axis.text.x = element_text(angle = 45, hjust = 1)) +
  guides(fill = guide_legend(title = "Innovation Category"))

# Save the visualization to a png file
ggsave("generated_vis_session_1/100_percent_stacked_bar_chart-innovation.png", width = 10, height = 6, units = "in")