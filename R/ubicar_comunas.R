#' Ubicar comunas en la región que les corresponde
#'
#' Entregando códigos comunales (como los que aparecen en [territorial::territorios]) o nombres de comunas, retorna los nombres de las regiones donde se ubican dichas comunas. Retorna NA si no corresponde con ninguna.
#'
#' @param codigo_comuna Códigos comunales en formato numérico, o nombres de comunas (como en [territorial::comunas()])
#'
#' @returns Vector con nombres de regiones correspondientes
#' @seealso [obtener_comunas()] para hacer lo inverso, [contextualizar()] para agregar región, provincia y códigos a una tabla, y [ubicar_localidades()] para territorios más pequeños que una comuna.
#' @export
#'
#' @examples
#' ubicar_comunas(c("Cerrillos", "Navidad"))
#'
#' ubicar_comunas(c(1101, 13103))
ubicar_comunas <- function(codigo_comuna) {
  if (!is.numeric(codigo_comuna)) {
    codigo_comuna <- as_codigo_comuna(codigo_comuna)
  }

  nombres_encontrados <- territorial::territorios$nombre_region[match(
    codigo_comuna,
    territorial::territorios$codigo_comuna
  )]

  # si hay NA en resultados
  if (anyNA(nombres_encontrados)) {
    # si los NA resultantes son distintos a los que vienen
    if (any(is.na(codigo_comuna) != is.na(nombres_encontrados))) {
      codigos_no_convertidos <- codigo_comuna[which(
        is.na(nombres_encontrados) & !is.na(codigo_comuna)
      )]
      texto <- glue::glue_collapse(
        unique(codigos_no_convertidos),
        sep = ", ",
        last = " y "
      )

      cli::cli_warn(
        "Algunos códigos comunales no pudieron ubicarse en una región: {texto}"
      )
    }
  }

  return(nombres_encontrados)
}
