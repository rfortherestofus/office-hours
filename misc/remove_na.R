library(tidyverse)
library(janitor)

read_csv("misc/Anonymous-sample-data.csv") %>%
  clean_names() %>%
  pivot_longer(cols = -(email:custom_1_grad_date),
               names_to = "major_number",
               values_to = "major") %>%
  drop_na(major) %>%
  write_csv("misc/Anonymous-sample-data-filtered.csv")



