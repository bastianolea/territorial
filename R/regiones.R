#' Nombres de regiones de Chile
#'
#' Vector de texto que contiene el nombre de las 15 regiones de Chile, ordenadas de norte a sur, tal como aparecen en la tabla [territorial::territorios].
#'
#' @returns Vector de nombres de regiones de Chile
#'
#' @export
#'
#' @examples
#' regiones()
#'
regiones <- function() {
  territorios |>
    dplyr::distinct(codigo_region, nombre_region) |>
    ordenar_regiones() |>
    dplyr::pull(nombre_region) |>
    as.character()
}
