#' Convertir códigos de provincia a nombres de provincias
#'
#' Entregando códigos de provincia (como los que aparecen en [territorial::territorios]), retorna los nombres de provincias correspondientes. Retorna NA si no corresponde con ninguna.
#'
#' @param codigo_provincia Códigos provinciales en formato numérico
#'
#' @returns Vector con nombres de provincia
#' @examples
#' as_nombre_provincia(11)
#'
#' as_nombre_provincia(c(11, 71, 73, 99))
#'
#' @seealso [as_codigo_provincia()] para la conversión inversa.
#' @export
as_nombre_provincia <- function(codigo_provincia) {
  if (!is.numeric(codigo_provincia)) {
    cli::cli_alert_warning(
      "Códigos de provincia deben estar en formato numérico"
    )
    codigo_provincia <- as.numeric(codigo_provincia)
  }

  nombres_encontrados <- territorios$nombre_provincia[match(
    codigo_provincia,
    territorial::territorios$codigo_provincia
  )]

  # si hay NA en resultados
  if (anyNA(nombres_encontrados)) {
    # n_perdidos <- sum(is.na(nombres_encontrados))
    # cli::cli_alert_warning(
    #   "Se obtu{?vo/vieron} {n_perdidos} valor{?es} perdido{?s} (NA) de la conversión a nombres de provinciaes"
    # )

    # si los NA resultantes son distintos a los que vienen
    if (any(is.na(codigo_provincia) != is.na(nombres_encontrados))) {
      codigos_no_convertidos <- codigo_provincia[which(
        is.na(nombres_encontrados) & !is.na(codigo_provincia)
      )]
      texto <- glue::glue_collapse(
        unique(codigos_no_convertidos),
        sep = ", ",
        last = " y "
      )

      cli::cli_warn(
        "Algunos códigos de provincia no pudieron convertirse a nombres de provincia: {texto}"
      )
    }
  }

  return(nombres_encontrados)
}
