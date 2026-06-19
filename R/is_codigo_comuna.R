#' Evaluar si un texto corresponde a un código territorial válido de una comuna de Chile
#'
#' Dado un vector de cualquier largo, retorna TRUE o FALSE para cada elemento de acuerdo si se corresponde con los códigos únicos territoriales de comunas de Chile, disponibles en la función [territorial::territorios].
#'
#' @param x Elemento/s a evaluar
#'
#' @returns TRUE o FALSE si es o no es una comuna válida
#' @export
#'
#' @examples
#' is_codigo_comuna(1101)
is_codigo_comuna <- function(x) {

  x %in% territorial::territorios$codigo_comuna
}
