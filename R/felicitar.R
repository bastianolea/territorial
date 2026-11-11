#' Felicitar
#'
#' Entrega mensajes de felicitación o fracaso al azar, con un emoji
#'
#' @param tipo Entregar respuesta positiva (TRUE) o negativa (FALSE)
#' @noRd
#' @returns Mensaje de respuesta
#'
felicitar <- function(tipo) {
  # emojis
  positivo <- c("👍🏼", "⭐️", "✅", "🎉", "👏🏼")
  negativo <- c("😕", "🚫", "☹️", "😢")

  # textos
  felicidades <- c(
    "Muy bien!",
    "Excelente",
    "Correcto!",
    "Lo lograste!",
    "Increíble!"
  )
  fracasos <- c(
    "Te equivocaste!",
    "Muy mal",
    "Incorrecto!",
    "Pésimo",
    "No!",
    "Incorrecto"
  )

  texto <- ifelse(tipo, felicidades, fracasos)
  emojis <- ifelse(tipo, positivo, negativo)

  if (tipo) {
    cli::cli_alert_success(
      paste(
        sample(felicidades, 1),
        sample(positivo, 1)
      )
    )
  } else {
    cli::cli_alert_danger(
      paste(
        sample(fracasos, 1),
        sample(negativo, 1)
      )
    )
  }
}
