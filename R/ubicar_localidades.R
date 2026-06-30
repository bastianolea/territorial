#' Ubicar localidades en la comuna que les corresponde
#'
#' Al igual que [`ubicar_comunas()`], para un vector de nombres de localidades, retorna las comunas donde se ubican dichas localidades. Las localidades son zonas geográficas, grupos de viviendas o asentamientos más pequeños que una comuna y que poseen un nombre propio, pero que no son entidades administrativas (para más información, ver la tabla [`territorial::localidades`]).
#'
#' Al buscar las localidades, primero busca por coincidencias exactas de nombres y, si existen más de una con el mismo nombre, retorna la localidad con mayor población (según el estudio de Localidades Aisladas 2021 de Subdere). Si no se encuentra una localidad exacta, se buscan por coincidencia inexacta.
#'
#' @param nombre_localidad Nombres de localidades, idealmente como aparecen en [territorial::localidades].
#' @param nombre_region Opcionalmente, una región para circunscribir la búsqueda y así retornar mejores resultados.
#' @param mostrar_proceso Por defecto, muestra una tabla con el resultado del proceso de limpieza. Cambiar a FALSE para ocultar.
#'
#' @returns Vector con nombres de comunas correspondientes
#' @export
#'
#' @examples
#' ubicar_localidades("La Boca")
#'
#' ubicar_localidades(c("Chada", "La Dormida", "Mallarauco"))
#'
#' ubicar_localidades("Alfalfal")
#'
#' # cuando se conoce el nombre de la región, se pueden mejorar los resultados:
#' ubicar_localidades("Alfalfal", nombre_region = "Metropolitana de Santiago")
ubicar_localidades <- function(
  nombre_localidad = NULL,
  nombre_region = NULL,
  mostrar_proceso = TRUE
) {
  localidades <- territorial::localidades |>
    territorial::contextualizar(codigo_comuna) |>
    suppressMessages() |>
    dplyr::select(-dplyr::ends_with("provincia"))

  nombre_region <- ifelse(is.null(nombre_region), NA, nombre_region)

  resultados <- purrr::map2(
    nombre_localidad,
    nombre_region,
    \(nombre_localidad, .nombre_region) {
      # nombre_localidad = "La Boca"
      # nombre_localidad = c("La Boca", "Pomaire")

      if (!is.na(nombre_region)) {
        localidades <- localidades |>
          dplyr::filter(nombre_region == .nombre_region)
      }

      localidades_exacta <- localidades |>
        dplyr::filter(tolower(localidad) %in% tolower(nombre_localidad)) |>
        dplyr::arrange(dplyr::desc(habitantes))

      cli::cli_alert_info("Buscando localidad '{nombre_localidad}'")

      # si se encuentran localidades exactas
      if (nrow(localidades_exacta) > 0) {
        cli::cli_alert_warning(
          "Se encontr{?ó/aron} {nrow(localidades_exacta)} localidad{?es} coincidente{?s}:"
        )

        resultados_localidades <- localidades_exacta
      } else {
        # si no se encontraron exactas
        cli::cli_alert_warning(
          "No se encontraron localidades coincidentes para '{nombre_localidad}'; buscando por coincidencia inexacta..."
        )

        # buscar localidades
        localidades_inexacta <- localidades |>
          dplyr::filter(
            tolower(localidad) %in%
              agrep(
                pattern = tolower(nombre_localidad),
                tolower(localidades$localidad),
                max.distance = 0.1,
                value = TRUE,
                costs = list(
                  insert = 1,
                  delet = 2,
                  subst = 2
                )
              )
          ) |>
          dplyr::arrange(dplyr::desc(habitantes))

        if (nrow(localidades_inexacta) > 0) {
          cli::cli_alert_warning(
            "Se encontr{?ó/aron} {nrow(localidades_exacta)} localidad{?es} coincidente{?s} por búsqueda inexacta:"
          )

          resultados_localidades <- localidades_inexacta
        } else {
          cli::cli_abort("Sin resultados")
        }
      }

      if (mostrar_proceso) {
        # mostrar resultados
        resultados_localidades |>
          dplyr::select(-dplyr::where(is.numeric)) |>
          print()
      }

      localidad <- resultados_localidades[1, ]

      intro <- ifelse(
        nrow(resultados_localidades) > 1,
        "Retornando la primera localidad:",
        "Localidad encontrada:"
      )

      cli::cli_alert_info(
        "{intro} {localidad$localidad}, ubicada en la comuna de {localidad$nombre_comuna}, {redactar_region(localidad$nombre_region)}"
      )

      return(localidad$nombre_comuna)
    }
  )

  return(unlist(resultados))
}
