#' Convertir códigos regionales a nombres de regiones
#'
#' Entregando códigos regionales (como los que aparecen en [territorial::territorios]), retorna los nombres de región correspondientes. Retorna NA si no corresponde con ninguna.
#'
#' @param codigo_region Códigos regionales en formato numérico
#'
#' @returns Vector con nombres de región
#' @examples
#' as_nombre_region(16)
#'
#' as_nombre_region(c(15, 4, 10, 99))
#'
#' @seealso [as_codigo_region()] para la conversión inversa, y [redactar_region()] o [acortar_regiones()] para cambiar cómo se escriben los nombres resultantes.
#' @export
as_nombre_region <- function(codigo_region) {
  if (!is.numeric(codigo_region)) {
    cli::cli_alert_warning("Códigos regionales deben estar en formato numérico")
    codigo_region <- as.numeric(codigo_region)
  }

  nombres_encontrados <- territorios$nombre_region[match(
    codigo_region,
    territorial::territorios$codigo_region
  )]

  # si hay NA en resultados
  if (anyNA(nombres_encontrados)) {
    # n_perdidos <- sum(is.na(nombres_encontrados))
    # cli::cli_alert_warning(
    #   "Se obtu{?vo/vieron} {n_perdidos} valor{?es} perdido{?s} (NA) de la conversión a nombres de regiones"
    # )

    # si los NA resultantes son distintos a los que vienen
    if (any(is.na(codigo_region) != is.na(nombres_encontrados))) {
      codigos_no_convertidos <- codigo_region[which(
        is.na(nombres_encontrados) & !is.na(codigo_region)
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
