library(ggplot2)
library(tidyverse)
library(dplyr)

# Create a synthetic dataset with a symmetric distribution
set.seed(123) # For reproducibility
data <- tibble(Income = rnorm(1000, mean = 50000, sd = 10000)) %>%
  mutate(Income = round(Income / 1000) * 1000) %>%
  filter(Income > 0) # Ensure all values are whole numbers and positive

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/histogram-economy.txt", row.names = FALSE)

# Create the histogram visualization
histogram_plot <- ggplot(data, aes(x = Income)) +
  geom_histogram(binwidth = 5000, color = "black", fill = "blue") +
  labs(title = "Distribution of Incomes in the Economy",
       x = "Income (in USD)",
       y = "Number of Individuals") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the histogram visualization as a png file
ggsave("generated_vis_session_1/histogram-economy.png", histogram_plot, width = 10, height = 6)

# The code ends here, and the outputs are saved in the respective folders