

library(tidyverse)
library(janitor)
library(palmerpenguins)
library(flextable)
library(omni)

penguins_table <- penguins %>%
  flextable::flextable() %>%
  flextable::theme_zebra(even_body = "#9DAECE",
                         odd_body = "#CED6E6") %>%
  flextable::fontsize(part = "all", size = 11) %>%
  flextable::font(part = "all", fontname = "Lato") %>%
  flextable::bold(part = "header", bold = TRUE) %>%
  flextable::bold(part = "body", j = 1, bold = TRUE) %>%
  flextable::align(part = "all", align = "center") %>%
  flextable::bg(part = "header", bg = omni_colors("Dark Blue")) %>%
  flextable::color(part = "header", color = "white") %>%
  flextable::color(part = "body", color = "#333333") %>%
  flextable::bg(part = "body", j = 1, bg = omni_colors("Dark Blue")) %>%
  flextable::color(part = "body", j = 1, color = "white") %>%
  flextable::height_all(height = 0.4) %>%
  flextable::border_inner(part = "body", border = officer::fp_border(color = "white")) %>%
  flextable::border(part = "header", border.bottom = officer::fp_border(color = "white"))



# Send Email --------------------------------------------------------------

library(blastula)

create_smtp_creds_key(
  id = "gmail",
  user = "dgkeyes@gmail.com",
  host = "smtp.gmail.com",
  port = 465,
  use_ssl = TRUE,
  overwrite = TRUE,
  provider = "gmail"
)

test_message <- prepare_test_message() %>%
  add_attachment("misc/sample-report.pdf")

smtp_send(
  test_message,
  to = "david@rfortherestofus.com",
  from = "david@rfortherestofus.com",
  subject = "Test",
  credentials = creds_key("rru"),
  verbose = FALSE
)
