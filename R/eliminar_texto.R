#' Eliminar caracteres al azar para ensuciar texto
#'
#' @param texto Vector de texto
#' @param porcentaje Porcentaje de caracteres a eliminar
#'
#' @returns Vector de texto con caracteres eliminados al azar
#' @seealso [insertar_texto()] y [reemplazar_texto()] para otras formas de ensuciar texto, útiles para probar [limpiar_comunas()].
#' @export
#'
#' @examples
#' eliminar_texto(c("mapache", "lindo"), porcentaje = 0.3)
eliminar_texto <- function(texto, porcentaje = 0.1) {
  purrr::map_chr(texto, \(x) {
    if (is.na(x)) {
      return(NA_character_)
    }
    chars <- stringr::str_split(x, "")[[1]]
    n <- length(chars)
    n_eliminar <- floor(n * porcentaje)
    if (n_eliminar == 0) {
      return(x)
    }
    idx <- sample.int(n, size = n_eliminar)
    paste(chars[-idx], collapse = "")
  })
}
