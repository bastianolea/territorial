#' Convertir códigos comunales a nombres de comunas
#'
#' Entregando códigos comunales (como los que aparecen en [territorial::territorios]), retorna los nombres de comuna correspondientes. Retorna NA si no corresponde con ninguna.
#'
#' @param codigos_comunas Códigos comunales en formato numérico
#'
#' @returns Vector con nombres de comuna
#' @examples
#' as_nombre_comuna(1101)
#'
#' as_nombre_comuna(c(1401, 1403, 9999, 1404))
#'
#' @export
as_nombre_comuna <- function(codigos_comunas) {
  # codigos_comunas <- c(1401, 1403, 9999, 1404)
  # codigos_comunas <- c(1401, 1403, 9999, 1404, 14904)
  # codigos_comunas <- c(1401, 1403, 9999, 1404, NA, 14904)
  if (!is.numeric(codigos_comunas)) {
    cli::cli_abort("Códigos comunales deben estar en formato numérico")
  }

  nombres_comunas <- territorios$nombre_comuna

  # del vector de nombres, extraer las posiciones que corresponden con códigos comunales
  nombres_encontrados <- territorios$nombre_comuna[match(
    codigos_comunas,
    territorios$codigo_comuna
  )]

  # si hay NA en resultados
  if (anyNA(nombres_encontrados)) {
    # n_perdidos <- sum(is.na(nombres_encontrados))
    # cli::cli_alert_warning(
    #   "Se obtu{?vo/vieron} {n_perdidos} valor{?es} perdido{?s} (NA) de la conversión a nombres de comunas"
    # )

    # si los NA resultantes son distintos a los que vienen
    if (any(is.na(codigos_comunas) != is.na(nombres_encontrados))) {
      # si resulta NA luego de coincidencia, alertar
      codigos_no_convertidos <- codigos_comunas[which(
        is.na(nombres_encontrados) & !is.na(codigos_comunas)
      )]
      texto <- glue::glue_collapse(
        unique(codigos_no_convertidos),
        sep = ", ",
        last = " y "
      )

      cli::cli_warn(
        "Algunos códigos comunales no pudieron convertirse a nombres de comunas: {texto}"
      )
    }
  }

  return(nombres_encontrados)
}
