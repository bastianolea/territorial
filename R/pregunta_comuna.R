#' Juego: ¿en qué comuna está la región?
#'
pregunta_comuna <- function() {
  # elegir comuna al azar
  comuna <- sample(comunas(), 1)

  # crear pregunta
  pregunta <- glue::glue("¿En qué región está la comuna de {comuna}?")

  # obtener respuesta correcta
  respuesta <- ubicar_comunas(comuna)
  macrozona_respuesta <- agregar_macrozona(respuesta, tipo = 5)

  # alternativas posibles
  # obtener regiones de la misma macrozona
  regiones_macrozona <- territorios |>
    # regiones del país
    dplyr::select(dplyr::ends_with("region")) |>
    dplyr::distinct() |>
    agregar_macrozona(tipo = 5) |>
    # sacar respuesta correcta
    dplyr::filter_out(nombre_region == respuesta) |>
    # solamente de la misma macrozona
    dplyr::filter(macrozona == macrozona_respuesta) |>
    dplyr::pull(nombre_region)

  alternativas_posibles <- sample(regiones_macrozona, 2)

  # otras alternativas
  # (otras regiones aparte de la correcta y las dos de macrozona)
  regiones_otras <- territorios |>
    dplyr::filter_out(nombre_region %in% c(alternativas_posibles, respuesta)) |>
    dplyr::pull(nombre_region) |>
    unique()

  alternativas_otras <- sample(regiones_otras, 2)

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

  return(invisible(1))
}
