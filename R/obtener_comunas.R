#' Obtener las comunas de una región de Chile
#'
#' Entregando uno o más códigos de región o nombres de región, retorna un vector con los nombres de las comunas correspondientes.
#'
#' @param codigo_region Uno o más códigos de región en formato numérico (como aparecen en [territorial::territorios]), o nombres de región (como en [territorial::regiones()]) en formato caracter o factor.
#'
#' @returns Vector de comunas de la región o regiones
#' @seealso [ubicar_comunas()] para hacer lo inverso (obtener la región de una comuna), y [comunas()] o [regiones()] para vectores con todas las comunas o regiones del país.
#' @export
#'
#' @examples
#' obtener_comunas("Tarapacá")
#'
#' obtener_comunas(c(15, 1))
obtener_comunas <- function(codigo_region) {
  if (missing(codigo_region)) {
    cli::cli_abort(
      "Debes introducir un código o nombre de región, revisa {.fn territorial::regiones}"
    )
  }

  if (is.factor(codigo_region)) {
    codigo_region <- as.character(codigo_region)
  }

  if (!is.numeric(codigo_region)) {
    codigo_region <- as_codigo_region(codigo_region)
  }

  .codigo <- codigo_region

  comunas_region <- territorial::territorios |>
    dplyr::filter(codigo_region %in% .codigo) |>
    dplyr::pull(nombre_comuna)

  # si no hay resultados
  if (length(comunas_region) == 0) {
    cli::cli_abort("Región no encontrada, revisa {.fn territorial::regiones}")
  }

  cli::cli_alert_info(
    "Comunas de la región: {territorial::redactar_comunas(comunas_region, largo = 0)}"
  )

  return(comunas_region)
}
