
# Urban Institute Method --------------------------------------------------

# This code is adapted from
# https://medium.com/@urban_institute/iterated-fact-sheets-with-r-markdown-d685eb4eafce

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


# Using multireport -------------------------------------------------------

# Information on the multireport package, including installation instructions, is at
# https://dgkeyes.github.io/multireport/

library(multireport)

params_df <- bad_drivers %>%
  mutate(year = 2020) %>%
  select(state, year)

multireport(rmarkdown_file = "2020-10-09/report.Rmd",
            report_title_param = "state",
            params_data_frame = params_df,
            report_output_directory = "2020-10-09/output",
            report_format = "word_document")

file.exists("2020-10-09/output/Alabama.docx")

rmarkdown::pandoc_convert(input = "report.docx",
                          to = "markdown",
                          wd = "2020-10-09")
