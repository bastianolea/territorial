#' Insertar caracteres al azar para ensuciar texto
#'
#' @param texto Vector de texto
#' @param porcentaje Porcentaje de caracteres a insertar
#' @param caracteres Vector de caracteres para insertar
#'
#' @returns Vector de texto con caracteres insertados al azar
#' @seealso [eliminar_texto()] y [reemplazar_texto()] para otras formas de ensuciar texto, útiles para probar [limpiar_comunas()].
#' @export
#'
#' @examples
#' insertar_texto(c("mapache", "lindo"), porcentaje = 0.3)
insertar_texto <- function(
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
    n_insertar <- floor(n * porcentaje)
    if (n_insertar == 0) {
      return(x)
    }
    # Posiciones 1..n+1: después de 0..n caracteres (incluye inicio y fin)
    pos <- sort(sample.int(n + 1, size = n_insertar, replace = TRUE))
    nuevos <- sample(caracteres, size = n_insertar, replace = TRUE)
    idx_insert <- pos - 1 + seq_along(pos)
    out <- character(n + n_insertar)
    out[idx_insert] <- nuevos
    out[-idx_insert] <- chars
    paste(out, collapse = "")
  })
}
