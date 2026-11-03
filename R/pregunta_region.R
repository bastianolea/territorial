#' Pregunta de trivia: ¿en qué región está las comuna?
#'
pregunta_region <- function() {
  # elegir region al azar
  region <- sample(regiones(), 1)

  # crear pregunta
  pregunta <- glue::glue(
    "¿Cuál de las siguientes comunas está en la región de {region}?"
  )

  # obtener respuesta
  comunas_region <- suppressMessages(obtener_comunas(region))
  respuesta <- sample(comunas_region, 1)

  macrozona_respuesta <- agregar_macrozona(region, tipo = 5)

  # alternativas posibles
  # obtener comunas de la misma macrozona
  comunas_macrozona <- territorial::territorios |>
    agregar_macrozona(tipo = 5) |>
    # sacar respuesta correcta
    dplyr::filter_out(nombre_comuna %in% comunas_region) |>
    # solamente de la misma macrozona
    dplyr::filter(macrozona == macrozona_respuesta) |>
    dplyr::pull(nombre_comuna)

  alternativas_posibles <- sample(comunas_macrozona, 3)

  comunas_otras <- territorial::territorios |>
    dplyr::filter_out(nombre_comuna %in% comunas_region) |>
    dplyr::filter_out(nombre_comuna %in% alternativas_posibles) |>
    dplyr::pull(nombre_comuna)

  alternativas_otras <- sample(comunas_otras, 1)

  # unir alternativas
  alternativas <- c(
    respuesta,
    alternativas_posibles,
    alternativas_otras
  )

  # desordenar
  alternativas <- sample(alternativas)

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
