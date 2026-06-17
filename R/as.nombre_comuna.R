#' Convertir códigos comunales en nombres de comunas
#'
#' Entregando códigos comunales (como los que aparecen en `comunal::territorios`), retorna los nombres de comuna correspondientes. Retorna NA si no corresponde con ninguna.
#'
#' @param codigos_comunas Códigos comunales en formato numérico
#'
#' @returns Vector con nombres de comuna
#' @export
as.nombre_comuna <- function(codigos_comunas) {

  if (!class(codigos_comunas) %in% c("numeric", "integer")) {
   cli::cli_abort("códigos comunales deben venir en formato numérico")
  }

  nombres_comunas <- comunal::territorios$nombre_comuna

  nombres_encontrados <- comunal::territorios$nombre_comuna[match(codigos_comunas, comunal::territorios$codigo_comuna)]

  return(nombres_encontrados)
}



