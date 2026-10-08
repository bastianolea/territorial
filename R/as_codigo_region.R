#' Convertir nombres de regiones a códigos regionales
#'
#' Entregando nombres de región correctos (como los que aparecen en [territorial::territorios]), retorna los códigos de región correspondientes en formato numérico  (números del 1 al 16). Retorna NA si no corresponde con ninguna.
#'
#' Para más información sobre los códigos únicos territoriales, revisa la viñeta \code{vignette("codigos_unicos_territoriales")}
#'
#' @param nombres_regiones Nombres de región (como los que aparecen en [territorial::territorios]) en formato caracter.
#'
#' @returns Vector numérico con códigos de región.
#' @export
#'
#' @examples
#' as_codigo_region("Metropolitana de Santiago")
#'
as_codigo_region <- function(nombres_regiones) {
  if (is.numeric(nombres_regiones)) {
    cli::cli_abort("Nombres de región deben ser de tipo caracter (texto)")
  }

  # territorial::territorios |>
  #   dplyr::distinct(nombre_region, codigo_region) |>
  #   dplyr::mutate(nombre_region = tolower(nombre_region))

  # nombres_regiones <- c("Atacama", "TARAPACÁ", "Maule", "O'Higgins")

  nombres_regiones <- limpiar_texto(nombres_regiones)

  codigos_encontrados <- dplyr::recode_values(
    nombres_regiones,
    "tarapaca" ~ 1,
    "antofagasta" ~ 2,
    "atacama" ~ 3,
    "coquimbo" ~ 4,
    "valparaiso" ~ 5,
    "libertador general bernardo ohiggins" ~ 6,
    "ohiggins" ~ 6,
    "maule" ~ 7,
    "biobio" ~ 8,
    "la araucania" ~ 9,
    "araucania" ~ 9,
    "los lagos" ~ 10,
    "aysen del general carlos ibanez del campo" ~ 11,
    "aysen del gral carlos ibanez del campo" ~ 11,
    "aysen" ~ 11,
    "magallanes y de la antartica chilena" ~ 12,
    "magallanes y antartica chilena" ~ 12,
    "magallanes" ~ 12,
    "metropolitana de santiago" ~ 13,
    "metropolitana" ~ 13,
    "santiago" ~ 13,
    "rm" ~ 13,
    "los rios" ~ 14,
    "arica y parinacota" ~ 15,
    "arica" ~ 15,
    "nuble" ~ 16
  )

  # si hay NA, advertir
  if (anyNA(codigos_encontrados)) {
    cli::cli_alert_warning(
      "Algunos nombres de regiones no fueron reconocidos correctamente."
    )
  }
  return(codigos_encontrados)
}
