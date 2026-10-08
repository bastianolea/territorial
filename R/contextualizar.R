#' Contextualizar datos de nivel comunal con variables territoriales
#'
#' Para cualquier tabla de datos de nivel comunal que tenga al menos una variable territorial (`codigo_comuna` o `nombre_comuna`), indicar esta variable para agregar todo el resto de variables territoriales. De esta manera, se contextualizan territorialmente los datos al agregar todas las variables territoriales faltantes.
#'
#' Se usa, por ejemplo, cuando tienes una tabla de datos que tienen solamente los nombres de las comunas (primero valída con [territorial::validar_comunas()] y/o limpia con [territorial::validar_comunas()]), y quieres agregarle más variables territoriales como los códigos únicos territoriales, las provincias, regiones, etc.
#'
#' @param datos Dataframe de datos comunales al que se quieren agregar columnas con variables territoriales
#' @param variable Variable territorial ya existente en el dataframe (`codigo_comuna` o `nombre_comuna`). Si se omite, se asume `nombre_comuna`.
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
#'   contextualizar(nombre_comuna)
#'
#' # si ya existe una columna `nombre_comuna`, puede omitirse el argumento
#' datos |>
#'   contextualizar()
contextualizar <- function(
  datos,
  variable = NULL
) {
  # datos <- dplyr::tribble(
  #   ~nombre_comuna, ~valor,
  #   "Cerrillos",    1,
  #   "Arica",        2,
  #   "Putre",        3)

  # obtener variable entregada
  col_expr <- rlang::enquo(variable)

  # caso 2: se pasó más de una variable o una expresión inválida
  if (
    !rlang::quo_is_null(col_expr) &&
      !rlang::is_symbol(rlang::quo_get_expr(col_expr))
  ) {
    cli::cli_abort(
      "Se debe especificar solo una variable territorial sin comillas (p.ej. {.code nombre_comuna})"
    )
  }

  # si no se especificó la columna, asumir que es nombre_comuna
  if (rlang::quo_is_null(col_expr)) {
    cli::cli_alert_info(
      "No se especificó la variable: asumiendo columna {.var nombre_comuna}"
    )
    col_expr <- rlang::sym("nombre_comuna")
  }

  variable <- rlang::as_name(col_expr)

  # chequear si existe la variable
  if (!variable %in% names(datos)) {
    cli::cli_abort("Los datos no contienen la columna {.var {variable}}")
  }

  # caso 3: codigo_comuna entregado como character en vez de numérico
  if (variable == "codigo_comuna" && is.character(datos[[variable]])) {
    cli::cli_abort(
      "La columna {.var codigo_comuna} debe ser numérica, no de texto. Usa {.code as.numeric(codigo_comuna)} para convertirla!"
    )
  }

  # revisar si existen otras variables territoriales aparte de la definida
  variables_territoriales_presentes <- length(intersect(
    names(datos),
    names(territorios)
  ))

  if (variables_territoriales_presentes > 1) {
    cli::cli_alert_warning(
      "Más de una variable territorial detectada en los datos! descartando todas excepto `{variable}`."
    )

    # todas las otras
    otras_variables_territoriales <- setdiff(
      names(territorios),
      variable
    )

    # descartarlas
    datos <- datos |>
      dplyr::select(-dplyr::any_of(otras_variables_territoriales))
  }

  # unir datos
  datos_a <- datos |>
    dplyr::left_join(
      territorios,
      by = variable
    )

  # caso 1: filas sin match en el catálogo territorial
  filas_sin_match <- sum(is.na(datos_a$codigo_region))
  if (filas_sin_match > 0) {
    cli::cli_alert_warning(
      "{filas_sin_match} fila{?s} no coincidi{?ó/eron} con {.code territorial::territorios} y quedar{?á/án} con NA"
    )
  }

  # ordenar datos
  datos_b <- datos_a |>
    dplyr::relocate(
      names(territorios),
      .before = 1
    )

  # revisiones de resultado
  # confirmar que tengan las mismas filas
  if (!nrow(datos_b) == nrow(datos)) {
    cli::cli_alert_warning(
      "Problemas con el {.code left_join()}: cambió el número de filas"
    )
  }

  # confirmar que tenga más columnas
  if (!length(datos_b) > length(datos)) {
    cli::cli_alert_warning(
      "Problemas con el {.code left_join()}: no aumentó el número de columnas"
    )
  }

  # mensajes
  # revisar columnas nuevas y avisar
  diferencia <- setdiff(names(datos_b), names(datos))
  cli::cli_alert_info(
    "Columnas agregadas: {glue::glue_collapse(diferencia, sep = ', ', last = ' y ')}"
  )

  return(datos_b)
}
