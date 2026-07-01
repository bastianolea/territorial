#' Validación de calidad de nombres de comunas de Chile
#'
#' Esta función recibe una columna con nombres de comunas de un dataframe (idealmente `nombre_comuna`), o un vector con nombres de comunas, y retorna una evaluación de posibles problemas con los nombres existentes. Funciona tanto con un dataframe con una columna `nombre_comuna`, o un vector que contenga los nombres de comunas a evaluar. La función solamente retorna avisos cuando existan problemas, por lo que si todos los datos son correctos, solo devolverá los datos tal cual.
#'
#' @param datos Dataframe con una columna de nombre de comunas, o vector de nombres de comunas
#' @param variable Columna del dataframe con los nombres de comunas (se pasa sin comillas, p.ej. `comuna`)
#'
#' @returns Dataframe o vector intacto pero en modo invisible, con mensajes de diagnóstico si se encuentran problemas de calidad
#' @export
#'
#' @examples
#' validar_comunas(c("chiguayante", "la florida", "paine"))
#'
#' territorial::territorios |>
#'   validar_comunas(nombre_comuna)
validar_comunas <- function(
  datos,
  variable = NULL
) {
  # si es una tabla, extraer columna como vector
  if (any(class(datos) %in% "data.frame")) {
    col_expr <- rlang::enquo(variable)

    if (rlang::quo_is_null(col_expr)) {
      cli::cli_abort(
        "Debes especificar la columna de comunas, p.ej.: {.code validar_comunas(comuna)}"
      )
    }

    nombre_comuna <- dplyr::pull(dplyr::ungroup(datos), !!col_expr)
  } else if (is.vector(datos)) {
    nombre_comuna <- as.character(datos)
  } else {
    cli::cli_abort("Datos de tipo incompatible, debe ser dataframe o vector")
  }

  # nombre_comuna <- territorial::comunas()

  # excluir missings
  nombre_comuna <- nombre_comuna[!is.na(nombre_comuna)]

  revisar <- list()

  # comunas correctas ---
  # nombre_comuna <- c("Puente Alto", "Perrito", "Cerrillos")
  revisar$comunas_correctas <- !nombre_comuna %in% territorial::comunas()

  if (any(revisar$comunas_correctas)) {
    cli::cli_alert_warning(
      "Resumen: {sum(revisar$comunas_correctas)} caso{?s} de comunas que no conciden con comunas correctamente escritas (ver {.fun territorial::comunas}): {redactar_comunas(nombre_comuna[revisar$comunas_correctas])}"
    )
  }

  # mayúsculas ----
  # nombre_comuna <- territorial::comunas()
  # nombre_comuna <-  c(toupper(territorial::comunas()[1:4]), territorial::comunas()[5:16])
  revisar$mayusculas <- nombre_comuna == toupper(nombre_comuna)

  if (any(revisar$mayusculas)) {
    cli::cli_alert_warning(
      "Mayúsculas: {sum(revisar$mayusculas)} caso{?s} de comunas escritas en mayúsculas: {redactar_comunas(nombre_comuna[revisar$mayusculas])}"
    )
  }

  # minúsculas ----
  # nombre_comuna <- territorial::comunas()
  # nombre_comuna <-  c(tolower(territorial::comunas()[1:4]), territorial::comunas()[5:16])
  revisar$minusculas <- nombre_comuna == tolower(nombre_comuna)

  if (any(revisar$minusculas)) {
    cli::cli_alert_warning(
      "Minúsculas: {sum(revisar$minusculas)} caso{?s} de comunas escritas en minúsculas: {redactar_comunas(nombre_comuna[revisar$minusculas])}"
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
      "Mayúsculas: {sum(revisar$mayusc_preposic)} caso{?s} de comunas con preposiciones ('de', 'del') escritas en mayúsculas: {redactar_comunas(nombre_comuna[revisar$mayusc_preposic])}"
    )
  }

  # # comunas sin tilde ----
  # nombre_comuna <- territorial::comunas()
  # nombre_comuna <- c("Maipu", "Alhue", "Peñalolén", "Nunoa", "vina del mar")
  comunas_con_tilde <- territorial::comunas() |>
    stringr::str_subset("á|é|í|ó|ú|Á|É|Í|Ó|Ú")

  comunas_sin_tilde <- chartr(
    "áéíóúÁÉÍÓÚ",
    "aeiouAEIOU",
    comunas_con_tilde
  )

  revisar$sin_tilde <- tolower(nombre_comuna) %in% tolower(comunas_sin_tilde)

  if (any(revisar$sin_tilde)) {
    cli::cli_alert_info(
      "Tildes: {sum(revisar$sin_tilde)} caso{?s} de comunas que deberían tener tildes y no los tienen: {redactar_comunas(nombre_comuna[revisar$sin_tilde])}"
    )
  }

  # comunas sin eñe ----
  comunas_con_eñe <- territorial::comunas() |>
    stringr::str_subset("ñ|Ñ")

  comunas_sin_eñe <- chartr(
    "ñÑ",
    "nN",
    comunas_con_eñe
  )

  revisar$sin_eñe <- tolower(nombre_comuna) %in% tolower(comunas_sin_eñe)

  if (any(revisar$sin_eñe)) {
    cli::cli_alert_info(
      "Eñes: {sum(revisar$sin_eñe)} caso{?s} de comunas escritas sin eñe: {redactar_comunas(nombre_comuna[revisar$sin_eñe])}"
    )
  }

  # comunas sin diéresis ----
  comunas_con_dieresis <- territorial::comunas() |>
    stringr::str_subset("ä|ë|ï|ö|ü|Ä|Ë|Ï|Ö|Ü")

  comunas_sin_dieresis <- chartr(
    "äëïöüÄËÏÖÜ",
    "aeiouAEIOU",
    comunas_con_dieresis
  )

  revisar$sin_dieresis <- tolower(nombre_comuna) %in%
    tolower(comunas_sin_dieresis)

  if (any(revisar$sin_dieresis)) {
    cli::cli_alert_info(
      "Eñes: {sum(revisar$sin_dieresis)} caso{?s} de comunas que deberían tener diéresis (¨) y no tienen: {redactar_comunas(nombre_comuna[revisar$sin_dieresis])}"
    )
  }

  # problemas típicos ----
  comunas_mal_escritas <- c(
    "Ohiggins",
    "O´higgins",
    "O`higgins",
    "Llay-llay",
    "Llayllay",
    "Llay llay",
    "Llai llay",
    "Llai llai"
  )

  revisar$tipicos <- tolower(nombre_comuna) %in%
    tolower(comunas_mal_escritas)

  if (any(revisar$tipicos)) {
    cli::cli_alert_info(
      "Problemas comunes: {sum(revisar$tipicos)} caso{?s} de comunas popularmente mal escritas: {redactar_comunas(nombre_comuna[revisar$tipicos])}"
    )
  }

  # formas recomendadas ----
  comunas_recomendadas <- c(
    "Treguaco",
    "Paiguano",
    "Aisén",
    "Aisen"
  )

  revisar$distintas <- tolower(nombre_comuna) %in%
    tolower(comunas_recomendadas)

  if (any(revisar$distintas)) {
    cli::cli_alert_info(
      "Escrituras alternativas: {sum(revisar$distintas)} caso{?s} de comunas escritas de una forma no recomendada, aunque válida: {redactar_comunas(nombre_comuna[revisar$distintas])}"
    )
  }

  # # inexistentes ----
  # comunas_recomendadas <- c(
  #   "Navarino",
  # )

  # browser()

  # terminar ----

  n_problemas <- unlist(revisar) |> sum()

  if (n_problemas == 0) {
    cli::cli_alert_success("Todas las comunas están correctas!")
  } else {
    cli::cli_alert_danger(
      "Validación de comunas: se encontr{?ó/aron} {n_problemas} problema{?s} con las comunas! Usa {.fn territorial::limpiar_comunas} para solucionarlos."
    )
  }

  return(invisible(datos))
}
