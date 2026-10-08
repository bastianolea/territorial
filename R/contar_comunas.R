#' Conteo de comunas disponibles, indicando las faltantes
#'
#' Revisa un vector o una tabla de datos (asumiendo la columna `nombre_comuna`, o indicando una columna que contenga nombres de comunas) e indica el conteo de comunas únicas, y emite mensajes dependiendo de esta cantidad: si es correcta (345 o 346), si es menor (indicando las que faltan) o si es mayor (recomendando validar con [territorial::validar_comunas()]).
#'
#' Sirve para revisar rápidamente que los datos abarquen todos los territorios del país, o indicar si faltan algunos.
#'
#' @param datos Dataframe con una columna de nombre de comunas, o vector de nombres de comunas
#' @param variable Columna del dataframe con los nombres de comunas (se pasa sin comillas, p.ej. `comuna`)
#' @param largo Si faltan comunas en los datos, enumera esta cantidad de comunas. Por defecto son 30, y el argumento se pasa a [territorial::redactar_comunas()].
#'
#' @returns Dataframe o vector intacto pero en modo invisible, con mensajes de conteo de comunas
#' @export
#'
#' @examples
#' territorios |>
#'   dplyr::slice_sample(n = 300) |>
#'   contar_comunas()
contar_comunas <- function(
  datos,
  variable = NULL,
  largo = 30
) {
  # la función funciona con tablas o vectores, y con especificar la columna o sin especificarla (se asume que es `nombre_comuna`)
  # si es una tabla, extraer columna como vector
  if (any(class(datos) %in% "data.frame")) {
    # cli::cli_alert_info(
    #   "Validando calidad de nombres de comuna desde tabla de datos"
    # )
    # extraer la variable
    col_expr <- rlang::enquo(variable)

    # si no se especificó la columna, asumir que es nombre_comuna
    if (rlang::quo_is_null(col_expr)) {
      # cli::cli_alert_info(
      #   "No se especificó la variable: asumiendo columna `nombre_comuna`"
      # )
      col_expr <- rlang::sym("nombre_comuna")
    }

    # revisar que la columna existe
    if (!rlang::as_name(col_expr) %in% names(datos)) {
      cli::cli_abort(
        "La columna {.var {rlang::as_name(col_expr)}} no existe!"
      )
    }

    # extraer la columna del dataframe
    nombre_comuna <- dplyr::pull(dplyr::ungroup(datos), !!col_expr)

    # si es un vector, se toma el vector
  } else if (is.vector(datos) && !is.list(datos)) {
    # cli::cli_alert_info("Validando calidad de nombres de comuna desde vector")
    nombre_comuna <- as.character(datos)

    # si no es ni dataframe ni vector, error
  } else {
    cli::cli_abort("Datos de tipo incompatible, debe ser dataframe o vector")
  }

  # revisar si son 345 o 346
  presentes <- unique(nombre_comuna)
  n_comunas <- length(presentes)

  cli::cli_alert_info("Cantidad de comunas únicas: {n_comunas}")

  if (n_comunas == 345) {
    cli::cli_alert_success(
      "La cantidad de comunas es correcta, aunque probablemente falta Antártica."
    )
  } else if (n_comunas == 346) {
    cli::cli_alert_success("La cantidad de comunas es correcta!")
  } else if (n_comunas > 346) {
    cli::cli_alert_warning(
      "La cantidad de comunas es anómala, revísalas con {.fn territorial::validar_comunas}"
    )
  } else if (n_comunas < 345) {
    faltantes <- comunas()[!comunas() %in% presentes]
    n_faltantes <- length(faltantes)

    cli::cli_alert_warning(
      "La cantidad de comunas es anómala: hay {n_comunas}, pero deberían ser 346. Revísalas con {.fn territorial::validar_comunas}"
    )

    cli::cli_alert(
      "Las comunas faltantes son: {redactar_comunas(faltantes, largo = largo)}"
    )
  } else {
    cli::cli_alert_warning(
      "La cantidad de comunas es menor a la esperable (345 o 346)"
    )
  }

  return(invisible(datos))
}
