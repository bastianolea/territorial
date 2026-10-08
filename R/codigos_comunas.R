#' Códigos de comunas de Chile
#'
#' Vector numérico que contiene los códigos únicos territoriales de las 346 comunas de Chile, tal como aparecen en la tabla [territorial::territorios].
#'
#' @returns Vector de códigos de comunas de Chile
#'
#' @export
#'
#' @examples
#' codigos_comunas()
#'
codigos_comunas <- function() {
  territorios$codigo_comuna
}
