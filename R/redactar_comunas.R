#' Redactar una secuencia de comunas en una oración
#'
#' Para un vector de nombrees de comuna, retorna un texto con las comunas redactadas y separadas por comas.
#'
#' @param x Nombres de comunas
#'
#' @returns Texto con comunas separadas por comas
#' @export
#'
#' @examples
#' redactar_comunas(c("Paine", "Isla de Maipo", "Pirque"))
redactar_comunas <- function(x) {
  glue::glue_collapse(unique(x), sep = ", ", last = " y ")
}
