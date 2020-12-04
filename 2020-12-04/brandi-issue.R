library(tidyverse)

data <- tibble(
  trainee = c("David", "David", "David"),
  completed_hours = c(1, 50, 45),
  registered_hours = c(10, 56, 78)
)

data %>%
  pivot_longer(
    cols = -trainee,
    names_to = "type_of_hours",
    values_to = "number_of_hours"
  ) %>%
  group_by(trainee, type_of_hours) %>%
  summarize(total = sum(number_of_hours)) %>%
  ungroup() %>%
  pivot_wider(id_cols = trainee,
              names_from = type_of_hours,
              values_from = total)

