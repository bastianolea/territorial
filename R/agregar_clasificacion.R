#' Agregar clasificación comunal PNDR a comunas
#'
#' Para un vector de comunas, entrega la clasificación comunal PNDR correspondiente (Rural, Mixta o Urbana), tal como aparecen en [territorial::clasificacion].
#'
#' @param codigo_comuna Vector de códigos de comuna, idealmente `codigo_comuna`. También puede ser un data frame con la columna `codigo_comuna`, en cuyo caso se retorna el data frame con la columna nueva `clasificacion`.
#' @param ordenar Entregar resultados como un factor ordenado (Rural, Mixta, Urbana), o como textos sin orden. Por defecto entrega factor.
#'
#' @returns Factor con clasificación comunal (Rural, Mixta o Urbana). Si la entrada es un data frame, retorna el data frame con la columna `clasificacion` agregada.
#' @seealso [clasificacion] para la tabla completa de clasificación comunal, y [agregar_macrozona()] para agrupar regiones en macrozonas. Si no tienes códigos comunales, usa [as_codigo_comuna()] o [contextualizar()].
#' @export
#'
#' @examples
#' agregar_clasificacion(8107)
#'
#' # con un data frame, usa la columna `codigo_comuna`
#' territorios |>
#'   agregar_clasificacion()
agregar_clasificacion <- function(
  codigo_comuna,
  ordenar = TRUE
) {
  # codigo_comuna <- territorial::territorios$codigo_comuna[20:30]
  # codigo_comuna <- c(5605, 13122, 8207, 13101, 12201, 5601, 000000)

  # si es data frame, buscar codigo_comuna y agregar columna
  if (is.data.frame(codigo_comuna)) {
    datos <- codigo_comuna

    if ("codigo_comuna" %in% names(datos)) {
      codigos <- datos[["codigo_comuna"]]
    } else {
      cli::cli_abort(
        "La tabla debe tener la columna {.var codigo_comuna}"
      )
    }

    datos <- dplyr::ungroup(datos)
    datos[["clasificacion"]] <- agregar_clasificacion(
      codigos,
      ordenar = ordenar
    )

    return(datos)
  }

  # revisar que sea un vector atómico (rechazar listas, etc.)
  if (!is.atomic(codigo_comuna) || is.null(codigo_comuna)) {
    cli::cli_abort(
      "Se necesita un vector de códigos de comuna, no una {.cls {class(codigo_comuna)}}"
    )
  }

  # factores se convierten a texto para que match() use sus valores y no sus niveles
  if (is.factor(codigo_comuna)) {
    codigo_comuna <- as.character(codigo_comuna)
  }

  clasificaciones <- territorial::clasificacion$clasificacion[match(
    codigo_comuna,
    territorial::clasificacion$codigo_comuna
  )]

  if (ordenar) {
    clasificaciones <- factor(
      clasificaciones,
      levels = c("Rural", "Mixta", "Urbana")
    )
  }

  # territorial::clasificacion |>
  #   dplyr::filter(codigo_comuna %in% .env[["codigo_comuna"]]) |>
  #   dplyr::select(nombre_comuna, codigo_comuna, clasificacion)

  if (length(clasificaciones) != length(codigo_comuna)) {
    cli::cli_abort(
      "largo de clasificaciones no es el mismo que comunas entregadas"
    )
  }

  return(clasificaciones)
}
