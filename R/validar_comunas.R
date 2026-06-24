#' Validación de calidad de nombres de comunas de Chile
#'
#' Esta función recibe una columna con nombres de comunas de un dataframe (idealmente `nombre_comuna`), o un vector con nombres de comunas, y retorna una evaluación de posibles problemas con los nombres existentes. Funciona tanto con un dataframe con una columna `nombre_comuna`, o un vector que contenga los nombres de comunas a evaluar.
#'
#' @param nombre_comuna Columna de un dataframe con nombres de comunas, o vector con nombres de comunas
#'
#' @returns Dataframe o vector intacto, con mensajes de diagnóstico si se encuentran problemas de calidad
#' @export
#'
#' @examples
#' validar_comunas(c("colliguay", "la florida", "paine"))
#'
#' territorial::territorios |>
#'   validar_comunas()
validar_comunas <- function(
  datos,
  variable = "nombre_comuna"
) {
  # si es una tabla, extraer columna como vector
  if (any(class(datos) %in% "data.frame")) {
    nombre_comuna <- datos |>
      dplyr::ungroup() |>
      dplyr::select(dplyr::all_of(variable)) |>
      dplyr::pull()
  } else if (is.vector(datos)) {
    nombre_comuna <- as.character(datos)
  } else {
    cli::cli_abort("datos de tipo incompatible, debe ser dataframe o vector")
  }

  # nombre_comuna <- territorial::comunas()

  # excluir missings
  nombre_comuna <- nombre_comuna[!is.na(nombre_comuna)]

  revisar <- list()

  # mayúsculas ----
  # nombre_comuna <- territorial::comunas()
  # nombre_comuna <-  c(toupper(territorial::comunas()[1:4]), territorial::comunas()[5:16])
  revisar$mayusculas <- nombre_comuna == toupper(nombre_comuna)

  if (any(revisar$mayusculas)) {
    cli::cli_alert_warning(
      "mayúsculas: {sum(revisar$mayusculas)} caso{?s} de comunas escritas en mayúsculas"
    )
  }

  # minúsculas ----
  # nombre_comuna <- territorial::comunas()
  # nombre_comuna <-  c(tolower(territorial::comunas()[1:4]), territorial::comunas()[5:16])
  revisar$minusculas <- nombre_comuna == tolower(nombre_comuna)

  if (any(revisar$minusculas)) {
    cli::cli_alert_warning(
      "mayúsculas: {sum(revisar$minusculas)} caso{?s} de comunas escritas en minúsculas"
    )
  }

  # comunas con mayúsculas en las preposiciones ---
  # nombre_comuna <- c(territorial::comunas(), "Región Del Maule")
  revisar$mayusc_preposic <- stringr::str_detect(
    nombre_comuna,
    "\\bDe\\b|\\bDel"
  )

  if (any(revisar$mayusc_preposic)) {
    cli::cli_alert_warning(
      "mayúsculas: {sum(revisar$mayusc_preposic)} caso{?s} de comunas con preposiciones ('de', 'del') escritas en mayúsculas"
    )
  }

  # comunas correctas ---
  # nombre_comuna <- c("Puente Alto", "Perrito", "Cerrillos")
  revisar$comunas_correctas <- !nombre_comuna %in% territorial::comunas()

  if (any(revisar$comunas_correctas)) {
    cli::cli_alert_info(
      "resumen: {sum(revisar$comunas_correctas)} caso{?s} de comunas que no conciden con comunas correctamente escritas (ver {.fun territorial::comunas})"
    )
  }

  # # comunas sin tilde ----
  # comunas_con_tilde <- territorial::comunas() |>
  #   stringr::str_subset("á|é|í|ó|ú|Á|É|Í|Ó|Ú")
  #
  # comunas_sin_tilde <- chartr(
  #   "áéíóúÁÉÍÓÚ",
  #   "aeiouAEIOU",
  #   comunas_con_tilde
  # )
  # tolower(nombre_comuna) %in% tolower(comunas_limpias)
  #
  # # comunas sin eñe ----
  # comunas_con_eñe <- territorial::comunas() |>
  #   stringr::str_subset("ñ|Ñ")
  #
  # comunas_sin_eñe <- chartr(
  #   "ñÑ",
  #   "nN",
  #   comunas_con_eñe
  # )
  #
  # # comunas sin diéresis ----
  # comunas_con_dieresis <- territorial::comunas() |>
  #   stringr::str_subset("ä|ë|ï|ö|ü|Ä|Ë|Ï|Ö|Ü")
  #
  # comunas_sin_dieresis <- chartr(
  #   "äëïöüÄËÏÖÜ",
  #   "aeiouAEIOU",
  #   comunas_con_dieresis
  # )
  #
  # O'Higgins ----

  return(datos)
}
