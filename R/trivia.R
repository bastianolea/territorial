#' Jugar a una trivia de comunas, provincias y regiones de Chile
#'
#' Inicia una trivia interactiva en la consola para probar tu conocimientos sobre los territorios de Chile! Aparecerán 7 preguntas en la consola, una por una, y debes responder con el número de la alternativa correspondiente. Al final aparecerá tu puntaje! Son 5 tipos de preguntas distintas, y los territorios que aparecen son aleatorios, mientras que las alternativas están diseñadas para confundirte!
#'
#' Las preguntas son: _¿En qué región está la comuna? ¿qué comuna está en la región? ¿Cuál de estas comunas es urbana/rural? ¿En qué provincia está la comuna?_
#'
#' También puedes [jugar la trivia en tu navegador](https://bastianolea.github.io/territorial/articles/trivia.html), sin instalar R.
#'
#' @returns No devuelve ningún valor (`NULL` invisible). Se usa por su efecto: mostrar la trivia en la consola.
#' @export
#' @examplesIf interactive()
#' trivia()
#'
trivia <- function() {
  puntaje <- 0
  total <- 7 # número de preguntas

  esperar <- \() {
    Sys.sleep(0.6)
    cli::cat_line()
    # cli::cli_rule()
  }

  # inicio del juego
  cli::cli_h1("Preguntas sobre comunas, provincias y regiones de Chile")
  Sys.sleep(1)
  cli::cli_par(
    cli::cli_text(
      "Recibirás {total} preguntas, que debes responder con el número de la alternativa y luego Enter. Suerte!"
    )
  )
  Sys.sleep(1)

  cli::cli_h2("Pregunta 1/{total}")
  puntos <- pregunta_comuna()
  puntaje <- puntaje + puntos
  esperar()

  cli::cli_h2("Pregunta 2/{total}")
  puntos <- pregunta_region()
  puntaje <- puntaje + puntos
  esperar()

  cli::cli_h2("Pregunta 3/{total}")
  puntos <- pregunta_urbana()
  puntaje <- puntaje + puntos
  esperar()

  cli::cli_h2("Pregunta 4/{total}")
  puntos <- pregunta_comuna()
  puntaje <- puntaje + puntos
  esperar()

  cli::cli_h2("Pregunta 5/{total}")
  puntos <- pregunta_provincia()
  puntaje <- puntaje + puntos
  esperar()

  cli::cli_h2("Pregunta 6/{total}")
  puntos <- pregunta_region()
  puntaje <- puntaje + puntos
  esperar()

  cli::cli_h2("Pregunta 7/{total}")
  puntos <- pregunta_rural()
  puntaje <- puntaje + puntos
  esperar()

  cli::cli_rule()

  emoji <- ifelse(puntaje >= 6, "🏆", "!")
  emoji <- ifelse(puntaje <= 2, "🙁", emoji)

  cli::cli_alert(
    "Resultado: {puntaje} respuesta{?s} correcta{?s} de un total de 7 {emoji}"
  )
}
