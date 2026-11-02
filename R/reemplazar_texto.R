#' Reemplazar caracteres al azar para ensuciar texto
#'
#' @param texto Vector de texto
#' @param porcentaje Porcentaje de caracteres a reemplazar
#' @param caracteres Vector de caracteres para insertar
#'
#' @returns Vector de texto con caracteres reemplazados al azar
#' @seealso [eliminar_texto()] e [insertar_texto()] para otras formas de ensuciar texto, útiles para probar [limpiar_comunas()].
#' @export
#'
#' @examples
#' reemplazar_texto(c("mapache", "lindo"), porcentaje = 0.3)
reemplazar_texto <- function(
  texto,
  porcentaje = 0.1,
  caracteres = c(letters, LETTERS)
) {
  purrr::map_chr(texto, \(x) {
    if (is.na(x)) {
      return(NA_character_)
    }
    chars <- stringr::str_split(x, "")[[1]]
    n <- length(chars)
    n_reemplazar <- floor(n * porcentaje)
    if (n_reemplazar == 0) {
      return(x)
    }
    idx <- sample.int(n, size = n_reemplazar)
    chars[idx] <- sample(caracteres, size = n_reemplazar, replace = TRUE)
    paste(chars, collapse = "")
  })
}
