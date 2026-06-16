## code to prepare `territorios` dataset goes here
library(dplyr)

codigos_comunales <- readxl::read_xls("data-raw/CUT_2018_v04.xls")

territorios <- codigos_comunales |>
  janitor::clean_names() |>
  select(-abreviatura_region) |>
  rename(codigo_comuna = codigo_comuna_2018) |>
  mutate(across(starts_with("codigo"), as.numeric))

usethis::use_data(territorios, overwrite = TRUE)
# Document your data (see <https://r-pkgs.org/data.html>).
