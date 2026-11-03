#' Pregunta de trivia: ¿cuál de estas comunas es urbana?
#'
#' @keywords internal
#'
pregunta_urbana <- function() {
  # tabla de comunas
  tabla_comunas <- territorial::territorios |>
    agregar_macrozona(tipo = 5) |>
    agregar_clasificacion()

  # seleccionar comuna al azar
  respuesta <- tabla_comunas |>
    dplyr::filter(clasificacion == "Urbana") |>
    dplyr::pull(nombre_comuna) |>
    sample(1)

  respuesta

  # crear pregunta
  pregunta <- glue::glue("¿Cuál de estas comunas es urbana?")

  # comunas posibles
  alternativas_posibles <- tabla_comunas |>
    dplyr::filter_out(clasificacion == "Urbana") |>
    # dplyr::filter_out(macrozona == "Centro") |>
    dplyr::filter_out(
      nombre_comuna %in% capitales_regionales()$nombre_comuna
    ) |>
    dplyr::pull(nombre_comuna) |>
    sample(4)

  # unir alternativas
  alternativas <- c(
    respuesta,
    alternativas_posibles
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
