# This is the code to recreate this map from the New York Times
# https://github.com/rfortherestofus/office-hours/blob/master/2020-11-20/nyt-arrows.png
# Inspired by this: https://twitter.com/goose0009/status/1327622045866340354

# Load Packages -----------------------------------------------------------

library(tidyverse)
library(janitor)
library(urbnmapr)
library(sf)
library(hrbrthemes)

# Import Data -------------------------------------------------------------


# * Election Data ---------------------------------------------------------

# Data comes from: https://github.com/tonmcg/US_County_Level_Election_Results_08-20

election_results_2016 <- read_csv("https://github.com/tonmcg/US_County_Level_Election_Results_08-20/raw/master/2016_US_County_Level_Presidential_Results.csv") %>%
  select(-X1) %>%
  mutate(year = 2016) %>%
  mutate(per_point_diff = parse_number(per_point_diff)) %>%
  mutate(per_point_diff = per_point_diff / 100)

election_results_2020 <- read_csv("https://github.com/tonmcg/US_County_Level_Election_Results_08-20/raw/master/2020_US_County_Level_Presidential_Results.csv") %>%
  mutate(year = 2020)

election_results <- bind_rows(election_results_2016,
                              election_results_2020) %>%
  mutate(county_fips = case_when(
    year == 2020 ~ as.character(county_fips),
    str_length(combined_fips) == 4 ~ str_pad(combined_fips, width = 5, side = "left", pad = 0),
    TRUE ~ as.character(combined_fips)
  )) %>%
  mutate(pct_dem_vs_gop = per_dem - per_gop) %>%
  pivot_wider(id_cols = county_fips,
              names_from = year,
              values_from = pct_dem_vs_gop) %>%
  clean_names() %>%
  mutate(change_dem_vs_gop = x2020 - x2016) %>%
  select(county_fips, change_dem_vs_gop)


# * Geospatial Data -------------------------------------------------------

county_map <- get_urbn_map("counties", sf = TRUE) %>%
  st_centroid() %>%
  # Bunch of code taken from https://twitter.com/zoowalk/status/1325677709469552641/photo/1
  mutate(x = map_dbl(geometry, pluck, 1)) %>%
  mutate(y = map_dbl(geometry, pluck, 2)) %>%
  st_drop_geometry() %>%
  left_join(election_results, by = "county_fips") %>%
  mutate(winner = case_when(
    change_dem_vs_gop > 0 ~ "Democrats",
    TRUE ~ "Republicans"
  )) %>%
  mutate(xend = case_when(
    winner == "Democrats" ~ x - (250000 * change_dem_vs_gop),
    winner == "Republicans" ~ x - (250000 * change_dem_vs_gop)
  )) %>%
  mutate(yend = case_when(
    winner == "Democrats" ~ y + (200000 * change_dem_vs_gop),
    winner == "Republicans" ~ y - (200000 * change_dem_vs_gop)
  )) %>%
  filter(abs(change_dem_vs_gop) > 0.03)

state_map <- get_urbn_map(map = "states", sf = TRUE)


# Visualization -----------------------------------------------------------

ggplot() +
  geom_sf(data = state_map,
          color = "white") +
  geom_segment(data = county_map,
             aes(x = x,
                 xend = xend,
                 y = y,
                 yend = yend,
                 color = winner),
             arrow = arrow(length = unit(0.05, "cm"))) +
  scale_color_manual(values = c(
    "Democrats" = "blue",
    "Republicans" = "red"
  )) +
  labs(title = "Shift in Margin in US Presidential Election from 2016 to 2020",
       subtitle = "Results shown for counties where shift was greater than 1%",
       color = NULL) +
  theme_ipsum(base_family = "Inter",
              grid = FALSE) +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        legend.position = "bottom")


# Save --------------------------------------------------------------------

ggsave("2020-11-20/presidential-election-margin-shift-map.pdf",
       device = cairo_pdf)

ggsave("2020-11-20/presidential-election-margin-shift-map.png",
       dpi = 300)
