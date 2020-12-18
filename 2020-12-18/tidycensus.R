
# Load Packages -----------------------------------------------------------

library(tidyverse)
library(janitor)
library(tidycensus)
library(dkmisc)


# Get Race/Ethnicity Data -------------------------------------------------

view_acs_variables()

# tidycensus::load_variables(year, "acs5", cache = TRUE) %>%
#   tibble::view()



get_acs_race_ethnicity <- function(...) {

  get_acs(...,
          variables = c("White" = "B03002_003",
                        "Black/African American" = "B03002_004",
                        "American Indian/Alaska Native" = "B03002_005",
                        "Asian" = "B03002_006",
                        "Native Hawaiian/Pacific Islander" = "B03002_007",
                        "Other race" = "B03002_008",
                        "Multi-Race" = "B03002_009",
                        "Hispanic/Latino" = "B03002_012")) %>%
    clean_names() %>%
    set_names(c("geoid", "geography", "population_group", "estimate", "moe"))

}

get_acs_race_ethnicity(state = "OR",
                       geography = "tract") %>%
  group_by(population_group) %>%
  summarize(total_population = sum(estimate),
            total_moe = sum(moe))
