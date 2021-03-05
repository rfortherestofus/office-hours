library(tidyverse)
library(slider)

date_time <- c("Jan 29 2020 13:46:08" ,
               "Jan 29 2020 13:42:53" ,
               "Jan 29 2020 12:13:27" ,
               "Jan 29 2020 12:11:19" ,
               "Jan 29 2020 12:09:21" ,
               "Jan 28 2020 12:22:26" ,
               "Jan 27 2020 8:22:20")

systol <- c(132  , 132  , 118  , 115  , 110 , 148 , 120)

df <- data.frame(date_time , systol) %>%
  mutate(dtetime = lubridate::mdy_hms(date_time)) %>%
  arrange(dtetime)

slide_period(df$dtetime,
             df$dtetime,
             .period = "minute",
             identity,
             .every = 10)
