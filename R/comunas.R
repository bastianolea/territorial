#' Nombres de comunas de Chile
#'
#' Vector de texto que contiene el nombre de las 346 comunas de Chile, tal como aparecen en la tabla [territorios].
#'
#' @returns Vector de nombres de comunas de Chile
#'
#' @export
comunas <- function() {
  comunal::territorios$nombre_comuna
}
