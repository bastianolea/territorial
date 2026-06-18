#' Ordenar regiones de Chile geogr\\u00e1ficamente
#'
#' Ordena una columna de regiones de Chile (`nombre_region`) a partir de la columna `codigo_region`
#'
#' @param data Dataframe que contenga las columnas `nombre_region` y `codigo_region`
#'
#' @returns Dataframe con la variable `nombre_region` en formato factor, ordenado geogr\\u00e1ficamente (de norte a sur)
#' @export
ordenar_regiones <- function(data) {

  # data <- comunal::territorios

  # all(c("nombre_region", "codigo_region") %in% names(data))
  #
  # if (!"codigo_region" %in% names(data)) {
  #   cli::cli_abort("no se encontró columna `codigo_region`")
  # }
  # if (!"nombre_region" %in% names(data)) {
  #   cli::cli_abort("no se encontró columna `nombre_region`")
  # }

  if (!any(class(data) %in% "data.frame")) {
    cli::cli_abort("esta función requiere de un dataframe")
  }

  if (!all(c("nombre_region", "codigo_region") %in% names(data))) {
    cli::cli_abort("se necesitan las columnas `codigo_region` y `nombre_region`")
  }

  if (!is.numeric(data$codigo_region)) {
    cli::cli_abort("la columna `codigo_region` debe ser numérica")
  }

  # if (!"codigo_region" %in% names(data)) {
  #   cli::cli_abort("no se encontró columna `codigo_region`")
  # }

  data |>
    dplyr::mutate(orden_region = dplyr::recode_values(
      codigo_region,
      15 ~ 1,
      1 ~ 2,
      2 ~ 3,
      3 ~ 4,
      4 ~ 5,
      5 ~ 6,
      13 ~ 7,
      6 ~ 8,
      7 ~ 9,
      16 ~ 10,
      8 ~ 11,
      9 ~ 12,
      14 ~ 13,
      10 ~ 14,
      11 ~ 15,
      12 ~ 16)) |>
    # ordenar regiones
    dplyr::mutate(nombre_region = forcats::fct_reorder(nombre_region,
                                                       orden_region)) |>
    dplyr::select(-orden_region)
}
