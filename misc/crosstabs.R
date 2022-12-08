library(tidyverse)
library(janitor)
library(palmerpenguins)
library(gt)

penguins %>%
  tabyl(species, island, sex)


crosstabs <- penguins %>%
  tabyl(species, island, sex)

temp <- crosstabs[2]

crosstabs[2] %>%
  map_df(bind_rows) %>%
  gt()


penguins %>%
  tabyl(species, island) %>%
  gt()
