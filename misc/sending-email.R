
# Blastula ----------------------------------------------------------------

library(blastula)
library(palmerpenguins)

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



# Send Rmd ----------------------------------------------------------------

render_email(input = "misc/blastula-example.Rmd") %>%
  smtp_send(
    to = "david@rfortherestofus.com",
    from = "dgkeyes@gmail.com",
    subject = "Test from Rmd",
    credentials = creds_key("gmail"),
    verbose = FALSE
  )
