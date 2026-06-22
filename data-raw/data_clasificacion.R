## code to prepare `data_odepa.R` dataset goes here
library(readxl)
library(dplyr)

odepa <- read_xlsx("data-raw/ClasificacionComunasPNDR_Censo2024.xlsx")

clasificacion <- odepa |>
  select(codigo_comuna = CUT,
         clasificacion = CLASIFICACION) |>
  territorial::contextualizar("codigo_comuna")

usethis::use_data(clasificacion, overwrite = TRUE)
