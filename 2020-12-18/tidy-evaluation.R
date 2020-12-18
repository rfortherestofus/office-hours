

library(tidyverse)
library(janitor)
library(palmerpenguins)


calculate_avg_single_var <- function(group_by_variable) {

  penguins %>%
    group_by({{ group_by_variable }}) %>%
    summarize(avg = mean(bill_length_mm,
                         na.rm = TRUE)) %>%
    ungroup()

}


calculate_avg_single_var(group_by_variable = island)



calculate_avg_multiple_vars <- function(group_by_variables) {

  penguins %>%
    group_by(!!!group_by_variables) %>%
    summarize(avg = mean(bill_length_mm,
                         na.rm = TRUE)) %>%
    ungroup()

}


calculate_avg(group_by_variables = vars(island, species))
