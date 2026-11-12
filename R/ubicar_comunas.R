#' Ubicar comunas en la región o provincia que les corresponde
#'
#' Entregando códigos comunales (como los que aparecen en [territorial::territorios]) o nombres de comunas (que serán convertidos a códigos comunales con [territorial::as_codigo_comuna()]), retorna los nombres de las regiones o provincias (según el argumento `nivel`) donde se ubican dichas comunas. Retorna NA si no corresponde con ninguna.
#'
#' @param codigo_comuna Códigos comunales en formato numérico, o nombres de comunas (como en [territorial::comunas()])
#' @param nivel Ubicar la/s comuna/s en su "región" (por defecto) o "provincia".
#'
#' @returns Vector con nombres de regiones o provincias correspondientes
#' @seealso [obtener_comunas()] para hacer lo inverso, [contextualizar()] para agregar región, provincia y códigos a una tabla, y [ubicar_localidades()] para territorios más pequeños que una comuna.
#' @export
#'
#' @examples
#' ubicar_comunas(c("Cerrillos", "Navidad"))
#'
#' ubicar_comunas(c(1101, 13103))
#'
#' ubicar_comunas("Puente Alto", nivel = "provincia")
ubicar_comunas <- function(
  codigo_comuna,
  nivel = "región"
) {
  # codigo_comuna <- "Puente Alto"
  # nivel = "provincia"
  if (!is.numeric(codigo_comuna)) {
    codigo_comuna <- as_codigo_comuna(codigo_comuna)
  }

  if (!tolower(nivel) %in% c("región", "provincia")) {
    cli::cli_abort(
      "El argumento {.arg nivel} debe ser {.val región} o {.val provincia}"
    )
  }

  # elegir columna
  columna <- switch(
    tolower(nivel),
    "región" = "nombre_region",
    "provincia" = "nombre_provincia"
  )

  # buscar comunas
  nombres_encontrados <- territorial::territorios[[columna]][match(
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
        "Algunos códigos comunales no pudieron ubicarse en una {nivel}: {texto}"
      )
    }
  }

  return(nombres_encontrados)
}
