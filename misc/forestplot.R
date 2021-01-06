library(tidyverse)
library(patchwork)

data <- tibble::tribble(
  ~Agegroups, ~Rateratio, ~LCI, ~UCI,
       "<15",        2.6,  1.5,  4.1,
     "15-24",        3.2,  2.5,  3.7,
     "25-39",        3.2,  2.6,    4,
     "40-49",        4.1,  3.2,  5.3,
     "50-59",          3,  2.3,    4,
       "60+",        2.9,  2.1,  3.7,
     "Total",        2.9,  2.6,  3.1
  )


plot <- data %>%
  ggplot(aes(x = Rateratio,
             xmin = LCI,
             xmax = UCI,
             y = Agegroups)) +
  geom_pointrange() +
  theme_minimal() +
  labs(x = NULL,
       y = NULL)


(plot + plot) /
  (plot + plot)
