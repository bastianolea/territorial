#' Agregar clasificación comunal PNDR a comunas
#'
#' Para un vector de comunas, entrega la clasificación comunal PNDR correspondiente (Rural, Mixta o Urbana), tal como aparecen en [territorial::clasificacion].
#'
#' @param codigo_comuna Vector de códigos de comuna, idealmente `codigo_comuna`
#'
#' @returns Vector con clasificación comunal (Rural, Mixta o Urbana)
#' @export
#'
#' @examples
#' agregar_clasificacion(8107)
agregar_clasificacion <- function(codigo_comuna) {
  # codigo_comuna <- territorial::territorios$codigo_comuna[20:30]
  # codigo_comuna <- c(5605, 13122, 8207, 13101, 12201, 5601, 000000)

  clasificaciones <- territorial::clasificacion$clasificacion[match(codigo_comuna, territorial::clasificacion$codigo_comuna)]

  # territorial::clasificacion |>
  #   dplyr::filter(codigo_comuna %in% .env[["codigo_comuna"]]) |>
  #   dplyr::select(nombre_comuna, codigo_comuna, clasificacion)

  if (length(clasificaciones) != length(codigo_comuna)) {
    cli::cli_abort("largo de clasificaciones no es el mismo que comunas entregadas")
  }

  return(clasificaciones)
}
