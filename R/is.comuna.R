#' Evaluar si es una comuna
#'
#' @param x Elemento/s a evaluar
#'
#' @returns TRUE o FALSE si es o no es una comuna
#' @export
#'
#' @examples is.comuna("Panguipulli")
is.comuna <- function(x) {

  x %in% comunal::comunas()
}


# ejemplos <- c("Maipú", "Cerrillos", "Ñuñoa")
#
# is.comuna(ejemplos)
