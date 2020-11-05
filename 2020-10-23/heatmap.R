library(tidyverse)
library(palmerpenguins)
library(gt)

penguins %>%
  count(species) %>%
  gt() %>%
  data_color(
    columns = vars(n),
    colors = scales::col_numeric(
      palette = "Blues",
      domain = NULL)
  )
