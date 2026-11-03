#' Nombres de comunas de Chile
#'
#' Vector de texto que contiene el nombre de las 346 comunas de Chile, tal como aparecen en la tabla [territorial::territorios].
#'
#' @returns Vector de nombres de comunas de Chile
#' @seealso [codigos_comunas()] para un vector de códigos únicos territoriales de comunas, [regiones()] para un vector de regiones de Chile. Puedes usar [as_codigo_comuna()] para obtener códigos únicos territoriales (CUT) a partir de los nombres de comunas.
#' @export
#'
#' @examples
#' comunas()
#'
comunas <- function() {
  territorial::territorios$nombre_comuna
}
