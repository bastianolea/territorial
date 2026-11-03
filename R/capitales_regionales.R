#' Capitales regionales de Chile
#'
#' Tabla de datos basada en [territorial::territorios] que contiene las comunas donde están ubicadas las capitales regionales de cada región.
#'
#' @returns _Dataframe_ de 16 filas
#' @export
#'
#' @seealso Para ver todas las comunas, regiones y provincias de Chile, usa [territorial::territorios]. Usa [regiones()] para un vector con todas las regiones, o [comunas()] para un vector con todas las comunas de Chile.
#' @examples
#'
#' capitales_regionales()
#'
capitales_regionales <- function() {
  capitales <- c(
    "Arica",
    "Iquique",
    "Antofagasta",
    "Copiapó",
    "Coquimbo",
    "Valparaíso",
    "Santiago",
    "Rancagua",
    "Talca",
    "Punta Arenas",
    "Chillán",
    "Concepción",
    "Temuco",
    "Valdivia",
    "Puerto Montt",
    "Coyhaique"
  )

  territorial::territorios |>
    dplyr::filter(nombre_comuna %in% capitales)
}
