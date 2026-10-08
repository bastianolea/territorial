#' Evaluar si un dato corresponde a un código territorial válido de una comuna de Chile
#'
#' Dado un vector de cualquier largo, retorna TRUE o FALSE para cada elemento de acuerdo si se corresponde con los códigos únicos territoriales de comunas de Chile, disponibles en [territorial::territorios].
#'
#' Para más información sobre los códigos únicos territoriales, revisa la viñeta \code{vignette("codigos_unicos_territoriales")}
#'
#' @param codigo_comuna Códigos territoriales a evaluar, en formato numérico. Si vienen en formato caracter, se convierten.
#'
#' @returns Retorna TRUE o FALSE si es o no es un código único territorial válido (ver [territorial::territorios])
#' @export
#'
#' @examples
#' is_codigo_comuna(1101)
is_codigo_comuna <- function(codigo_comuna) {
  # codigo_comuna = "1101"
  # si no es numérico, avisar y convertir
  if (is.character(codigo_comuna)) {
    cli::cli_alert_warning(
      "El código comunal {codigo_comuna} no es de tipo numérico. Se recomienda convertir con {.fun base::as.numeric}"
    )
    codigo_comuna <- as.numeric(codigo_comuna)
  }

  resultado <- codigo_comuna %in% territorios$codigo_comuna

  return(resultado)
}
