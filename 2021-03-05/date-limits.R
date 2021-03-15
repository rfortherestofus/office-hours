library(tidyverse)
library(lubridate)

lakers %>%
  mutate(date_time = ymd_hm(str_glue("{date} {time}"))) %>%
  mutate(date_time = floor_date(date_time, unit = "2 hours")) %>%
  select(date_time, etype, points) %>%
  group_by(date_time, etype) %>%
  summarize(total_points = sum(points)) %>%
  ungroup() %>%
  slice(1:100) %>%
  ggplot(aes(x = date_time,
             y = total_points)) +
  geom_col() +
  facet_wrap(~etype) +
  scale_x_date(
    limits = c(as.Date("2008-10-28"), as.Date("2008-10-29"))
  )

library(palmerpenguins)

penguins %>%
  ggplot(aes(x = bill_length_mm,
             y = bill_depth_mm)) +
  geom_point() +
  facet_wrap(~species,
             scales = "fixed")
