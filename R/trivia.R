#' Jugar a una trivia de comunas y regiones de Chile
#'
#' Inicia una trivia interactiva en la consola para probar tu conocimientos sobre los territorios de Chile! Aparecerán 7 preguntas en la consola, una por una, y debes responder con el número de la alternativa correspondiente. Al final aparecerá tu puntaje! Son 5 tipos de preguntas distintas, y los territorios que aparecen son aleatorios, mientras que las alternativas están diseñadas para confundirte!
#'
#' Las preguntas son: ¿En qué región está la comuna? ¿En qué región está las comuna? ¿Cuál de estas comunas es urbana/rural? ¿En qué provincia está la comuna?
#'
#' También puedes [jugar la trivia en tu navegador](https://bastianolea.github.io/territorial/articles/trivia.html), sin instalar R.
#'
#' @export
#' @examplesIf interactive()
#' trivia()
#'
trivia <- function() {
  puntaje <- 0

  esperar <- \() {
    Sys.sleep(0.8)
    cli::cat_line()
    cli::cli_rule()
  }

  puntos <- pregunta_comuna()
  puntaje <- puntaje + puntos
  esperar()

  puntos <- pregunta_region()
  puntaje <- puntaje + puntos
  esperar()

  puntos <- pregunta_urbana()
  puntaje <- puntaje + puntos
  esperar()

  puntos <- pregunta_comuna()
  puntaje <- puntaje + puntos
  esperar()

  puntos <- pregunta_provincia()
  puntaje <- puntaje + puntos
  esperar()

  puntos <- pregunta_region()
  puntaje <- puntaje + puntos
  esperar()

  puntos <- pregunta_rural()
  puntaje <- puntaje + puntos
  esperar()

  cli::cli_rule()

  emoji <- ifelse(puntaje >= 6, "🏆", "")
  emoji <- ifelse(puntaje <= 2, "💀", emoji)

  cli::cli_alert(
    "Resultado: {puntaje} respuesta{?s} correcta{?s} de un total de 7 {emoji}"
  )
}
