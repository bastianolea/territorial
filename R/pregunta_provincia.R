#' Juego: ¿en qué provincia está la comuna?
#'
#' @keywords internal
#'
pregunta_provincia <- function() {
  # comunas que no se llaman igual a su provincia
  comunas_posibles <- territorial::territorios |>
    dplyr::filter_out(nombre_comuna == nombre_provincia) |>
    # # excluir la RM
    # dplyr::filter_out(codigo_region == 13) |>
    dplyr::pull(nombre_comuna)

  # elegir comuna al azar
  comuna <- sample(comunas_posibles, 1)

  # crear pregunta
  pregunta <- glue::glue("¿En qué provincia está la comuna de {comuna}?")

  # obtener respuesta correcta
  datos_comuna <- territorial::territorios |>
    dplyr::filter(nombre_comuna == comuna)

  respuesta <- datos_comuna$nombre_provincia

  region_provincia <- territorial::territorios |>
    dplyr::filter(nombre_provincia == datos_comuna$nombre_provincia) |>
    dplyr::pull(nombre_region) |>
    unique()

  provincias_region <- territorial::territorios |>
    dplyr::filter(nombre_region == region_provincia) |>
    dplyr::filter_out(nombre_provincia == respuesta) |>
    dplyr::pull(nombre_provincia) |>
    unique()

  if (length(provincias_region) >= 2) {
    alternativas_posibles <- sample(provincias_region, 2)
  } else {
    alternativas_posibles <- provincias_region
  }

  macrozona_comuna <- agregar_macrozona(region_provincia, tipo = 5)

  # otras alternativas
  provincias_otras <- territorial::territorios |>
    # solo regiones de la misma macrozona que la respuesta
    agregar_macrozona(tipo = 5) |>
    dplyr::filter(macrozona == macrozona_comuna) |>
    # sacar la provincia correcta
    dplyr::filter_out(nombre_region == region_provincia) |>
    dplyr::pull(nombre_provincia) |>
    unique()

  if (length(provincias_region) >= 2) {
    alternativas_otras <- sample(provincias_otras, 2)
  } else {
    alternativas_otras <- sample(provincias_otras, 3)
  }

  # unir alternativas
  alternativas <- c(
    respuesta,
    alternativas_posibles,
    alternativas_otras
  )

  # desordenar
  alternativas <- sample(alternativas, replace = FALSE)

  # preguntar
  cli::cli_alert(pregunta)

  eleccion <- menu(
    alternativas,
    title = NULL
  )

  if (!eleccion %in% seq_along(alternativas)) {
    cli::cli_abort("Alternativa inválida")
  }

  # evaluar respuesta
  evaluacion <- alternativas[eleccion] == respuesta

  felicitar(evaluacion)

  if (!evaluacion) {
    cli::cli_alert_info("La respuesta era {respuesta}")
  }

  # devolver puntaje
  puntaje <- sum(evaluacion)
  return(invisible(puntaje))
}
