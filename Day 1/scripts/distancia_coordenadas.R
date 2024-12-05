library(tidyverse)
library(readr)
library(here)

coords_raw <- read_table(here("data/coords.csv"),
                          col_names = FALSE)

coords <- coords_raw %>%
  rename(list_1 = X1,
         list_2 = X2)

coords <- coords %>%
  mutate(list_1 = sort(list_1),
         list_2 = sort(list_2))

coords_dist <- coords %>%
  mutate(distance = abs(list_1 - list_2))

total_distance <- sum(coords_dist$distance)

total_distance

coords_simi <- coords_dist %>%
  mutate(
    "similarity_mult" = map_int(.x = list_1, .f = ~ sum(.x == list_2)),
    "similarity_score" = list_1 * similarity_mult)

total_similarity <- sum(coords_simi$similarity_score)

total_similarity