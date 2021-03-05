# https://rfortherestofus.com/groups/community/forum/discussion/sum-within-group/

# I am trying to group my data by two variables and then get the sum within that grouping. However, when I run my code, I get the sum across all rows, not within groups.

# Here is an example with the iris dataset. I would like an output table with sum_petal_length to be the sum within the petal_width and species group, but I’m getting sum_petal_length = 563.7 for all groups.

library(tidyverse)
library(janitor)

# I am trying to group my data by two variables and then get the sum within that grouping. However, when I run my code, I get the sum across all rows, not within groups.

# Here is an example with the iris dataset. I would like an output table with sum_petal_length to be the sum within the petal_width and species group, but I’m getting sum_petal_length = 563.7 for all groups.

as_tibble(iris) %>%
  clean_names() %>%
  group_by(species, petal_width) %>%
  mutate(sum_petal_length = sum(petal_length)) %>%
  distinct(species, petal_width, sum_petal_length)


# For instance, for grouping of petal_width = 0.1 and species = setosa, I would like sum_petal_length = 1.5+1.4+1.1 = 4, but it’s showing up as 563.7. Similarly for petal_width = 0.3 and species = setosa, sum_petal_length = 1.4 + 1.7 + 1.5 + 1.3 = 5.8, but it’s also showing up as 563.7.

as_tibble(iris) %>%
  clean_names() %>%
  mutate(species = as.factor(species)) %>%
  mutate(petal_width = as.factor(petal_width)) %>%
  group_by(species, petal_width) %>%
  mutate(sum_petal_length = sum(petal_length)) %>%
  distinct(species, petal_width, sum_petal_length, petal_length) %>%
  arrange(petal_width)

as_tibble(iris) %>%
  clean_names() %>%
  group_by(species) %>%
  filter(petal_width == 0.3) %>%
  summarize(sum_petal_length = sum(petal_length))


# This approach works (sum_petal_length = 4) if I move my distinct() function up and filter the data to one group:

as_tibble(iris) %>%
  clean_names() %>%
  filter(petal_width == 0.1) %>%
  filter(species == "setosa") %>%
  distinct(species, petal_width, petal_length) %>%
  # mutate(species = as.factor(species)) %>%
  # mutate(petal_width = as.factor(petal_width)) %>%
  group_by(species, petal_width) %>%
  mutate(sum_petal_length = sum(petal_length)) %>%
  arrange(petal_width)


as_tibble(iris) %>%
  clean_names() %>%
  # filter(petal_width == 0.1) %>%
  filter(species == "setosa") %>%
  # distinct(species, petal_width, petal_length) %>%
  mutate(species = as.factor(species)) %>%
  mutate(petal_width = as.factor(petal_width)) %>%
  group_by(species, petal_width) %>%
  summarize(sum_petal_length = sum(petal_length),
            n = n()) %>%
  arrange(petal_width)


# However, it doesn’t work if I remove the filter rows (sum_petal_length = 438.1).

as_tibble(iris) %>%
  clean_names() %>%
  distinct(species, petal_width, petal_length) %>%
  mutate(species = as.factor(species)) %>%
  mutate(petal_width = as.factor(petal_width)) %>%
  group_by(species, petal_width) %>%
  mutate(sum_petal_length = sum(petal_length)) %>%
  arrange(petal_width) %>%
  ungroup()

