#' Convertir regiones a capitales regionales
#'
#' Entregando códigos regionales (como los que aparecen en [territorial::territorios]) o nombres de regiones, retorna los nombres de las comunas que son capitales regionales correspondientes. Retorna NA si no corresponde con ninguna.
#'
#' Esta función es útil para imputar datos cuando se cuenta con la región, pero no se tiene información de las comunas, en cuyo caso se podría imputar la capital regional de la región como comuna de reemplazo.
#'
#' @param codigos_regiones Códigos regionales en formato numérico, o nombres de regiones (como en [territorial::regiones()])
#'
#' @returns Vector con nombres de comunas capitales regionales
#' @examples
#'
#' as_capital_regional(c(15, 4, 10, 99))
#'
#' as_capital_regional(c("Maule", "Ñuble"))
#'
#' @seealso [capitales_regionales()] para obtener la tabla de capitales regionales, [is_capital_regional()] para confirmar si las comunas son capitales, y [as_nombre_region()] para convertir códigos regionales a nombres de regiones.
#' @export
as_capital_regional <- function(codigos_regiones) {
  if (!is.numeric(codigos_regiones)) {
    codigos_regiones <- as_codigo_region(codigos_regiones)
  }

  nombres_encontrados <- capitales_regionales()$nombre_comuna[match(
    codigos_regiones,
    capitales_regionales()$codigo_region
  )]

  # si hay NA en resultados
  if (anyNA(nombres_encontrados)) {
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
        "Algunos códigos regionales no pudieron convertirse a capitales regionales: {texto}"
      )
    }
  }

  return(nombres_encontrados)
}
