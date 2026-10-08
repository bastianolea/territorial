#' Validación de calidad de nombres de regiones de Chile
#'
#' Esta función recibe la columna con nombres de regiones de un dataframe (idealmente `nombre_region`), y retorna una evaluación de posibles problemas con los nombres existentes. Funciona tanto con un dataframe con una columna `nombre_region`, o un vector que contenga los nombres de regiones a evaluar. La función solamente retorna avisos cuando existan problemas, por lo que si todos los datos son correctos, solo devolverá los datos tal cual.
#'
#' @param datos Dataframe con una columna de nombre de regiones, o vector de nombres de regiones
#' @param variable Columna del dataframe con los nombres de regiones (se pasa sin comillas, p.ej. `region`)
#'
#' @returns Dataframe o vector intacto pero en modo invisible, con mensajes de diagnóstico si se encuentran problemas de calidad
#' @export
#'
#' @examples
#' validar_regiones(c("los lagos", "nuble", "OHIGGINS"))
#'
#' territorial::territorios |>
#'   validar_regiones(nombre_region)
validar_regiones <- function(
  datos,
  variable = NULL
) {
  # la función funciona con tablas o vectores, y con especificar la columna o sin especificarla (se asume que es `nombre_region`)
  # si es una tabla, extraer columna como vector
  if (any(class(datos) %in% "data.frame")) {
    # cli::cli_alert_info(
    #   "Validando calidad de nombres de región desde tabla de datos"
    # )
    # extraer la variable
    col_expr <- rlang::enquo(variable)

    # si no se especificó la columna, asumir que es nombre_region
    if (rlang::quo_is_null(col_expr)) {
      cli::cli_alert_info(
        "No se especificó la variable: asumiendo columna `nombre_region`"
      )
      col_expr <- rlang::sym("nombre_region")
    }

    # revisar que la columna existe
    if (!rlang::as_name(col_expr) %in% names(datos)) {
      cli::cli_abort(
        "La columna {.var {rlang::as_name(col_expr)}} no existe!"
      )
    }

    # extraer la columna del dataframe
    nombre_region <- dplyr::pull(dplyr::ungroup(datos), !!col_expr)

    # si es un vector, se toma el vector
  } else if (is.vector(datos) && !is.list(datos)) {
    # cli::cli_alert_info("Validando calidad de nombres de región desde vector")
    nombre_region <- as.character(datos)
  } else {
    cli::cli_abort("Datos de tipo incompatible, debe ser dataframe o vector")
  }
  # nombre_region <- regiones()
  # nombre_region <-  c(toupper(regiones()[1:4]), regiones()[5:16])
  # nombre_region <-  c(tolower(regiones()[1:4]), regiones()[5:16])
  # nombre_region <- c(regiones(), "Región Del Maule")
  # nombre_region <- c(regiones(), "Nuble")
  # nombre_region <- c(regiones(), "OHiggins")
  # nombre_region <- c(regiones(), "O´Higgins", "o`higgins", "o.higgins", "ohiggins")
  # nombre_region <- c(regiones(), "Aisén")
  # nombre_region <- c("hola", "araucanía", "Lagos", "Los Lagos")

  # excluir missings
  nombre_region <- nombre_region[!is.na(nombre_region)]

  revisar <- list()

  # mayúsculas ----
  # nombre_region <- regiones() |> toupper()
  # nombre_region <-  c(toupper(nombre_region[1:4]), nombre_region[5:16])
  revisar$mayusculas <- nombre_region == toupper(nombre_region)

  if (any(revisar$mayusculas)) {
    cli::cli_alert_warning(
      "Mayúsculas: {sum(revisar$mayusculas)} caso{?s} de regiones escritas en mayúsculas"
    )
  }

  # minúsculas ----
  # nombre_region <- regiones() |> tolower()
  # nombre_region <-  c(tolower(nombre_region[1:4]), nombre_region[5:16])
  revisar$minusculas <- nombre_region == tolower(nombre_region)

  if (any(revisar$minusculas)) {
    cli::cli_alert_warning(
      "Mayúsculas: {sum(revisar$minusculas)} caso{?s} de regiones escritas en minúsculas"
    )
  }

  # regiones con mayúsculas en las preposiciones ---
  # nombre_region <- c(regiones(), "Región Del Maule")
  revisar$mayusc_preposic <- stringr::str_detect(
    nombre_region,
    "\\bDe\\b|\\bDel"
  )

  if (any(revisar$mayusc_preposic)) {
    cli::cli_alert_warning(
      "Mayúsculas: {sum(revisar$mayusc_preposic)} caso{?s} de regiones con preposiciones ('de', 'del') escritas en mayúsculas"
    )
  }

  # Ñuble sin ñ ---
  # nombre_region <- c(regiones(), "Nuble")
  revisar$nuble <- stringr::str_detect(tolower(nombre_region), "nuble")

  if (any(revisar$nuble)) {
    cli::cli_alert_warning(
      "Ortografía: {sum(revisar$nuble)} caso{?s} de la Región de Ñuble escrita sin eñe"
    )
  }

  # O'Higgins sin apóstrofo ----
  # nombre_region <- c(regiones(), "OHiggins")
  revisar$ohiggins_1 <- stringr::str_detect(tolower(nombre_region), "ohiggin")

  if (any(revisar$ohiggins_1)) {
    cli::cli_alert_warning(
      "Ortografía: {sum(revisar$ohiggins_1)} caso{?s} de la Región de O'Higgins escrita sin su apóstrofo (')"
    )
  }

  # O'Higgins con apóstrofo incorrecto ----
  # nombre_region <- c(regiones(), "O´Higgins", "o`higgins", "o.higgins", "ohiggins")
  revisar$ohiggins_2 <- stringr::str_detect(
    tolower(nombre_region),
    "o[^']higgin"
  )

  if (any(revisar$ohiggins_2)) {
    cli::cli_alert_warning(
      "Ortografía: {sum(revisar$ohiggins_2)} caso{?s} de la Región de O'Higgins escrita con un apóstrofo (') incorrecto"
    )
  }

  # Aysén es con Y ----
  # nombre_region <- c(regiones(), "Aisén")
  revisar$aysen <- stringr::str_detect(tolower(nombre_region), "ais(e|é)n")

  if (any(revisar$aysen)) {
    cli::cli_alert_warning(
      "Ortografía: {sum(revisar$aysen)} caso{?s} de la Región de Aysén escrita con 'i' latina (no es incorrecto, pero es más usado con 'y' griega)"
    )
  }

  # regiones sin tilde ----
  revisar$tildes <- stringr::str_detect(
    tolower(nombre_region),
    "a(i|y)sen|araucania|valparaiso|tarapaca|antartica|iba(n|ñ)ez"
  )

  if (any(revisar$tildes)) {
    cli::cli_alert_warning(
      "Ortografía: {sum(revisar$tildes)} caso{?s} de regiones escritas sin tilde"
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
      "Redacción: {sum(revisar$preposiciones)} caso{?s} de regiones sin sus preposiciones ('la', 'los')"
    )
  }

  # browser()

  n_problemas <- unlist(revisar) |> sum()

  if (n_problemas == 0) {
    cli::cli_alert_success("Todas las regiones están correctas!")
  } else {
    cli::cli_alert_danger(
      "Validación de regiones: se encontr{?ó/aron} {n_problemas} problema{?s} con las regiones!"
    )
  }

  return(invisible(datos))
}
