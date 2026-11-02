#' Evaluar si un código único territorial comunal es antiguo o desactualizado
#'
#' @param codigo_comuna Códigos comunales en formato numérico
#'
#' @returns Retorna TRUE o FALSE si es o no es un código único territorial antiguo (ver [territorial::cut_historicos])
#' @seealso [actualizar_codigo_comuna()] para convertir códigos antiguos a los vigentes, e [is_codigo_comuna()] para verificar si un código es válido.
#' @export
#'
#' @examples
#' is_codigo_comuna_antiguo(8408)
#'
is_codigo_comuna_antiguo <- function(codigo_comuna) {
  # codigo_comuna <- 1102

  if (is.character(codigo_comuna)) {
    cli::cli_warn(
      "El código comunal {codigo_comuna} no es de tipo numérico. Se recomienda convertir con {.fun base::as.numeric}"
    )
    codigo_comuna <- as.numeric(codigo_comuna)
  }

  resultado <- codigo_comuna %in% cut_historicos_l$codigo_comuna_historico

  return(resultado)
}
