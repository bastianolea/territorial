#' Convertir nombres de comunas a códigos de comuna
#'
#' Entregando nombres de comuna correctos (como los que aparecen en `comunal::comunas()` o en `comunal::territorios`), retorna los códigos de comuna correspondientes en formato numérico. Retorna NA si no corresponde con ninguna.
#'
#' @param nombres_comunas Nombres de comuna (como los que aparecen en `comunal::comunas()`)
#'
#' @returns Vector numérico con códigos de comuna
#' @export
as.codigo_comuna <- function(nombres_comunas) {

  codigos_comunas <- comunal::territorios$codigo_comuna

  codigos_encontrados <- codigos_comunas[match(nombres_comunas, comunal::territorios$nombre_comuna)]

  return(codigos_encontrados)
}



