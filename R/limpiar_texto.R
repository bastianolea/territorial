#' Eliminar puntuación, símbolos y números de textos
#'
#' @param texto Vector de texto
#'
#' @returns Vector de texto sin puntuación, símbolos y números, en minúsculas y sin acentos
#' @seealso [limpiar_comunas()] y [limpiar_regiones()], que usan este tipo de limpieza para corregir nombres de comunas y regiones.
#' @export
#'
#' @examples
#' limpiar_texto("Ñuñoa")
limpiar_texto <- function(texto) {
  texto |>
    stringr::str_remove_all("[:punct:]") |>
    stringr::str_remove_all("´|\\'|\\`") |>
    stringr::str_remove_all("\\d+") |>
    stringr::str_to_lower() |>
    stringi::stri_trans_general("Latin-ASCII") |>
    stringr::str_squish()
}
