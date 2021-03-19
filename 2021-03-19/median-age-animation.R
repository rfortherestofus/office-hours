library(tidyverse)
library(tidycensus)
library(janitor)
library(hrbrthemes)
library(gganimate)

theme_set(theme_ipsum())

median_age_2010 <- get_decennial(geography = "state",
                                 variables = "P013001",
                                 year = 2010,
                                 geometry = TRUE) %>%
  clean_names() %>%
  mutate(year = 2010)

median_age_2000 <- get_decennial(geography = "state",
                                 variables = "P013001",
                                 year = 2000,
                                 geometry = TRUE) %>%
  clean_names() %>%
  mutate(year = 2000)

median_age <- bind_rows(median_age_2000,
                        median_age_2010) %>%
  select(name, value, year) %>%
  set_names("state", "median_age", "year", "geometry") %>%
  filter(state %in% c("Oregon"))

median_age

median_age_map <- median_age %>%
  ggplot(aes(fill = median_age)) +
  geom_sf()

median_age_map_animated <- median_age_map +
  transition_states(
    year
  )


anim_save(median_age_map_animated,
          filename = "2021-03-19/median_age_map_animated.gif",
          nframes = 75,
          end_pause = 10,
          width = 1000,
          height = 500,
          type = "cairo")

median_age_plot <- median_age %>%
  ggplot(aes(x = median_age,
             y = state)) +
  geom_col()

median_age_plot

median_age_animated_plot <- median_age_plot +
  transition_reveal(
    year, keep_last = TRUE
  )

anim_save(median_age_animated_plot,
          filename = "2021-03-19/median_age_animated_plot.gif",
          nframes = 75,
          end_pause = 10,
          width = 1000,
          height = 500,
          type = "cairo")
