#' Comunas
#'
#' Vector con el nombre de las 346 comunas de Chile
#'
#' @returns Vector de comunas
#'
#' @export
comunas <- function() {
  comunal::territorios |>
    dplyr::select("nombre_comuna") |>
    dplyr::pull()
}
