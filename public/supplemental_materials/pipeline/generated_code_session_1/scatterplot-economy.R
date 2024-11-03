library(ggplot2)
library(tidyverse)
library(dplyr)

# Generate a synthetic dataset with a positive correlation
set.seed(123) # For reproducibility
n <- sample(20:50, 1) # Number of data points between 20 and 50
GDP <- round(runif(n, 500, 2000)) # Simulated GDP in billions
UnemploymentRate <- round(10 - GDP / 200) # Simulated Unemployment Rate with a negative relationship

# Create a data frame
economy_data <- data.frame(GDP, UnemploymentRate)

# Save the dataset to a txt file
write.table(economy_data, file = "generated_dataset_session_1/scatterplot-economy.txt", row.names = FALSE)

# Create the scatterplot
scatterplot <- ggplot(economy_data, aes(x = GDP, y = UnemploymentRate)) +
  geom_point(color = "blue") +
  ggtitle("Relationship between GDP and Unemployment Rate") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), # Center the title
        plot.margin = margin(1, 1, 1, 1, "cm"), # Set margins
        legend.position = "none") # No legend required

# Save the scatterplot to a png file
ggsave("generated_vis_session_1/scatterplot-economy.png", scatterplot, width = 8, height = 6)

# The code ends here, and the files are saved in the respective folders.