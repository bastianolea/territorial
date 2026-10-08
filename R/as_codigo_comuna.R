#' Convertir nombres de comunas a códigos comunales
#'
#' Entregando nombres de comuna correctos (como los que aparecen en [territorial::comunas()] o en [territorial::territorios]), retorna los códigos de comuna correspondientes en formato numérico. Retorna NA si no corresponde con ninguna.
#'
#' Para más información sobre los códigos únicos territoriales, revisa la viñeta \code{vignette("codigos_unicos_territoriales")}
#'
#' @param nombres_comunas Nombres de comuna (como los que aparecen en [territorial::comunas()]) en formato caracter.
#'
#' @returns Vector numérico con códigos de comuna.
#' @export
#'
#' @examples
#' as_codigo_comuna("La Florida")
#'
as_codigo_comuna <- function(nombres_comunas) {
  # nombres_comunas = c("La Florida", "Puente Altosh")
  #   nombres_comunas = 11191
  if (is.numeric(nombres_comunas)) {
    cli::cli_abort("Nombres de comuna deben ser de tipo caracter (texto)")
  }

  codigos_encontrados <- territorios$codigo_comuna[match(
    nombres_comunas,
    territorios$nombre_comuna
  )]

  # si hay NA, recomendar limpieza
  if (anyNA(codigos_encontrados)) {
    cli::cli_alert_warning(
      "Algunos nombres de comunas no fueron reconocidos correctamente. Considera aplicar {.fun territorial::limpiar_comunas} antes."
    )
  }
  return(codigos_encontrados)
}
