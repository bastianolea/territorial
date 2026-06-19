#' Evaluar si un texto corresponde al nombre válido de una comuna de Chile
#'
#' Dado un vector de cualquier largo, retorna TRUE o FALSE para cada elemento de acuerdo si se corresponde con los nombres de comunas oficiales, disponibles en la función [comunas()].
#'
#' @param x Elemento/s a evaluar
#'
#' @returns TRUE o FALSE si es o no es una comuna válida
#' @export
#'
#' @examples
#' is.comuna("Panguipulli")
#'
is.comuna <- function(x) {

  x %in% territorial::comunas()
}
