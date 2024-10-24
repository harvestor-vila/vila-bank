library(ggplot2)
library(tidyverse)
library(dplyr)
library(scales)

# Create a synthetic dataset
set.seed(123) # For reproducibility
sectors <- c("Agriculture", "Manufacturing", "Services", "Construction", "Technology")
years <- c("2019", "2020", "2021")

data <- expand.grid(Sector = sectors, Year = years) %>%
  mutate(Percentage = round(runif(n = nrow(.), min = 0, max = 100))) %>%
  group_by(Year) %>%
  mutate(Percentage = round(Percentage / sum(Percentage) * 100)) %>%
  ungroup()

# Adjust the last sector to make sure each year sums to 100
data <- data %>%
  group_by(Year) %>%
  mutate(Adjustment = 100 - cumsum(Percentage)) %>%
  ungroup()

last_sector_indices <- c(tapply(1:nrow(data), data$Year, function(x) tail(x, 1)))
data$Percentage[last_sector_indices] <- data$Percentage[last_sector_indices] + data$Adjustment[last_sector_indices]
data <- data %>% select(-Adjustment)

# Save the dataset
write.table(data, file = "generated_dataset_session_1/100_percent_stacked_bar_chart-economy.txt", row.names = FALSE, sep = "\t")

# Create the 100 percent stacked bar chart
ggplot(data, aes(x = Year, y = Percentage, fill = Sector)) +
  geom_bar(stat = "identity", position = "fill") +
  scale_y_continuous(labels = percent_format(), breaks = seq(0, 1, 0.2)) +
  labs(title = "Sector Contributions to Economy Over Years", x = "Year", y = "Percentage") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "bottom",
        plot.margin = margin(1, 1, 1, 1, "cm"))

# Save the visualization
ggsave("generated_vis_session_1/100_percent_stacked_bar_chart-economy.png", width = 8, height = 6)