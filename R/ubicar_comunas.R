#' Ubicar comunas en la región que les corresponde
#'
#' Para un vector de nombres de comuna o códigos comunales, retorna las regiones donde se ubican dichas regiones.
#'
#' @param nombre_comuna Nombres de comunas, como aparecen en [territorial::comunas()]
#' @param codigo_comuna Códigos comunales, como aparecen en [territorial::territorios]
#'
#' @returns Vector con nombres de regiones correspondientes
#' @export
#'
#' @examples
#' ubicar_comunas(c("Cerrillos", "Navidad"))
ubicar_comunas <- function(
  nombre_comuna = NULL,
  codigo_comuna = NULL
) {
  if (!is.null(nombre_comuna)) {
    # nombre_comuna = "Cerrillos"
    # nombre_comuna = c("Cerrillos", "Navidad")
    # stopifnot("comuna inválida" = territorial::is_nombre_comuna(nombre_comuna))

    nombre_region <- territorial::territorios$nombre_region[match(
      nombre_comuna,
      territorial::territorios$nombre_comuna
    )]
  } else if (!is.null(codigo_comuna)) {
    # codigo_comuna = 1101
    # stopifnot("comuna inválida" = territorial::is_codigo_comuna(codigo_comuna))

    nombre_region <- territorial::territorios$nombre_region[match(
      codigo_comuna,
      territorial::territorios$codigo_comuna
    )]
  } else {
    cli::cli_abort("especificar nombre o código de la comuna")
  }

  # stopifnot("resultado inválido" = is_nombre_region(nombre_region))

  return(nombre_region)
}
