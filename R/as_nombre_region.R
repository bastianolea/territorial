#' Convertir códigos regionales a nombres de regiones
#'
#' Entregando códigos regionales (como los que aparecen en [territorial::territorios]), retorna los nombres de región correspondientes. Retorna NA si no corresponde con ninguna.
#'
#' @param codigos_regiones Códigos regionales en formato numérico
#'
#' @returns Vector con nombres de región
#' @examples
#' as_nombre_region(16)
#'
#' as_nombre_region(c(15, 4, 10, 99))
#'
#' @export
as_nombre_region <- function(codigos_regiones) {
  if (!is.numeric(codigos_regiones)) {
    cli::cli_abort("Códigos regionales deben estar en formato numérico")
  }

  nombres_encontrados <- territorios$nombre_region[match(
    codigos_regiones,
    territorios$codigo_region
  )]

  # si hay NA en resultados
  if (anyNA(nombres_encontrados)) {
    # n_perdidos <- sum(is.na(nombres_encontrados))
    # cli::cli_alert_warning(
    #   "Se obtu{?vo/vieron} {n_perdidos} valor{?es} perdido{?s} (NA) de la conversión a nombres de regiones"
    # )

    # si los NA resultantes son distintos a los que vienen
    if (any(is.na(codigos_regiones) != is.na(nombres_encontrados))) {
      codigos_no_convertidos <- codigos_regiones[which(
        is.na(nombres_encontrados) & !is.na(codigos_regiones)
      )]
      texto <- glue::glue_collapse(
        unique(codigos_no_convertidos),
        sep = ", ",
        last = " y "
      )

      cli::cli_warn(
        "Algunos códigos regionales no pudieron convertirse a nombres de regiones: {texto}"
      )
    }
  }

  return(nombres_encontrados)
}
