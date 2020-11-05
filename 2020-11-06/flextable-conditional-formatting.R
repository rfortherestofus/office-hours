library(tidyverse)
library(flextable)
library(scales)

data <- tibble(
  survey_item = c("Item #1", "Item #2", "Item #3"),
  percent_program_agree = c(0.78, 0.6, 0.42),
  n_program_agree = c(45, 34, 46)
) %>%
  mutate(agree_text = str_c(percent(percent_program_agree),
                            " (n=",
                            n_program_agree,
                            ")"))

data

data %>%
  flextable(col_keys = c("survey_item", "agree_text")) %>%
  color(j = "agree_text",
        i = ~ percent_program_agree > 0.5,
        color = "blue")
