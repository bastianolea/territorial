#' Ordenar regiones de Chile geogr\\u00e1ficamente
#'
#' Ordena una columna de nombres de regiones de Chile (`nombre_region`) a partir de la columna `codigo_region`, resultando en una columna `nombre_region` en formato factor, ordenada de norte a sur.
#'
#' @param data Tabla de datos que contenga las columnas `nombre_region` y `codigo_region`
#' @param limpiar Para ordenar la variable `nombre_region`, se crea la variable intermedia `orden_region`, que por defecto se elimina después de usarla. Cambiar a FALSE para mantenerla.
#' @param ordenar ¿Ordenar la tabla de datos según regiones? (por defecto TRUE)
#'
#' @returns Tabla de datos con la variable `nombre_region` en formato factor, ordenado geogr\\u00e1ficamente (de norte a sur)
#' @export
ordenar_regiones <- function(
    datos,
    limpiar = TRUE,
    ordenar = TRUE
) {

  if (!any(class(datos) %in% "data.frame")) {
    cli::cli_abort("esta función requiere de un dataframe")
  }

  if (!all(c("nombre_region", "codigo_region") %in% names(datos))) {
    cli::cli_abort("se necesitan las columnas `codigo_region` y `nombre_region`")
  }

  if (!is.numeric(datos$codigo_region)) {
    cli::cli_abort("la columna `codigo_region` debe ser numérica")
  }

  # if (!"codigo_region" %in% names(data)) {
  #   cli::cli_abort("no se encontró columna `codigo_region`")
  # }

  datos_ordenados <- datos |>
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
                                                       orden_region))

  # excluir o mantener variable intermedia
  if (limpiar) {
    datos_ordenados <- datos_ordenados |>
      dplyr::select(-orden_region)
  } else {
    cli::cli_alert_info("columna `orden_region` agregada")

    datos_ordenados <- datos_ordenados |>
      dplyr::relocate(orden_region, .after = codigo_region)
  }

  # ordenar tabla de datos según factor nombre_region
  if (ordenar) {
    datos_ordenados <- datos_ordenados |>
      dplyr::arrange(nombre_region)
  }

  return(datos_ordenados)
}
