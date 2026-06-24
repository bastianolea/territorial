#' Evaluar si un texto corresponde a un nombre de región de Chile válido
#'
#' Dado un vector de cualquier largo, retorna TRUE o FALSE para cada elemento de acuerdo si se corresponde con los nombres de regiones de Chile, disponibles en [territorial::territorios].
#'
#' @param codigo_comuna Elemento/s a evaluar
#'
#' @returns TRUE o FALSE si es o no es un código único territorial válido
#' @export
#'
#' @examples
#' is_nombre_region("Maule")
is_nombre_region <- function(nombre_region) {
  stopifnot("debe ser caracter" = is.character(nombre_region))
  nombre_region %in% territorial::regiones()
}
