#' Evaluar si un dato corresponde a un código de región de Chile válido
#'
#' Dado un vector de cualquier largo, retorna TRUE o FALSE para cada elemento de acuerdo si se corresponde con los códigos de región de Chile (números del 1 al 16), disponibles en [territorial::territorios].
#'
#' Para más información sobre los códigos únicos territoriales, revisa la viñeta \code{vignette("codigos_unicos_territoriales")}
#'
#' @param codigo_region Códigos de región a evaluar, en formato numérico.
#'
#' @returns Vector lógico del mismo largo que `codigo_region`: TRUE o FALSE si es o no es un código de región válido.
#' @seealso [as_codigo_region()] para convertir nombres de regiones a códigos, [is_nombre_region()] para validar nombres de regiones, y [is_codigo_comuna()] para códigos de comunas.
#' @export
#'
#' @examples
#' is_codigo_region(7)
#'
#' is_codigo_region(c(1, 13, 16, 17, NA))
is_codigo_region <- function(codigo_region) {
  codigo_region %in% 1:16
}
