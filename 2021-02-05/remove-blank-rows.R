# Quick question. If I have a dataset of 40+ variables and several rows that are entirely NA,
# how I can create a variable that will easily identify these rows so that I can remove them?
# I suppose this would be similar to using the COUNTA function in Excel and removing all with a COUNTA of 0.

# If you could go over how to remove entirely blank rows, and rows that are blank save for perhaps an ID code (and how the remove these rows),
# that would be great.

library(tidyverse)
library(readxl)
library(janitor)


read_excel(path = "2021-02-05/REMOVE BLANK ROWS.xlsx")

read_excel(path = "2021-02-05/REMOVE BLANK ROWS.xlsx") %>%
  remove_empty(which = "rows")


read_excel(path = "2021-02-05/REMOVE BLANK ROWS.xlsx") %>%
  mutate(is_blank = case_when(
    is.na(Q1) & is.na(Q2) & is.na(Q3) & is.na(Q4) ~ "blank"
  )) # This is a comment



