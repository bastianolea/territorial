#' Redactar una secuencia de comunas en una oración
#'
#' Para un vector de nombres de comuna, retorna un texto con las comunas redactadas y separadas por comas. Por defecto, sólo redacta un texto de 10 comunas y al final pone "y x comunas más".
#'
#' @param nombre_comuna Nombres de comunas
#' @param largo Por defecto, si son demasiadas comunas, trunca el largo a `x` comunas. Cambiar a 0 para que muestre todas las comunas.
#'
#' @returns Texto con comunas separadas por comas
#' @export
#'
#' @examples
#' redactar_comunas(c("Paine", "Isla de Maipo", "Pirque"))
redactar_comunas <- function(nombre_comuna, largo = 10) {
  comunas_unicas <- unique(nombre_comuna)
  # comunas_unicas <- comunas()[10:19]
  n_comunas <- length(comunas_unicas)

  # mostrar todas las comunas
  if (largo == 0) {
    resultado <- glue::glue_collapse(comunas_unicas, sep = ", ", last = " y ")
    return(resultado)
  }

  # cortar las comunas al largo indicado
  if (largo > 0) {
    # revisar si hay menos que las que se pide cortar
    if (largo >= n_comunas) {
      resultado <- glue::glue_collapse(comunas_unicas, sep = ", ", last = " y ")
      return(resultado)
    }

    comunas_cortadas <- comunas_unicas[1:largo]
    comunas_restantes <- n_comunas - largo

    final <- c(comunas_cortadas, paste(comunas_restantes, "comunas más"))
    resultado <- glue::glue_collapse(final, sep = ", ", last = " y ")
    return(resultado)
  }
}
