#' Redactar nombres de regiones de Chile
#'
#' A partir de los nombres de regiones de Chile (como aparecen en [territorial::regiones()]), retorna la redacción de los nombres incluyendo "Región de/del"; por ejemplo, "Maule" se vuelve en "Región del Maule".
#'
#' @param nombre_region Nombres de región, como aparecen en [territorial::regiones()]
#'
#' @returns Vector de nombres de región redactados, incluyendo la palabra "Región", y el artículo apropiado (de o del, según [territorial::articulo_region()]) para cada nombre de región.
#' @export
#'
#' @examples
#' redactar_region("Maule")
redactar_region <- function(nombre_region) {
  # revisar si ya vienen, pero cnoflictá con Aydén, O'Higgins, y Magallanes
  # if (any(stringr::str_detect(nombre_region, "\\bde\\b|\\bdel\\b")))

  if (!is.character(nombre_region)) {
    cli::cli_abort("nombres de regiones deben venir en texto")
  }

  articulos <- territorial::articulo_region(nombre_region)

  redaccion <- paste("Región", articulos, nombre_region) |>
    stringr::str_squish() # por la RM, que no tiene artículo

  if (!length(redaccion) == length(nombre_region)) {
    cli::cli_abort("resultado no es del mismo largo que input")
  }

  return(redaccion)
}
