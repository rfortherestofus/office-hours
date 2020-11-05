library(tidyverse)
library(palmerpenguins)
library(skimr)

penguins_summary <- penguins %>%
  group_by(species, island, sex) %>%
  summarize(total_bill_length = sum(bill_length_mm,
                                    na.rm = TRUE),
            .groups = "keep")

penguins_summary

penguins_summary %>%
  skim()

penguins_summary %>%
  summarize(total_bill_length = sum(total_bill_length))

test

getwd()
