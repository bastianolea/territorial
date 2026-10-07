#' Acortar nombres de las regiones de Chile
#'
#' Hay regiones de Chile con nombres extensos, y que en ciertos contextos requieren de una versión más breve. Esta función procesa el texto de los nombres de regiones para, por ejemplo, pasar desde "Aysén del General Carlos Ibáñez del Campo" a "Aysén".
#'
#' @param datos Dataframe con una columna de nombres de regiones, o vector de nombres de regiones
#' @param variable Columna del dataframe con los nombres de regiones (se pasa sin comillas, p.ej. `region`). Si no se especifica, se asume `nombre_region`. Si se aplica a un vector, omitir este argumento.
#'
#' @returns Si la entrada es un dataframe, retorna el dataframe con la columna de regiones reemplazada por sus versiones breves. Si es un vector, retorna un vector de texto con nombres de regiones breves.
#' @export
#'
#' @examples
#' acortar_regiones("Libertador Gral. Bernardo O'Higgins")
#'
#' territorios |>
#'   ordenar_regiones() |>
#'   dplyr::mutate(nombre_region_corto = acortar_regiones(nombre_region)) |>
#'   dplyr::select(nombre_region, nombre_region_corto)
#'
#' datos <- dplyr::tibble(
#'   nombre_region = c(
#'     "Libertador Gral. Bernardo O'Higgins",
#'     "Aysén del General Carlos Ibáñez del Campo"
#'   ),
#'   valores = c(4, 6)
#' )
#'
#' # si existe `nombre_region`, la función no requiere argumentos:
#' datos |>
#'   acortar_regiones()
acortar_regiones <- function(datos, variable = NULL) {
  # la función funciona con tablas o vectores, y con o sin especificar la columna (se asume `nombre_region`)
  # si es dataframe, la columna se extrae como vector
  if (any(class(datos) %in% "data.frame")) {
    col_expr <- rlang::enquo(variable)

    # si no se especifica columna, asumir `nombre_region`
    if (rlang::quo_is_null(col_expr)) {
      col_expr <- rlang::sym("nombre_region")
    }

    # error si la columna exista no existe
    if (!rlang::as_name(col_expr) %in% names(datos)) {
      cli::cli_abort("La columna {.var {rlang::as_name(col_expr)}} no existe!")
    }

    # desagrupar tabla
    datos <- dplyr::ungroup(datos)

    # extraer columna como vector
    nombre_region <- dplyr::pull(datos, !!col_expr)
  } else if (!is.list(datos)) {
    # si se entrega vector (incluye factores), continuar como vector
    nombre_region <- datos
  } else {
    # error si no es dataframe ni vector
    cli::cli_abort("Datos de tipo incompatible, debe ser dataframe o vector")
  }

  # si los datos vienen en formato factor, advertir que se perderá el orden
  # de los niveles al convertirlos a texto, y convertir a caracter
  if (is.factor(nombre_region)) {
    cli::cli_warn(
      "Los datos están en formato factor: se perderá el orden de los niveles al convertirlos a texto"
    )
    nombre_region <- as.character(nombre_region)
  }

  # revisar tipo
  if (is.numeric(nombre_region)) {
    cli::cli_abort(
      "Se necesitan nombres de regiones en tipo caracter!"
    )
  }

  resultado <- nombre_region |>
    stringr::str_remove_all("Región (de|del|De|Del|)") |>
    stringr::str_remove_all("\\.|\\,") |>
    stringr::str_remove_all("(?<=Metropolitana) (de|De) Santiago") |>
    stringr::str_remove_all("(L|l)ibertador (General|Gral) Bernardo") |>
    stringr::str_remove_all(
      "(del|Del|) (General|Gral) Carlos Ib(a|á)(ñ|n)ez (Del|del) Campo"
    ) |>
    stringr::str_remove_all("(y|Y) (de|De) (la|La) Ant(a|á)rtica Chilena") |>
    stringr::str_squish()

  # revisar resultado
  if (length(resultado) != length(nombre_region)) {
    cli::cli_abort(
      "Largo de las clasificaciones no es el mismo que regiones entregadas"
    )
  }

  # si es dataframe, agregar columna; si es vector, retornar vector
  if (any(class(datos) %in% "data.frame")) {
    return(dplyr::mutate(datos, !!col_expr := resultado))
  } else {
    return(resultado)
  }
}
