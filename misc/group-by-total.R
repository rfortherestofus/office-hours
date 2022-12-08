# https://github.com/dgkeyes/dkmisc/blob/master/R/dk_summarize_with_totals.R

library(tidyverse)
library(palmerpenguins)

penguins

groups_summary <- penguins %>%
  group_by(island) %>%
  summarize(avg_body_mass = mean(body_mass_g,
                                 na.rm = TRUE))

overall_summary <- penguins %>%
  summarize(avg_body_mass = mean(body_mass_g,
                                 na.rm = TRUE)) %>%
  mutate(island = "Total")

bind_rows(groups_summary,
          overall_summary)

summarize_with_total <- function(data_frame, group_by_var, mean_var) {

  groups_summary <- data_frame %>%
    group_by({{ group_by_var }}) %>%
    summarize(mean = mean({{ mean_var }},
                          na.rm = TRUE)) %>%
    rename("group" = {{ group_by_var }} ) %>%
    mutate(group = as.character(group))

  overall_summary <- data_frame %>%
    summarize(mean = mean({{ mean_var }},
                          na.rm = TRUE)) %>%
    mutate(group = "Total")

  bind_rows(groups_summary,
            overall_summary)

}


summarize_with_total(data_frame = penguins,
                     group_by_var = island,
                     mean_var = body_mass_g)

