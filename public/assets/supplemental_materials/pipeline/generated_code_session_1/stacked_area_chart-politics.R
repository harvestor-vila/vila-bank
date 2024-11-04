library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset
set.seed(123) # For reproducibility
years <- 2000:2019
parties <- c("Conservative", "Liberal", "Green", "Libertarian")
data_points <- length(years)

# Generate random data
votes <- matrix(sample(100:1000, length(parties) * data_points, replace = TRUE), ncol = data_points)
colnames(votes) <- years
rownames(votes) <- parties

# Convert to data frame for ggplot
df <- as.data.frame(votes)
df <- t(df)
df <- as.data.frame(df)
df$Year <- as.numeric(rownames(df))
df_long <- gather(df, key = "Party", value = "Votes", -Year)

# Save the dataset
write.table(df_long, file = "generated_dataset_session_1/stacked_area_chart-politics.txt", row.names = FALSE, col.names = TRUE, sep = "\t")

# Create the stacked area chart
ggplot(df_long, aes(x = Year, y = Votes, fill = Party)) +
  geom_area(position = 'stack') +
  scale_x_continuous(breaks = years, labels = as.character(years)) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "bottom",
        axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Political Party Votes Over Time",
       x = "Year",
       y = "Votes",
       fill = "Party")

# Save the visualization
ggsave("generated_vis_session_1/stacked_area_chart-politics.png", width = 10, height = 6, units = "in")