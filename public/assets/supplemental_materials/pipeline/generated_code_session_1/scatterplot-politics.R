library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset
set.seed(123) # For reproducibility
num_data_points <- sample(20:50, 1)
voter_turnout <- sample(50:90, num_data_points, replace = TRUE) # Voter turnout percentage
opposition_support <- 100 - voter_turnout + rnorm(num_data_points, mean = 0, sd = 5) # Opposition support percentage
opposition_support[opposition_support < 0] <- 0 # Ensure no negative values
opposition_support <- round(opposition_support)

politics_data <- data.frame(VoterTurnout = voter_turnout, OppositionSupport = opposition_support)

# Save the dataset to a txt file
write.table(politics_data, file = "generated_dataset_session_1/scatterplot-politics.txt", row.names = FALSE, col.names = TRUE)

# Create the scatterplot visualization
scatterplot <- ggplot(politics_data, aes(x = VoterTurnout, y = OppositionSupport)) +
  geom_point(color = "blue") +
  ggtitle("Voter Turnout vs Opposition Support") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), # Center the title
        plot.margin = margin(1, 1, 1, 1, "cm"), # Set margins
        legend.position = "none") + # Remove legend
  labs(x = "Voter Turnout (%)", y = "Opposition Support (%)")

# Save the scatterplot image
ggsave("generated_vis_session_1/scatterplot-politics.png", scatterplot, width = 8, height = 6, dpi = 300)