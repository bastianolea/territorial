#' Evaluar si un texto corresponde al nombre válido de una comuna de Chile
#'
#' Dado un vector de cualquier largo, retorna TRUE o FALSE para cada elemento de acuerdo si se corresponde con los nombres de comunas oficiales, disponibles en la función [territorial::comunas()].
#'
#' @param nombre_comuna Elemento/s a evaluar
#'
#' @returns TRUE o FALSE si es o no es una comuna válida
#' @export
#'
#' @examples
#' is_nombre_comuna("Panguipulli")
#'
is_nombre_comuna <- function(nombre_comuna) {
  stopifnot("debe ser caracter" = is.character(nombre_comuna))
  nombre_comuna %in% territorial::comunas()
}
