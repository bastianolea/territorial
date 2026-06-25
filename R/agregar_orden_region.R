#' Agregar orden geográfico (norte a sur) a códigos de regiones
#'
#' Función usada internamente para [territorial::ordenar_regiones()]. Recibe un vector de números de región (entre 1 y 16) y retorna la posición de norte a sur de dicha región, de modo que Arica sea 1 y Magallanes sea 16.
#'
#' @param codigo_region Vector de códigos únicos de región (entre 1 y 16)
#'
#' @returns Vector con la posición de norte a sur de la región respectiva
#' @export
#'
#' @examples
#' agregar_orden_region(15) # Arica
agregar_orden_region <- function(codigo_region) {
  dplyr::recode_values(
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
    12 ~ 16
  )
}
