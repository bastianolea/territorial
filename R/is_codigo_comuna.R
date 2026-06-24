#' Evaluar si un dato corresponde a un código territorial válido de una comuna de Chile
#'
#' Dado un vector de cualquier largo, retorna TRUE o FALSE para cada elemento de acuerdo si se corresponde con los códigos únicos territoriales de comunas de Chile, disponibles en [territorial::territorios].
#'
#' @param codigo_comuna Elemento/s a evaluar
#'
#' @returns TRUE o FALSE si es o no es un código único territorial válido
#' @export
#'
#' @examples
#' is_codigo_comuna(1101)
is_codigo_comuna <- function(codigo_comuna) {
  stopifnot("debe ser numérico" = is.numeric(codigo_comuna))
  codigo_comuna %in% territorial::territorios$codigo_comuna
}
