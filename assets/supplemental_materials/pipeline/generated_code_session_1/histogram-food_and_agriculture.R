library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a right-skewed dataset
set.seed(123) # For reproducibility
data <- tibble(
  'Yield_per_Acre' = rexp(n = 1000, rate = 0.2) # Right-skewed distribution
)

# Ensure all values are whole numbers
data <- data %>% 
  mutate(Yield_per_Acre = floor(Yield_per_Acre))

# Save the dataset to a txt file
write.table(data, file = "generated_dataset_session_1/histogram-food_and_agriculture.txt", row.names = FALSE)

# Create the histogram
histogram_plot <- ggplot(data, aes(x = Yield_per_Acre)) +
  geom_histogram(binwidth = 10, fill = "blue", color = "black") +
  labs(title = "Distribution of Agricultural Yield per Acre",
       x = "Yield per Acre (in whole numbers)",
       y = "Frequency") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(5.5, 5.5, 5.5, 5.5))

# Save the histogram as a png file
ggsave("generated_vis_session_1/histogram-food_and_agriculture.png", histogram_plot, width = 10, height = 8)

# The code ends here, and the outputs are saved in the specified locations