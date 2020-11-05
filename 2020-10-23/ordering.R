library(tidyverse)
library(palmerpenguins)
library(janitor)

penguins %>%
  count(species)

nhanes <- read_csv("2020-10-23/nhanes.csv") %>%
  clean_names()

library(forcats)

nhanes %>%
  count(health_gen) %>%
  drop_na(health_gen) %>%
  # mutate(health_gen = factor(health_gen,
  #                            levels = c("Poor", "Fair", "Good", "Vgood", "Excellent"))) %>%
  mutate(health_gen = fct_reorder(health_gen, n)) %>%
  ggplot(aes(x = health_gen,
             y = n)) +
  geom_col()

library(flextable)

nhanes %>%
  count(health_gen) %>%
  drop_na(health_gen) %>%
  arrange(desc(n)) %>%
  flextable()
