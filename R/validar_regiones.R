#' Validación de calidad de nombres de regiones de Chile
#'
#' Esta función recibe la columna con nombres de regiones de un dataframe (idealmente `nombre_region`), y retorna una evaluación de posibles problemas con los nombres existentes. Funciona tanto con un dataframe con una columna `nombre_region`, o un vector que contenga los nombres de regiones a evaluar.
#'
#' @param nombre_region Columna con nombres de regiones, o vector con nombres de regiones
#'
#' @returns Dataframe o vector intacto, con mensajes de diagnóstico si se encuentran problemas de calidad
#' @export
#'
#' @examples
#' validar_regiones(c("los lagos", "nuble", "OHIGGINS"))
#'
validar_regiones <- function(
  datos,
  variable = "nombre_region"
) {
  # si es una tabla, extraer columna como vector
  if (any(class(datos) %in% "data.frame")) {
    nombre_region <- datos |>
      dplyr::ungroup() |>
      dplyr::select(dplyr::all_of(variable)) |>
      dplyr::pull()
  } else if (is.vector(datos)) {
    nombre_region <- as.character(datos)
  } else {
    cli::cli_abort("datos de tipo incompatible, debe ser dataframe o vector")
  }
  # nombre_region <- territorial::regiones()
  # nombre_region <-  c(toupper(territorial::regiones()[1:4]), territorial::regiones()[5:16])
  # nombre_region <-  c(tolower(territorial::regiones()[1:4]), territorial::regiones()[5:16])
  # nombre_region <- c(territorial::regiones(), "Región Del Maule")
  # nombre_region <- c(territorial::regiones(), "Nuble")
  # nombre_region <- c(territorial::regiones(), "OHiggins")
  # nombre_region <- c(territorial::regiones(), "O´Higgins", "o`higgins", "o.higgins", "ohiggins")
  # nombre_region <- c(territorial::regiones(), "Aisén")
  # nombre_region <- c("hola", "araucanía", "Lagos", "Los Lagos")

  # excluir missings
  nombre_region <- nombre_region[!is.na(nombre_region)]

  revisar <- list()

  # mayúsculas ----
  # nombre_region <- territorial::regiones() |> toupper()
  # nombre_region <-  c(toupper(nombre_region[1:4]), nombre_region[5:16])
  revisar$mayusculas <- nombre_region == toupper(nombre_region)

  if (any(revisar$mayusculas)) {
    cli::cli_alert_warning(
      "mayúsculas: {sum(revisar$mayusculas)} caso{?s} de regiones escritas en mayúsculas"
    )
  }

  # minúsculas ----
  # nombre_region <- territorial::regiones() |> tolower()
  # nombre_region <-  c(tolower(nombre_region[1:4]), nombre_region[5:16])
  revisar$minusculas <- nombre_region == tolower(nombre_region)

  if (any(revisar$minusculas)) {
    cli::cli_alert_warning(
      "mayúsculas: {sum(revisar$minusculas)} caso{?s} de regiones escritas en minúsculas"
    )
  }

  # regiones con mayúsculas en las preposiciones ---
  # nombre_region <- c(territorial::regiones(), "Región Del Maule")
  revisar$mayusc_preposic <- stringr::str_detect(
    nombre_region,
    "\\bDe\\b|\\bDel"
  )

  if (any(revisar$mayusc_preposic)) {
    cli::cli_alert_warning(
      "mayúsculas: {sum(revisar$mayusc_preposic)} caso{?s} de regiones con preposiciones ('de', 'del') escritas en mayúsculas"
    )
  }

  # Ñuble sin ñ ---
  # nombre_region <- c(territorial::regiones(), "Nuble")
  revisar$nuble <- stringr::str_detect(tolower(nombre_region), "nuble")

  if (any(revisar$nuble)) {
    cli::cli_alert_warning(
      "ortografía: {sum(revisar$nuble)} caso{?s} de la Región de Ñuble escrita sin eñe"
    )
  }

  # O'Higgins sin apóstrofo ----
  # nombre_region <- c(territorial::regiones(), "OHiggins")
  revisar$ohiggins_1 <- stringr::str_detect(tolower(nombre_region), "ohiggin")

  if (any(revisar$ohiggins_1)) {
    cli::cli_alert_warning(
      "ortografía: {sum(revisar$ohiggins_1)} caso{?s} de la Región de O'Higgins escrita sin su apóstrofo (')"
    )
  }

  # O'Higgins con apóstrofo incorrecto ----
  # nombre_region <- c(territorial::regiones(), "O´Higgins", "o`higgins", "o.higgins", "ohiggins")
  revisar$ohiggins_2 <- stringr::str_detect(
    tolower(nombre_region),
    "o[^']higgin"
  )

  if (any(revisar$ohiggins_2)) {
    cli::cli_alert_warning(
      "ortografía: {sum(revisar$ohiggins_2)} caso{?s} de la Región de O'Higgins escrita con un apóstrofo (') incorrecto"
    )
  }

  # Aysén es con Y ----
  # nombre_region <- c(territorial::regiones(), "Aisén")
  revisar$aysen <- stringr::str_detect(tolower(nombre_region), "ais(e|é)n")

  if (any(revisar$aysen)) {
    cli::cli_alert_warning(
      "ortografía: {sum(revisar$aysen)} caso{?s} de la Región de Aysén escrita con 'i' latina (no es incorrecto, pero es más usado con 'y' griega)"
    )
  }

  # regiones sin tilde ----
  revisar$tildes <- stringr::str_detect(
    tolower(nombre_region),
    "a(i|y)sen|araucania|valparaiso|tarapaca|antartica|iba(n|ñ)ez"
  )

  if (any(revisar$tildes)) {
    cli::cli_alert_warning(
      "ortografía: {sum(revisar$tildes)} caso{?s} de regiones escritas sin tilde"
    )
  }

  # la araucanía, los ríos y los lagos sin preposición ----
  # nombre_region <- c("hola", "araucanía", "Lagos", "Los Lagos")
  revisar$preposiciones <- stringr::str_detect(
    tolower(nombre_region),
    "^(araucanía|ríos|lagos)\\b"
  )

  if (any(revisar$preposiciones)) {
    cli::cli_alert_warning(
      "redacción: {sum(revisar$preposiciones)} caso{?s} de regiones sin sus preposiciones ('la', 'los')"
    )
  }

  return(datos)
}
