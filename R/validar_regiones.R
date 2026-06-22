#' Validación de calidad de nombres de regiones de Chile
#'
#' Esta función recibe la columna con nombres de regiones de un dataframe (idealmente `nombre_region`), y retorna una evaluación de posibles problemas con los nombres existentes.
#'
#' @param nombre_region Columna con nombres de regiones
#'
#' @returns Dataframe intacto, mensajes de diagnóstico
#' @export
#'
validar_regiones <- function(nombre_region) {
  # regiones en mayúsculas
  # regiones sin mayúsculas
  # Ñuble se escribe con Ñ
  # O'Higgins sin apóstrofo
  # O'Higgins con apóstrofo incorrecto
  # regiones sin tilde
  # regiones con mayúsculas en los artículos
}
