library(tidyverse)
library(palmerpenguins)
library(flextable)

penguins %>%
  count(species) %>%
  # set_names(c("Species", "Total")) %>%
  rename("Total" = "n") %>%
  flextable() %>%
  bg(j = "Total",
     i = ~ Total > 70,
     bg = "yellow")

