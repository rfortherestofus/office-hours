library(tidyverse)
library(janitor)
library(palmerpenguins)
library(gt)

crosstabs <- penguins %>%
  tabyl(species, island, sex)

crosstabs[3] %>%
  map_df(bind_rows) %>%
  gt()


penguins %>%
  tabyl(species, island) %>%
  gt()
