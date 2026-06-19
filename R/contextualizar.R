#' Contextualizar datos de nivel comunal con variables territoriales
#'
#' Para cualquier tabla de datos de nivel comunal que tenga al menos una variable territorial (`codigo_comuna` o `nombre_comuna`), indicar esta variable para agregar todo el resto de variables territoriales. De esta manera, se contextualizan territorialmente los datos al agregar todas las variables territoriales faltantes.
#'
#' @param datos Dataframe de datos comunales al que se quieren agregar columnas con variables territoriales
#' @param variable Variable territorial ya existente en el dataframe (`codigo_comuna` o `nombre_comuna`)
#'
#' @returns El mismo dataframe con las columnas `codigo_region`, `nombre_region`, `codigo_provincia`, `nombre_provincia`, `codigo_comuna` y `nombre_comuna` agregadas al inicio.
#' @export
#'
#' @examples
#' datos <- dplyr::tribble(
#'   ~nombre_comuna, ~valor,
#'   "Cerrillos",    1,
#'   "Arica",        2,
#'   "Putre",        3)
#'
#' datos |>
#'   contextualizar(variable = "nombre_comuna")
contextualizar <- function(
    datos,
    variable = NULL
) {

  # variable = "codigo_comuna"

  # sólo una variable
  if (length(variable) != 1) {
    cli::cli_abort("especificar sólo una variable, las otras variables territoriales ya existentes en los datos serán descartadas")
  }

  # si es código comunal, chequear que son correctos
  # si es nombre de comuna, chequear que son correctos

  # verificar si existe alguna variable territorial
  if (!any(names(datos) %in% names(territorial::territorios))) {
    cli::cli_abort("los datos tienen que venir con alguna variable territorial, como {glue::glue_collapse(names(territorial::territorios), sep = ', ', last = ' o ')}")
  }

  # chequear si existe la variable
  if (!any(names(datos) %in% variable)) {
    cli::cli_abort("datos no contienen columna `{variable}`")
  }

  # revisar si existen otras variables territoriales aparte de la definida
  variables_territoriales_presentes <- length(intersect(names(datos), names(territorial::territorios)))

  if (variables_territoriales_presentes > 1) {

    cli::cli_alert_warning("más de una variable territorial detectada en los datos! descartando todas excepto `{variable}`.")

    # todas las otras
    otras_variables_territoriales <- setdiff(names(territorial::territorios), variable)

    # descartarlas
    datos <- datos |>
      dplyr::select(-dplyr::any_of(otras_variables_territoriales))
  }

  # unir datos
  datos_a <- datos |>
    dplyr::left_join(
      territorial::territorios,
      by = variable
    )

  # ordenar datos
  datos_b <- datos_a |>
    dplyr::relocate(
      names(territorial::territorios),
      .before = 1
    )

  # revisiones de resultado
  # confirmar que tengan las mismas filas
  if (!nrow(datos_b) == nrow(datos)) {
    cli::cli_alert_warning("problemas con el left_join(): cambió el número de filas")
  }

  # confirmar que tenga más columnas
  if (!length(datos_b) > length(datos)) {
    cli::cli_alert_warning("problemas con el left_join(): no aumentó el número de columnas")
  }

  # mensajes
  # revisar columnas nuevas y avisar
  diferencia <- setdiff(names(datos_b), names(datos))
  cli::cli_alert_info("columnas agregadas: {glue::glue_collapse(diferencia, sep = ', ', last = ' y ')}")

  return(datos_b)
}

