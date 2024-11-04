library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
political_data <- tibble(
  Party = c("Liberal", "Conservative", "Green", "Libertarian", "Socialist", "Progressive"),
  Votes = sample(100000:500000, 6), # Number of votes
  Seats = round(Votes / 100000), # Number of seats won (simplified)
  Funding = round(runif(6, 1, 10) * 1000000) # Funding in dollars
)

# Ensure positive correlation between Votes and Seats
political_data <- political_data %>% 
  arrange(Votes) %>% 
  mutate(Seats = cumsum(Seats))

# Save the dataset to a text file
write.table(political_data, file = "generated_dataset_session_1/bubble_chart-politics.txt", row.names = FALSE)

# Create the bubble chart
ggplot(political_data, aes(x = Votes, y = Seats, size = Funding, color = Party)) +
  geom_point(alpha = 0.7) +
  scale_size_continuous(range = c(3, 12)) + # Adjust the size range for better visibility
  labs(title = "Political Party Performance", x = "Votes", y = "Seats", size = "Funding") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), # Center the title
        legend.position = "right", # Position the legend
        plot.margin = margin(1, 1, 1, 1, "cm")) # Set margins

# Save the bubble chart as a PNG image
ggsave("generated_vis_session_1/bubble_chart-politics.png", width = 8, height = 6)