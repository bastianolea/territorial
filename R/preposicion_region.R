#' Preposición (de/del) de cada región de Chile
#'
#' Esta función entrega la preposición usada para cada región de Chile; por ejemplo, Valparaíso es la "Región _de_ Valparaíso", pero Maule es la "Región _del_ Maule".
#'
#' @param nombre_region Nombres de región, como aparecen en [territorial::regiones()]
#'
#' @returns Vector de preposiciones para cada nombre de región. Retorna NA si no se detecta la región.
#' @seealso [redactar_region()] para redactar el nombre completo de la región ("Región del Maule").
#' @export
#'
#' @examples
#' preposicion_region("Ñuble")
#'
#' preposicion_region("O'Higgins")
preposicion_region <- function(nombre_region) {
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
    "O'Higgins",
    "La Araucanía",
    "Los Lagos",
    "Aysén del General Carlos Ibáñez del Campo",
    "Aysén",
    "Magallanes y de la Antártica Chilena",
    "Magallanes",
    "Los Ríos",
    "Arica y Parinacota",
    "Arica",
    "Ñuble",
    "Santiago"
  )

  regiones_de_la <- c(
    "Araucanía"
  )

  regiones_de_los <- c(
    "Lagos",
    "Ríos"
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

  # decidir preposición
  preposicion <- dplyr::case_when(
    nombre_region %in% regiones_del ~ "del",
    nombre_region %in% regiones_de ~ "de",
    nombre_region %in% regiones_sin ~ "",
    nombre_region %in% regiones_de_la ~ "de la",
    nombre_region %in% regiones_de_los ~ "de los"
  )

  if (!length(preposicion) == length(nombre_region)) {
    cli::cli_abort("resultado no es del mismo largo que input")
  }
  return(preposicion)
}
