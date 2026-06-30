## code to prepare `localidades` dataset goes here

library(dplyr)
library(readxl)
library(stringr)

localidades <- read_xlsx("data-raw/LAC_2021_CENSO2017.xlsx")

localidades <- localidades |>
  janitor::clean_names() |>
  mutate(codigo_comuna = as.numeric(cut)) |>
  # limpieza
  mutate(
    localidad = str_to_title(nombre),
    localidad = str_replace_all(
      localidad,
      c(" De " = " de ", " Del " = " del ", " Al " = " al ")
    ),
    tipo = str_to_sentence(tipo),
    subtipo = str_to_sentence(sub_tipo)
  ) |>
  select(codigo_comuna, localidad, tipo, subtipo, habitantes, viviendas) |>
  mutate(habitantes = as.numeric(habitantes), viviendas = as.numeric(viviendas))

usethis::use_data(localidades, overwrite = TRUE)
