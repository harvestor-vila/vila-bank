library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
political_parties <- c("Conservative", "Liberal", "Socialist", "Green", "Libertarian", "Communist", "Centrist", "Nationalist", "Progressive", "Pirate")
votes <- sample(100:10000, length(political_parties), replace = TRUE) # Random whole numbers for votes
dataset <- data.frame(Party = political_parties, Votes = votes)

# Save the dataset to a text file
write.table(dataset, file = "generated_dataset_session_1/bar_chart-politics.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create the bar chart visualization
ggplot(dataset, aes(x = Party, y = Votes, fill = "blue")) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Votes per Political Party", x = "Political Party", y = "Number of Votes") +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(5.5, 5.5, 5.5, 5.5)) +
  scale_fill_manual(values = c("blue"))

# Save the bar chart image
ggsave("generated_vis_session_1/bar_chart-politics.png", width = 10, height = 6, dpi = 300)