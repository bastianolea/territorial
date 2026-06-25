#' Ordenar regiones de Chile geográficamente
#'
#' Ordena una columna de nombres de regiones de Chile (`nombre_region`) a partir de la columna `codigo_region`, resultando en una columna `nombre_region` en formato factor, ordenada de norte a sur.
#'
#' @param datos Tabla de datos que contenga las columnas `nombre_region` y `codigo_region`
#' @param limpiar Para ordenar la variable `nombre_region`, se crea la variable intermedia `orden_region`, que por defecto se elimina después de usarla. Cambiar a FALSE para mantenerla.
#' @param ordenar ¿Ordenar la tabla de datos según regiones? (por defecto TRUE)
#'
#' @returns Tabla de datos con la variable `nombre_region` en formato factor, ordenado geogr\\u00e1ficamente (de norte a sur)
#' @export
#'
#' @examples
#' regiones <- dplyr::tribble(
#'   ~codigo_region,                  ~nombre_region,
#'   1,                                   "Tarapacá",
#'   2,                                "Antofagasta",
#'   3,                                    "Atacama",
#'   4,                                   "Coquimbo",
#'   5,                                 "Valparaíso",
#'   6,      "Libertador General Bernardo O'Higgins",
#'   7,                                      "Maule",
#'   8,                                     "Biobío",
#'   9,                               "La Araucanía",
#'   10,                                 "Los Lagos",
#'   11, "Aysén del General Carlos Ibáñez del Campo",
#'   12,      "Magallanes y de la Antártica Chilena",
#'   13,                 "Metropolitana de Santiago",
#'   14,                                  "Los Ríos",
#'   15,                        "Arica y Parinacota",
#'   16,                                     "Ñuble"
#'   )
#'
#' regiones |>
#'   ordenar_regiones()
ordenar_regiones <- function(
  datos,
  limpiar = TRUE,
  ordenar = TRUE
) {
  if (!any(class(datos) %in% "data.frame")) {
    cli::cli_abort("esta función requiere de un dataframe")
  }

  if (!all(c("nombre_region", "codigo_region") %in% names(datos))) {
    cli::cli_abort(
      "se necesitan las columnas `codigo_region` y `nombre_region`"
    )
  }

  if (!is.numeric(datos$codigo_region)) {
    cli::cli_abort("la columna `codigo_region` debe ser numérica")
  }

  # if (!"codigo_region" %in% names(data)) {
  #   cli::cli_abort("no se encontró columna `codigo_region`")
  # }

  datos_ordenados <- datos |>
    dplyr::mutate(orden_region = agregar_orden_region(codigo_region)) |>
    # ordenar regiones
    dplyr::mutate(
      nombre_region = forcats::fct_reorder(nombre_region, orden_region)
    )

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
