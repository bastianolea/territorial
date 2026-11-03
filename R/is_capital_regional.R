#' Evaluar si una comuna corresponde a una capital regional
#'
#' Dado un vector de cualquier largo, retorna TRUE o FALSE para cada elemento de acuerdo si la comuna corresponde a una de las 16 capitales regionales de Chile, disponibles en [capitales_regionales()].
#'
#' Acepta tanto códigos de comuna en formato numérico como nombres de comuna en formato caracter.
#'
#' @param codigo_comuna Códigos de comuna en formato numérico, o nombres de comuna (como los que aparecen en [territorial::comunas()]) en formato caracter.
#'
#' @returns Vector lógico del mismo largo que `codigo_comuna`: TRUE o FALSE si es o no es una capital regional.
#' @seealso [capitales_regionales()] para ver la tabla de capitales regionales, [as_capital_regional()] para convertir regiones a comunas capitales, [as_codigo_comuna()] para convertir nombres de comunas a códigos, y [is_codigo_comuna()] para validar códigos de comunas.
#' @export
#'
#' @examples
#' is_capital_regional(13101)
#'
#' is_capital_regional(c("Santiago", "Puente Alto", "Valparaíso"))
is_capital_regional <- function(codigo_comuna) {
  if (!is.numeric(codigo_comuna)) {
    codigo_comuna <- as_codigo_comuna(codigo_comuna)
  }

  codigo_comuna %in% capitales_regionales()$codigo_comuna
}
