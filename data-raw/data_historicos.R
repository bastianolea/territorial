library(dplyr)
library(tidyr)
# load_all()

# cargar
historicos <- readxl::read_xls("data-raw/CUT_HISTORICOS.xls") |>
  janitor::clean_names()

# limpiar
historicos <- historicos |>
  select(
    nombre_comuna = nom_com_es,
    codigo_comuna_2017 = cut_2017_n,
    codigo_comuna_2010 = cut_2010_n,
    codigo_comuna_2007 = cut_2007_n,
    codigo_comuna_2004 = cut_2004_n
  )

# validar
validacion <- historicos |>
  filter(!codigo_comuna_2017 %in% territorios$codigo_comuna)

stopifnot("códigos no coinciden" = nrow(validacion) == 0)

# limpiar nombres
historicos <- historicos |>
  limpiar_comunas() #|>
# mutate(
#   nombre_region = ubicar_comunas(nombre_comuna),
#   codigo_region = as_codigo_region(nombre_region)
#   )

cut_historicos <- historicos

usethis::use_data(cut_historicos, overwrite = TRUE)


# pivotar a largo manteniendo el más vigente
historicos_l <- historicos |>
  pivot_longer(
    cols = c(
      codigo_comuna_2010,
      codigo_comuna_2007,
      codigo_comuna_2004
    ),
    names_to = "año",
    values_to = "codigo_comuna_historico"
  ) |>
  mutate(
    año = stringr::str_extract(año, "\\d{4}"),
    año = as.numeric(año)
  )

# solamente códigos que ya no existen y sus contrapartes
historicos_l <- historicos_l |>
  # sacar todos los que no han cambiado
  filter(!codigo_comuna_historico %in% territorios$codigo_comuna) |>
  select(
    codigo_comuna_historico,
    año,
    codigo_comuna_actual = codigo_comuna_2017
  ) |>
  # dejar sólo último año que estuvo vigente
  arrange(codigo_comuna_historico, desc(año)) |>
  group_by(codigo_comuna_historico) |>
  slice_max(año) |>
  ungroup()

cut_historicos_l <- historicos_l

# cut_historicos_l |>
#   print(n = Inf)

# # probar
# cut_historicos_l |>
#   filter(codigo_comuna_historico == 8420)

usethis::use_data(cut_historicos_l, overwrite = TRUE, internal = TRUE)
