#' Obtener las comunas de una región de Chile
#'
#' Entregando un nombre de región o un código de región, retorna un vector con los nombres de las comunas correspondientes.
#'
#' @param codigo_region Uno o más códigos de región, como aparecen en [territorial::territorios]
#' @param nombre_region Uno o más nombres de región, como aparecen en [territorial::regiones()]
#'
#' @returns Vector de comunas de la región o regiones
#' @export
#'
#' @examples
#' obtener_comunas("Tarapacá")
obtener_comunas <- function(
  nombre_region = NULL,
  codigo_region = NULL
) {
  tabla_regiones <- territorios |>
    dplyr::select(dplyr::ends_with("region"), dplyr::ends_with("comuna"))

  # si no rellenó nada
  if (is.null(codigo_region) & is.null(nombre_region)) {
    cli::cli_abort(
      "Debes introducir un código o nombre de región, revisa {.fn territorial::territorios}"
    )
  }

  # si introdujo ambos
  if (!is.null(codigo_region) & !is.null(nombre_region)) {
    cli::cli_abort(
      "Introduce un código {.strong o} un nombre de región, no ambos!"
    )
  }

  .codigo <- codigo_region
  .region <- nombre_region

  # filtrar por código
  if (!is.null(codigo_region)) {
    resultado <- tabla_regiones |>
      dplyr::filter(codigo_region %in% .codigo)
  }

  # filtrar por nombre
  if (!is.null(nombre_region)) {
    resultado <- tabla_regiones |>
      dplyr::filter(nombre_region %in% .region)
  }

  # si no hay resultados
  if (nrow(resultado) == 0) {
    cli::cli_abort("Región no encontrada, revisa {.fn territorial::regiones}")
  }

  # informar resultado
  comunas_region <- resultado |>
    dplyr::pull(nombre_comuna)

  cli::cli_alert_info(
    "Comunas de la región: {territorial::redactar_comunas(comunas_region, largo = 0)}"
  )

  return(comunas_region)
}
