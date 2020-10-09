library(fivethirtyeight)
library(tidyverse)
library(rmarkdown)

state <- bad_drivers %>%
  pull(state)

reports <- tibble(
  input = "2020-10-09/report.Rmd",
  output_file = stringr::str_c("output/", state, "-driving.docx"),
  params = map(state, ~list(state = .))
)

reports %>%
  pwalk(render)


library(multireport)

params_df <- bad_drivers %>%
  mutate(year = 2020) %>%
  select(state, year)

multireport(rmarkdown_file = "2020-10-09/report.Rmd",
            report_title_param = "state",
            params_data_frame = params_df,
            report_output_directory = "output",
            report_format = "word_document")

