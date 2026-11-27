#' Convertir nombres de provincias a códigos de provincia
#'
#' Entregando nombres de provincia correctos (como los que aparecen en [territorial::territorios]), retorna los códigos de provincia correspondientes en formato numérico. Retorna NA si no corresponde con ninguna. El prefijo "Provincia de" es ignorado, por lo que "Provincia de Iquique" y "Iquique" entregan el mismo código.
#'
#' Para más información sobre los códigos únicos territoriales, revisa la viñeta \code{vignette("codigos_unicos_territoriales")}
#'
#' @param nombre_provincia Nombres de provincia (como los que aparecen en [territorial::territorios]) en formato caracter.
#'
#' @returns Vector numérico con códigos de provincia.
#' @seealso [provincias()] para un vector de los nombres de provincias, [as_nombre_provincia()] para la conversión inversa, y [as_codigo_region()] para convertir nombres de regiones.
#' @export
#'
#' @examples
#' as_codigo_provincia("Iquique")
#'
#' as_codigo_provincia(c("Provincia de Copiapó", "Arica", "Nombre inventado"))
#'
as_codigo_provincia <- function(nombre_provincia) {
  if (is.numeric(nombre_provincia)) {
    cli::cli_abort("Nombres de provincia deben ser de tipo caracter (texto)")
  }

  # conservar nombres originales para los mensajes
  nombres_originales <- nombre_provincia

  nombres_limpios <- nombre_provincia |>
    limpiar_texto() |>
    # quitar prefijo "provincia de" de los nombres ingresados
    stringr::str_remove("^provincia del |^provincia de ")

  referencia_provincias <- territorial::territorios |>
    dplyr::distinct(codigo_provincia, nombre_provincia) |>
    dplyr::mutate(nombre_provincia_limpio = limpiar_texto(nombre_provincia))

  codigos_encontrados <- referencia_provincias$codigo_provincia[match(
    nombres_limpios,
    referencia_provincias$nombre_provincia_limpio
  )]

  # si hay NA en resultados
  if (anyNA(codigos_encontrados)) {
    # si los NA resultantes son distintos a los que vienen
    if (any(is.na(nombres_originales) != is.na(codigos_encontrados))) {
      nombres_no_convertidos <- nombres_originales[which(
        is.na(codigos_encontrados) & !is.na(nombres_originales)
      )]
      texto <- glue::glue_collapse(
        unique(nombres_no_convertidos),
        sep = ", ",
        last = " y "
      )

      cli::cli_warn(
        "Algunos nombres de provincias no fueron reconocidos correctamente: {texto}"
      )
    }
  }

  return(codigos_encontrados)
}
