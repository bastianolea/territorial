#' Artículos (de/del) de cada región de Chile
#'
#' Esta función entrega el artículo usado para cada región de Chile; por ejemplo, Valparaíso es la "Región _de_ Valparaíso", pero Maule es la "Región _del_ Maule".
#'
#' @param nombre_region Nombres de región, como aparecen en [territorial::regiones()]
#'
#' @returns Vector de artículos para cada nombre de región. Retorna NA si no se detecta la región.
#' @export
#'
#' @examples
#' articulo_region("Ñuble")
articulo_region <- function(nombre_region) {
  if (!is.character(nombre_region)) {
    cli::cli_abort("nombres de regiones deben venir en texto")
  }

  # vectores con nombres de regiones
  regiones_de <- c(
    "Tarapacá",
    "Antofagasta",
    "Atacama",
    "Coquimbo",
    "Valparaíso",
    "La Araucanía",
    "Los Lagos",
    "Aysén del General Carlos Ibáñez del Campo",
    "Magallanes y de la Antártica Chilena",
    "Los Ríos",
    "Arica y Parinacota",
    "Ñuble",
    "Santiago"
  )

  regiones_del <- c(
    "Libertador General Bernardo O'Higgins",
    "Maule",
    "Biobío"
  )

  regiones_sin <- c(
    "Metropolitana de Santiago",
    "Metropolitana"
  )

  articulos <- dplyr::case_when(
    nombre_region %in% regiones_del ~ "del",
    nombre_region %in% regiones_de ~ "de",
    nombre_region %in% regiones_sin ~ ""
  )

  if (!length(articulos) == length(nombre_region)) {
    cli::cli_abort("resultado no es del mismo largo que input")
  }
  return(articulos)
}
