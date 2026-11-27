#' Ubicar provincias en la región que les corresponde
#'
#' Entregando códigos provinciales (como los que aparecen en [territorial::territorios]) o nombres de provincias (que serán convertidos a códigos provinciales con [territorial::as_codigo_provincia()]), retorna los nombres de las regiones donde se ubican dichas provincias. Retorna NA si no corresponde con ninguna.
#'
#' @param codigo_provincia Códigos provinciales en formato numérico, o nombres de provincias (como en [territorial::provincias()])
#'
#' @returns Vector con nombres de regiones correspondientes
#' @seealso [as_codigo_provincia()] para convertir nombres de provincias a códigos, [as_nombre_provincia()] para la operación inversa, y [ubicar_comunas()] para ubicar comunas en su región o provincia.
#' @export
#'
#' @examples
#' ubicar_provincias(c("Iquique", "Santiago"))
ubicar_provincias <- function(codigo_provincia) {
  if (!is.numeric(codigo_provincia)) {
    codigo_provincia <- as_codigo_provincia(codigo_provincia)
  }

  # buscar regiones
  nombres_encontrados <- territorial::territorios$nombre_region[match(
    codigo_provincia,
    territorial::territorios$codigo_provincia
  )]

  # si hay NA en resultados
  if (anyNA(nombres_encontrados)) {
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
        "Algunos códigos provinciales no pudieron ubicarse en una región: {texto}"
      )
    }
  }

  return(nombres_encontrados)
}
