#' Buscar comunas por similitud
#'
#' Usar un término de búsqueda para obtener una tabla con comunas de nombres similares. Funciona con cualquier tabla de datos que contenga una columna con nombres de comunas, por lo que esta función puede ayudarte a encontrar comunas en fuentes externas y así confirmar o solucionar problemas. Para buscar sobre las comunas oficiales de Chile, usa [territorial::territorios].
#'
#' @param datos Tabla de datos sobre la cual buscar, por ejemplo [territorial::territorios]. Debe contener una columna con nombres de comunas (especificada en el argumento `columna`).
#' @param texto Texto que quieres buscar entre las comunas
#' @param columna Columna de `datos` que contiene los nombres de comunas a comparar. Por defecto `nombre_comuna`. Se puede especificar sin comillas (tidy evaluation) o como texto.
#' @param similitud El nivel de similitud mínimo a retornar, donde 1 es total similitud y 0 es nula similitud. Por defecto es 0,9.
#' @param cantidad Cantidad máxima de resultados, por defecto 6. Poner `Inf` para mostrar todos.
#'
#' @returns Mensajes respecto de la búsqueda, y el dataframe entregado en el argumento `datos` filtrado según comunas que cumplan con el criterio de `similitud` de la búsqueda.
#' @examples
#' territorios |>
#'  buscar_comuna("peña") |>
#'  dplyr::select(nombre_comuna, puntaje)
#'
#' territorios |>
#'  buscar_comuna("alto") |>
#'  dplyr::select(nombre_comuna, puntaje)
#'
#' territorios |>
#'  buscar_comuna("antofagasta") |>
#'  dplyr::select(nombre_comuna, puntaje)
#'
#' territorios |>
#'  buscar_comuna("perro") |>
#'  dplyr::select(nombre_comuna, puntaje)
#'
#' @export
buscar_comuna <- function(
  datos,
  texto,
  columna = nombre_comuna,
  similitud = 0.9,
  cantidad = 6
) {
  if (missing(datos)) {
    cli::cli_abort(
      "Debes especificar el argumento {.arg datos}, por ejemplo {.code territorios}."
    )
  }

  # para poder recibir otras tablas, refiriendo a su columna
  columna <- rlang::enquo(columna)
  nombre_columna <- rlang::as_name(columna)

  if (!nombre_columna %in% names(datos)) {
    cli::cli_abort(
      "La columna {.code {nombre_columna}} no existe en {.arg datos}!"
    )
  }

  nombres_comunas <- dplyr::pull(datos, !!columna)

  # distancia de Levenshtein, donde 0 es una coincidencia exacta
  distancia <- as.vector(
    adist(tolower(texto), tolower(nombres_comunas), partial = TRUE)
  )

  # puntaje de similitud normalizado a entre 0 y 1
  puntaje <- 1 - distancia / pmax(nchar(texto), nchar(nombres_comunas))

  # filtrar tabla de comunas según resultados de búsqueda
  resultados <- datos |>
    dplyr::mutate(puntaje = puntaje) |>
    dplyr::arrange(dplyr::desc(puntaje)) |>
    dplyr::filter(puntaje >= similitud)

  if (nrow(resultados) > cantidad) {
    cli::cli_alert_warning(
      "Se encontraron {nrow(resultados)} resultados, mostrando sólo {cantidad}."
    )
  } else {
    cli::cli_alert_info(
      "Se encontr{?ó/aron} {nrow(resultados)} comuna{?s} similar{?es}."
    )
  }

  if (!is.infinite(cantidad)) {
    resultados <- resultados |>
      dplyr::slice(1:cantidad)
  }

  # comunas de coindicencia alta
  similares <- resultados |>
    dplyr::filter(puntaje == 1)

  if (nrow(similares) > 0) {
    cli::cli_alert_info(
      "Los resultados más cercanos al término {.code {texto}} son: {redactar_comunas(dplyr::pull(similares, !!columna))}"
    )
  } else {
    cli::cli_warn(
      "No hay comunas de alta similaridad al término {.code {texto}}"
    )
  }

  return(resultados)
}
