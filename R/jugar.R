#' Jugar a adivinar comunas y regiones
#'
jugar <- function() {
  puntaje <- 0

  puntos <- pregunta_comuna()
  puntaje <- puntaje + puntos
  cli::cat_line()
  puntos <- pregunta_region()
  puntaje <- puntaje + puntos
  cli::cat_line()
  puntos <- pregunta_comuna()
  puntaje <- puntaje + puntos
  cli::cat_line()
  puntos <- pregunta_region()
  puntaje <- puntaje + puntos

  cli::cat_line()
  cli::cli_rule()

  emoji <- ifelse(puntaje == 4, "🏆", "")
  emoji <- ifelse(puntaje == 0, "💀", puntaje)
  cli::cli_alert("Resultado: {puntaje} de 4 correctas {emoji}")
}
