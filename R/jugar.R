#' Jugar a una trivia de comunas y regiones de Chile
#'
#' Inicia una trivia interactiva en la consola para probar tu conocimientos sobre los territorios de Chile! Aparecerán 5 preguntas en la consola, una por una, y debes responder con el número de la alternativa correspondiente.
#'
#' @export
#' @examples
#'
#' jugar()
#'
jugar <- function() {
  puntaje <- 0

  esperar <- \() {
    Sys.sleep(0.4)
    cli::cat_line()
  }

  puntos <- pregunta_comuna()
  puntaje <- puntaje + puntos
  esperar()

  puntos <- pregunta_region()
  puntaje <- puntaje + puntos
  esperar()

  puntos <- pregunta_rural()
  puntaje <- puntaje + puntos
  esperar()

  puntos <- pregunta_comuna()
  puntaje <- puntaje + puntos
  esperar()

  puntos <- pregunta_region()
  puntaje <- puntaje + puntos
  esperar()

  puntos <- pregunta_rural()
  puntaje <- puntaje + puntos
  esperar()

  cli::cat_line()
  cli::cli_rule()

  emoji <- ifelse(puntaje == 5, "🏆", "")
  emoji <- ifelse(puntaje == 0, "💀", emoji)

  cli::cli_alert(
    "Resultado: {puntaje} respuesta{?s} correcta{?s} de un total de 6 {emoji}"
  )
}
