library(dplyr)
library(tidyr)
# load_all()

# cargar
historicos <- readxl::read_xls("data-raw/CUT_HISTORICOS.xls") |>
  janitor::clean_names()

# limpiar
historicos <- historicos |>
  select(
    -ends_with("t"),
    -starts_with("cap"),
    -starts_with("cod"),
    -nom_com_es
  )

# validar
validacion <- historicos |>
  filter(!cut_2017_n %in% territorios$codigo_comuna)

stopifnot("códigos no coinciden" = nrow(validacion) == 0)

# pivotar a largo manteniendo el más vigente
historicos_l <- historicos |>
  pivot_longer(
    cols = c(cut_2010_n, cut_2007_n, cut_2004_n),
    names_to = "año",
    values_to = "codigo_comuna_historico"
  ) |>
  mutate(
    año = stringr::str_extract(año, "\\d{4}"),
    año = as.numeric(año)
  )

# solamente códigos que ya no existen y sus contrapartes
historicos_c <- historicos_l |>
  # sacar todos los que no han cambiado
  filter(!codigo_comuna_historico %in% territorios$codigo_comuna) |>
  select(codigo_comuna_historico, año, codigo_comuna_actual = cut_2017_n) |>
  # dejar sólo último año que estuvo vigente
  arrange(codigo_comuna_historico, desc(año)) |>
  group_by(codigo_comuna_historico) |>
  slice_max(año) |>
  ungroup()

# historicos_c |>
#   print(n = Inf)

cut_historicos <- historicos_c

# # probar
# cut_historicos |>
#   filter(codigo_comuna_historico == 8420)

usethis::use_data(cut_historicos, overwrite = TRUE)
