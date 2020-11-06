library(tidyverse)
library(flextable)
library(scales)


# Attempt #1 --------------------------------------------------------------



data <- tibble(
  survey_item = c("Item #1", "Item #2", "Item #3"),
  percent_program_agree = c(0.78, 0.6, 0.42),
  n_program_agree = c(45, 34, 46)) %>%
  mutate(agree_text = str_c(percent(percent_program_agree),
                            " (n=",
                            n_program_agree,
                            ")"))

data

data %>%
  # flextable() %>%
  flextable(col_keys = c("survey_item", "agree_text")) %>%
  color(j = "agree_text",
        i = ~ percent_program_agree > 0.5,
        color = "blue")



# Attempt #2 --------------------------------------------------------------


data <- tibble(

  survey_item = c("Item #1 has to do with food people like to eat", "Item #2 is all about travel and places people like to go", "Item #3 is about movies people like to watch at home and used to see in theatres"),

  percent_program_agree = c(0.78, 0.6, 0.42),

  n_program_agree = c(45, 34, 46)

) %>%

  mutate(agree_text = str_c(percent(percent_program_agree),

                            " (n=",

                            n_program_agree,

                            ")"))

data

data %>%
  flextable(col_keys = c("survey_item", "code", "agree_text")) %>%
  bg(j = "code",
     i = ~ percent_program_agree >= 0.6,
     bg = "blue") %>%
  bg(j = "code",
     i = ~ percent_program_agree < 0.6,
     bg = "red") %>%
  width(j = "code", width = .05) %>%
  width(j = "agree_text", width = 1) %>%
  width(j = "survey_item", width = 4) %>%
  align(j = c("survey_item", "agree_text"), align = "left", part = "all") %>%
  padding(j = "code", padding.top = 1, part = "body")


data %>%
  mutate(code = "◉") %>%
  flextable(col_keys = c("survey_item", "code", "agree_text")) %>%
  color(j = "code",
     i = ~ percent_program_agree >= 0.6,
     color = "blue") %>%
  color(j = "code",
     i = ~ percent_program_agree < 0.6,
     color = "red") %>%
  width(j = "code", width = .05) %>%
  width(j = "agree_text", width = 1) %>%
  width(j = "survey_item", width = 4) %>%
  align(j = c("survey_item", "agree_text"), align = "left", part = "all") %>%
  padding(j = "code", padding.top = 1, part = "body")
