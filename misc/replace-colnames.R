library(tidyverse)
library(readxl)

test_data <- read_xlsx("data-raw/test_data.xlsx")

colnames <- test_data %>%
  names() %>%
  as_tibble() %>%
  set_names("colname") %>%
  mutate(colname = case_when(
    colname == "respondent_index" ~ str_glue("{colname}"),
    TRUE ~ str_glue("Q{row_number()}")
  )) %>%
  pull(colname)


test_data %>%
  set_names(colnames)

