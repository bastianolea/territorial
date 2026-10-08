#' Evaluar si un texto corresponde al nombre válido de una comuna de Chile
#'
#' Dado un vector de cualquier largo, retorna TRUE o FALSE para cada elemento de acuerdo si se corresponde con los nombres de comunas oficiales, disponibles en la función [territorial::comunas()].
#'
#' @param nombre_comuna Elemento/s a evaluar
#' @param intentar Si la comuna no es válida, tratar de interpretarla con [territorial::limpiar_comunas()]
#'
#' @returns TRUE o FALSE si es o no es una comuna válida
#' @export
#'
#' @examples
#' is_nombre_comuna("Panguipulli")
#'
is_nombre_comuna <- function(
  nombre_comuna,
  intentar = FALSE
) {
  # nombre_comuna = "Panguipulli"
  # nombre_comuna = "Panguipully"
  # nombre_comuna = "asdf"

  stopifnot("El nombre debe ser tipo caracter" = is.character(nombre_comuna))

  resultado <- nombre_comuna %in% comunas()

  if (intentar) {
    if (!resultado) {
      limpiado <- limpiar_comunas(nombre_comuna) |>
        suppressMessages()

      if (!is.na(limpiado)) {
        cli::cli_alert_warning(
          'La comuna "{nombre_comuna}" no es válida, pero puede limpiarse con {.fun territorial::limpiar_comunas} para obtener el nombre válido "{limpiado}"'
        )
        return(FALSE)
      } else if (is.na(limpiado)) {
        cli::cli_alert_warning(
          'La comuna "{nombre_comuna}" no es válida, y no se pudo interpretar con {.fun territorial::limpiar_comunas}'
        )
        return(FALSE)
      }
    }
  }

  return(resultado)
}
