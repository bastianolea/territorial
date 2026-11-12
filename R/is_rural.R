#' Evaluar si una comuna es rural
#'
#' Dado un vector de cualquier largo, retorna TRUE o FALSE para cada elemento de acuerdo si la comuna está clasificada como "Rural" en la tabla [clasificacion] (clasificación comunal de la Política Nacional de Desarrollo Rural, PNDR, según el Censo 2024).
#'
#' @param codigo_comuna Códigos de comuna en formato numérico, o nombres de comuna (como los que aparecen en [territorial::comunas()]) en formato caracter.
#'
#' @returns Vector lógico del mismo largo que `codigo_comuna`: TRUE si la comuna es rural, FALSE si es mixta o urbana, y NA si la comuna no se encuentra en la tabla de clasificación.
#' @seealso [clasificacion] para ver la tabla de clasificación comunal, [agregar_clasificacion()] para agregar la clasificación a una tabla, y [as_codigo_comuna()] para convertir nombres de comunas a códigos.
#' @export
#'
#' @examples
#' is_rural(1401)
#'
#' is_rural(c("Santiago", "Camiña", "Casablanca"))
is_rural <- function(codigo_comuna) {
  if (!is.numeric(codigo_comuna)) {
    codigo_comuna <- as_codigo_comuna(codigo_comuna)
  }

  clasificacion <- territorial::clasificacion$clasificacion[match(
    codigo_comuna,
    territorial::clasificacion$codigo_comuna
  )]

  # evaluar
  resultado <- clasificacion == "Rural"
  return(resultado)
}
