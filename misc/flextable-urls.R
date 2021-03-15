library(tidyverse)
library(flextable)

dat <- data.frame(
  col = "Google it",
  href = "https://www.google.fr/search?source=hp&q=flextable+R+package",
  stringsAsFactors = FALSE)

ftab <- flextable(dat)
ftab <- compose( x = ftab, j = "col",
                 value = as_paragraph(
                   "This is a link: ",
                   hyperlink_text(x = col, url = href ) ) )
ftab
