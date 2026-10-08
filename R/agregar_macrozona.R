#' Agregar macrozona del país a regiones
#'
#' Las macrozonas son agrupaciones de regiones de Chile que permiten entender el territorio en base a grupos geográficos. Para un vector de códigos de regiones (del 1 al 16), entrega las macrozonas correspondientes a cada región.
#'
#' Como no existe una clasificación fija de macrozonas, existen varias alternativas para elegir:
#' * Macrozonas tipo 1: desde Arica a Coquimbo son _Norte_, desde Valparaíso a Maule _Centro_, desde Ñuble a Los Lagos _Sur_, y desde Aysén a Magallanes _Austral_.
#' * Macrozonas tipo 2: distribución balanceada por cantidad de regiones: 4 grupos de 4 regiones: _Norte_, _Centro_, _Centro/sur_ y _Sur_.
#' * Macrozonas tipo 3: según las macrozonas del Ministerio de Ciencia, Tecnología, Conocimiento e Innovación, que definr 5 macrozonas (_Norte, Centro, Centro sur, Sur,_ y _Austral_), y excluye a la Región Metropolitana. Para más información, #' \href{https://www.bcn.cl/leychile/navegar?idNorma=1142798}{revisar el decreto} que establece a las Seremis del ministerio de Ciencia.
#' * Macrozonas tipo 4: basadas en el \href{https://es.wikipedia.org/wiki/Regiones_naturales_de_Chile}{programa curricular de educación básica} del Ministerio de Educación de Chile, existirían _Norte grande, Norte chico, Zona central, Zona sur_ y _Zona austral_.
#' * Macrozonas tipo 5: dividen al país en _norte, centro_ y _sur_ según las agrupaciones del estudio Identificación de Localidades en Condición de Aislamiento 2012, de Subdere.
#'
#' @param codigo_region Vector de códigos de región (del 1 al 16)
#' @param tipo Tipo de macrozonas a aplicar. Por defecto se usa el tipo 1. Ver la documentación más arriba.
#' @param ordenar Entregar resultados como un factor ordenado (de norte a sur), o como textos sin orden. Por defecto entrega factor.
#'
#' @returns Factor con macrozonas regionales, de acuerdo al tipo de clasificación de regiones elegido.
#' @export
#'
#' @examples
#' agregar_macrozona(c(15, 13, 12), tipo = 1)
#'
#' territorios |>
#'   dplyr::distinct(codigo_region, nombre_region) |>
#'   ordenar_regiones() |>
#'   dplyr::mutate(
#'     macrozona_1 = agregar_macrozona(codigo_region, tipo = 1),
#'     macrozona_2 = agregar_macrozona(codigo_region, tipo = 2),
#'     macrozona_3 = agregar_macrozona(codigo_region, tipo = 3),
#'     macrozona_4 = agregar_macrozona(codigo_region, tipo = 4)
#'  )
agregar_macrozona <- function(
  codigo_region,
  tipo = 1,
  ordenar = TRUE
) {
  # revisar que tipo sea válido
  if (length(tipo) != 1 || is.na(tipo) || !(tipo %in% 1:5)) {
    cli::cli_abort(
      "El argumento {.code tipo} debe ser un número entre 1 y 5, no {tipo}"
    )
  }

  # revisar que sea un vector atómico (rechazar listas, data frames, etc.)
  if (!is.atomic(codigo_region) || is.null(codigo_region)) {
    cli::cli_abort(
      "Se necesita un vector de códigos de región, no una {.cls {class(codigo_region)}}"
    )
  }

  # revisar tipo
  if (is.character(codigo_region)) {
    cli::cli_alert_warning(
      "Se entregaron códigos regionales en formato caracter. Se recomienda convertir a numérico."
    )
    codigo_region <- as.numeric(codigo_region)
  }

  # revisar si es código comunal
  if (any(is_codigo_comuna(codigo_region))) {
    cli::cli_abort(
      "Se entregaron códigos comunales en vez de códigos regionales"
    )
  }

  # revisar si hay códigos fuera del rango de regiones válidas (1 a 16)
  fuera_de_rango <- !is.na(codigo_region) &
    !(codigo_region %in% 1:16)

  if (any(fuera_de_rango)) {
    cli::cli_abort(
      "Se entregaron códigos de región fuera de rango (deben estar entre 1 y 16): {codigo_region[fuera_de_rango]}"
    )
  }

  # datos <- territorios |>
  #   dplyr::select(dplyr::ends_with("region")) |>
  #   dplyr::distinct() |>
  #   ordenar_regiones()
  #
  # datos$codigo_region |> dput()

  # codigo_region <- c(15, 1, 2, 3, 4, 5, 13, 6, 7, 16, 8, 9, 14, 10, 11, 12)

  if (tipo == 1) {
    niveles <- c("Norte", "Centro", "Sur", "Austral")

    macrozonas <- dplyr::case_when(
      codigo_region %in% c(15, 1, 2, 3, 4) ~ niveles[1],
      codigo_region %in% c(5, 13, 6, 7) ~ niveles[2],
      codigo_region %in% c(16, 8, 9, 14, 10) ~ niveles[3],
      codigo_region %in% c(11, 12) ~ niveles[4]
    )

    if (ordenar) {
      macrozonas <- factor(macrozonas, levels = niveles)
    }
  } else if (tipo == 2) {
    niveles <- c("Norte", "Centro", "Centro/sur", "Sur")

    macrozonas <- dplyr::case_when(
      codigo_region %in% c(15, 1, 2, 3) ~ niveles[1],
      codigo_region %in% c(4, 5, 13, 6) ~ niveles[2],
      codigo_region %in% c(7, 16, 8, 9) ~ niveles[3],
      codigo_region %in% c(14, 10, 11, 12) ~ niveles[4]
    )

    if (ordenar) {
      macrozonas <- factor(macrozonas, levels = niveles)
    }
  } else if (tipo == 3) {
    niveles <- c(
      "Norte",
      "Centro",
      "Metropolitana",
      "Centro sur",
      "Sur",
      "Austral"
    )

    macrozonas <- dplyr::case_when(
      codigo_region %in% c(15, 1, 2, 3) ~ niveles[1],
      codigo_region %in% c(4, 5) ~ niveles[2],
      codigo_region %in% c(13) ~ niveles[3],
      codigo_region %in% c(6, 7, 16, 8) ~ niveles[4],
      codigo_region %in% c(9, 14, 10) ~ niveles[5],
      codigo_region %in% c(11, 12) ~ niveles[6]
    )

    if (ordenar) {
      macrozonas <- factor(macrozonas, levels = niveles)
    }
  } else if (tipo == 4) {
    niveles <- c(
      "Norte Grande",
      "Norte Chico",
      "Zona central",
      "Zona Sur",
      "Zona Austral"
    )

    macrozonas <- dplyr::case_when(
      codigo_region %in% c(15, 1, 2) ~ niveles[1],
      codigo_region %in% c(3, 4, 5) ~ niveles[2],
      codigo_region %in% c(13, 6, 7, 16, 8) ~ niveles[3],
      codigo_region %in% c(9, 14, 10) ~ niveles[4],
      codigo_region %in% c(11, 12) ~ niveles[5]
    )

    if (ordenar) {
      macrozonas <- factor(macrozonas, levels = niveles)
    }
  } else if (tipo == 5) {
    niveles <- c("Norte", "Centro", "Sur")

    macrozonas <- dplyr::case_when(
      codigo_region %in% c(15, 1, 2, 3, 4) ~ niveles[1],
      codigo_region %in% c(5, 13, 6, 7, 16, 8, 9, 14) ~ niveles[2],
      codigo_region %in% c(10, 11, 12) ~ niveles[3]
    )

    if (ordenar) {
      macrozonas <- factor(macrozonas, levels = niveles)
    }
  }

  if (length(macrozonas) != length(codigo_region)) {
    cli::cli_abort(
      "Largo de las clasificaciones no es el mismo que regiones entregadas"
    )
  }

  return(macrozonas)
}
