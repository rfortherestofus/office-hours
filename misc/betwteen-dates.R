library(tidyverse)
library(gapminder)
library(lubridate)

df %>%
  mutate(hire_groups = case_when(
    between(date, "18/09/01", "19/02/28") ~ "Sept 2018 to Feb 2019",
    between(date, "19/03/01", "19/09/25") ~ "March 2019 to Oct 2019",
    TRUE ~ "Before Sept 2018"))

gapminder %>%
  mutate(year_2 = str_glue("{year}/01/01")) %>%
  select(year, year_2) %>%
  mutate(year_2 = ymd(year_2)) %>%
  filter(year_2 > ymd("1980-01-01")) %>%
  filter(year_2 < ymd("1990-01-01")) %>%
  view()

