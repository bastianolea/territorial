## code to prepare `territorios` dataset goes here
library(dplyr)

codigos_comunales <- readxl::read_xls("data-raw/CUT_2018_v04.xls")

territorios <- codigos_comunales |>
  janitor::clean_names() |>
  select(-abreviatura_region) |>
  rename(codigo_comuna = codigo_comuna_2018) |>
  mutate(across(starts_with("codigo"), as.numeric)) |>
  mutate(
    nombre_comuna = replace_values(
      nombre_comuna,
      "Paiguano" ~ "Paihuano",
      "Treguaco" ~ "Trehuaco",
      "Los Alamos" ~ "Los Álamos",
      "Los Angeles" ~ "Los Ángeles"
    )
  )

# # revisar
# territorios |> filter(str_detect(nombre_comuna, "Coy"))

usethis::use_data(territorios, overwrite = TRUE)
