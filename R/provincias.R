#' Nombres de provincias de Chile
#'
#' Vector de texto que contiene el nombre de las 56 provincias de Chile, ordenadas de norte a sur, tal como aparecen en la tabla [territorial::territorios].
#'
#' @returns Vector de nombres de provincias de Chile
#' @seealso [regiones()], [comunas()], [codigos_comunas()]
#' @export
#'
#' @examples
#' provincias()
#'
provincias <- function() {
  unique(territorial::territorios$nombre_provincia)
}
