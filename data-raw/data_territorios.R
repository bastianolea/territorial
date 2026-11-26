# código de la tabla de datos principal del paquete, originada desde la planilla oficial de códigos únicos territoriales de Subdere
# https://www.subdere.gov.cl/documentacion/códigos-únicos-territoriales-actualizados-al-06-de-septiembre-2018
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
      "Los Angeles" ~ "Los Ángeles",
      "Ranquil" ~ "Ránquil"
    )
  )

# # revisar
# territorios |> filter(stringr::str_detect(nombre_comuna, "Coy"))
# territorios |> filter(stringr::str_detect(nombre_comuna, "Los "))

usethis::use_data(territorios, overwrite = TRUE)
