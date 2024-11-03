library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic left-skewed dataset
set.seed(123) # for reproducibility
votes <- rexp(1000, rate = 0.2) # exponential distribution is right-skewed
votes <- max(votes) - votes # reflect to make it left-skewed
votes <- round(votes) # ensure whole numbers
votes <- votes[votes < 1500] # limit the range to ensure a left-skewed distribution

# Create a dataframe
df <- data.frame(Votes = votes)

# Save the dataset to a txt file
write.table(df, file = "generated_dataset_session_1/histogram-politics.txt", row.names = FALSE, col.names = TRUE)

# Create the histogram
p <- ggplot(df, aes(x = Votes)) +
  geom_histogram(bins = 10, fill = "blue", color = "black") +
  labs(title = "Distribution of Votes in a Hypothetical Primary Election",
       x = "Number of Votes",
       y = "Frequency of Candidates") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the histogram as a PNG file
ggsave("generated_vis_session_1/histogram-politics.png", plot = p, width = 10, height = 6, dpi = 300)