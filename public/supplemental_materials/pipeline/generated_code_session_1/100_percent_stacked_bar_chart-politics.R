library(ggplot2)
library(tidyverse)
library(dplyr)
library(scales)

# Create a synthetic dataset
set.seed(123) # for reproducibility
parties <- c("Party_A", "Party_B", "Party_C", "Party_D")
issues <- c("Economy", "Healthcare", "Education", "Defense", "Environment")

data <- expand.grid(Issue = issues, Party = parties) %>%
  mutate(Percentage = sample(1:100, size = n(), replace = TRUE)) %>%
  group_by(Issue) %>%
  mutate(Percentage = round(Percentage / sum(Percentage), 2)) %>%
  ungroup()

# Ensure that each bar adds up to 100%
data <- data %>%
  group_by(Issue) %>%
  mutate(Residual = 1 - sum(Percentage),
         Percentage = ifelse(row_number() == n(), Percentage + Residual, Percentage)) %>%
  ungroup()

# Convert percentages to whole numbers
data$Percentage <- round(data$Percentage * 100)

# Save the dataset
write.table(data, file = "generated_dataset_session_1/100_percent_stacked_bar_chart-politics.txt", row.names = FALSE, sep = "\t")

# Create the 100 percent stacked bar chart
ggplot(data, aes(x = Issue, y = Percentage, fill = Party)) +
  geom_bar(stat = "identity", position = "fill") +
  scale_y_continuous(labels = percent_format(), breaks = seq(0, 1, 0.2)) +
  labs(title = "Political Issues by Party", x = "Issue", y = "Percentage") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "bottom",
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the visualization
ggsave("generated_vis_session_1/100_percent_stacked_bar_chart-politics.png", width = 10, height = 6)