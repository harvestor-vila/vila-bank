library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
parties <- c("Party_A", "Party_B", "Party_C", "Party_D")
issues <- c("Economy", "Healthcare", "Education", "Defense", "Environment")
num_bars <- sample(3:8, 1) # Number of bars (states/regions) between 3 and 8
data <- expand.grid(State=1:num_bars, Issue=issues) %>%
  mutate(Party = sample(parties, size = n(), replace = TRUE),
         Votes = sample(100:1000, size = n(), replace = TRUE)) %>%
  group_by(State, Issue) %>%
  mutate(Proportion = Votes / sum(Votes)) %>%
  ungroup() %>%
  arrange(State, desc(Proportion)) %>%
  group_by(State) %>%
  slice_head(n = 5) %>%
  ungroup()

# Save the dataset
write.table(data, file = "generated_dataset_session_1/stacked_bar_chart-politics.txt", row.names = FALSE, sep = "\t")

# Create a stacked bar chart
ggplot(data, aes(x = factor(State), y = Votes, fill = Issue)) +
  geom_bar(stat = "identity") +
  labs(title = "Political Issues by State", x = "State", y = "Votes", fill = "Issue") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "bottom",
        plot.margin = margin(1, 1, 1, 1, "cm"),
        axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_brewer(palette = "Set3")

# Save the visualization
ggsave("generated_vis_session_1/stacked_bar_chart-politics.png", width = 10, height = 6, units = "in")