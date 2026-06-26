#' Limpieza de nombres de comunas de Chile a sus nombres oficiales
#'
#' A partir de un vector de nombres de columnas, se realizan tres pasos de limpieza (confirmación de nombres correctas, limpieza de texto, detección por coincidencia) para retornar los nombres de comunas oficiales apropiados. Los nombres de comunas son los que aparecen en [territorial::comunas()].
#'
#' Los nombres son limpiados en tres pasos:
#' 1. Contrastando los nombres entregados con los nombres correctos de las comunas ([territorial::comunas()]), para ver si hay comunas bien escritas antes de proseguir con la limpieza de las demás.
#' 2. Se _limpian_ los nombres de comunas entregados, transformándolos a minúsculas y eliminando todo tipo de símbolos posibles, para dejar las palabras en sus formas más básicas (por ejemplo, `Ñuñoa` se vuelve `nunoa`). Luego, se aplica el mismo proceso a los nombres de comunas correctos ([territorial::comunas()]), y se hace un cruce entre ambos conjuntos de nombres: si los nombres coinciden, significa que se entregaron nombres de comunas escritos en mayúsculas o minúsculas, comunas sin tildes o con tildes extra, comunas sin símbolos especiales o si eñe, entre otras, y son reemplazadas con sus versiones correctas.
#' 3. Si en el paso anterior quedaron comunas que no coincidieron (es decir, que sus problemas van más allá de tildes, mayúsculas o símbolos), se realiza una coincidencia parcial de textos o _fuzzy matching_ usando la función `base::agrepl()`, que utiliza el [algoritmo de distancia de Levenshtein](https://es.wikipedia.org/wiki/Distancia_de_Levenshtein) para encontrar las comunas correctamente escritas que más se parecen a las comunas entregadas. Se esta forma, se pueden encontrar las comunas correctamente escritas para casos de comunas con faltas de ortografía (`Pobidencia` en vez de `Providencia`), comunas sin espacios entre sus palabras (`laflorida` en vez de `La Florida`), y formas alternativas de escribir las comunas (`llay-llay` en vez de `Llaillay`). En todos estos casos se emite una alerta que indica la coincidencia encontrada, ya que al ser una aproxmación, no se garantiza que la coincidencia sea correcta. Puedes desactivar este paso poniendo `aproximar = FALSE`.
#' Finalmente, se muestra una tabla que describe el proceso de limpieza para su revisión (que puede ocultarse con `mostrar_proceso = FALSE`, y se retornan las comunas correctas.
#'
#' @param nombre_comuna Vector de nombres de comunas
#' @param mostrar_proceso Por defecto, muestra una tabla con el resultado del proceso de limpieza. Cambiar a FALSE para ocultar.
#' @param aproximar El paso de limpieza por aproximación y coincidencia de nombres puede entregar resultados inexactos. Cambiar a FALSE para omitir.
#'
#' @returns Vector de nombres de comunas con correcciones aplicadas.
#' @export
#'
#' @examples
#' limpiar_comunas(c("COLCHANE", "Alto Ospicio", "probidencia", "huara", "laflorida", "cerritos", "llay-llay"))
#'
#' datos <- dplyr::tibble(
#'   nombre_comuna = c("PIRQUE", "El Monte", "Maipu", "santiago", "prohibidencia", "CERRILLOS", "San José De Maipo", "OHiggins"),
#'   valores = c(4, 6, 2, 8, 6, 3, 5, 8)
#'   )
#'
#' datos |>
#'   dplyr::mutate(nombre_corregido = limpiar_comunas(nombre_comuna))
limpiar_comunas <- function(
  nombre_comuna,
  aproximar = TRUE,
  mostrar_proceso = TRUE
) {
  # nombre_comuna <- c(territorial::comunas()[1:4], toupper(territorial::comunas()[5:8]), "coyiguay", "laflorida", "cerritos", "llay-llay", "asdf")

  # nombre_comuna <- c("Iquique", "COLCHANE", "Alto Hospicio", "probidencia", "Pozo Almonte", "Camiña", "HUARA", "PICA", "ANTOFAGASTA", "laflorida", "cerritos", "llay-llay", "asdf", NA )

  # si no hay en un paso, mostrar mensaje distinto
  # al redactar, si son demasiadas, truncar
  # O´HIGGINS, TREHUACO
  # nombre_comuna <- c("O´HIGGINS", "TREHUACO")

  # empezar a registrar resultados
  resultados <- dplyr::tibble(nombre_comuna)

  cli::cli_alert_info(
    "Limpiando {nrow(resultados)} nombres de comuna{?s} ({dplyr::n_distinct(nombre_comuna)} son distintas)"
  )

  # correctas ----

  # buscar si son equivalentes a las comunas oficiales
  resultados <- resultados |>
    dplyr::mutate(
      correctas = dplyr::if_else(
        nombre_comuna %in% territorial::comunas(),
        nombre_comuna,
        NA
      )
    )

  # extraer limpiadas en este paso
  comunas_correctas <- resultados |>
    dplyr::select(correctas) |>
    na.omit() |>
    dplyr::pull()

  # informar
  cli::cli_h3("Paso 1: confirmar comunas correctas")
  if (length(comunas_correctas) == 0) {
    cli::cli_alert_info(
      "De las {nrow(resultados)} comunas, ninguna tiene nombres 100% correctos. Los siguientes pasos intentarán la limpieza"
    )
  } else {
    cli::cli_alert_info(
      "De las {nrow(resultados)} comunas, {length(comunas_correctas)} ya eran correctas: {redactar_comunas(comunas_correctas)}"
    )
  }
  cli::cli_par()

  # limpiar ----
  # bajar a minusculas y sacar tildes, comparar con correctas con mismo tratamiento
  # si coinciden, usar correctas
  cli::cli_h3("Paso 2: coincidencias por limpieza de texto")

  # limpiar nombres de comunas oficiales
  comunas_oficiales_limpias <- limpiar_texto(comunas())

  # detectar comunas limpiadas
  resultados <- resultados |>
    dplyr::mutate(
      limpieza = dplyr::if_else(
        # !is.na(correctas) ~ NA_character_,
        limpiar_texto(nombre_comuna) %in% comunas_oficiales_limpias,
        territorial::comunas()[match(
          limpiar_texto(nombre_comuna),
          comunas_oficiales_limpias
        )],
        NA
      )
    )

  # extraer limpiadas en este paso
  comunas_limpias <- resultados |>
    dplyr::select(limpieza) |>
    na.omit() |>
    dplyr::pull()

  # informar
  cli::cli_alert_info(
    "A partir de la limpieza de texto, se limpiaron {length(comunas_limpias)} de {nrow(resultados)} comunas: {redactar_comunas(comunas_limpias)}"
  )
  cli::cli_par()

  # coincidir ----
  # las demás, aproximarlas con agrepl, retornar con advertencia
  cli::cli_h3("Paso 3: coincidencias aproximadas de texto")

  if (aproximar) {
    faltantes <- resultados |>
      dplyr::mutate(
        coincidir = dplyr::if_else(
          is.na(correctas) & is.na(limpieza),
          nombre_comuna,
          NA
        )
      ) |>
      #limpiar comuna
      dplyr::mutate(coincidir = limpiar_texto(coincidir))
  } else {
    cli::cli_alert_info("Omitiendo limpieza por coincidencias aproximadas")
    faltantes <- resultados |>
      dplyr::mutate(
        coincidir = NA
      )
  }

  comunas_coincidir <- faltantes |>
    dplyr::select(coincidir) |>
    na.omit() |>
    dplyr::pull()

  coincidencias <- purrr::map(
    faltantes$coincidir,
    \(comuna_faltante) {
      if (is.na(comuna_faltante)) {
        return(NA)
      }
      # comuna_faltante <- faltantes$coincidir[10]

      resultado <-
        agrep(
          comuna_faltante,
          comunas_oficiales_limpias,
          value = TRUE,
          max.distance = 0.25,
          ignore.case = FALSE,
          fixed = TRUE,
          costs = list(ins = 1, del = 1, sub = 1)
        ) |>
        rev()

      if (length(resultado) == 0) {
        cli::cli_alert_warning(
          "alerta, no se encontró ninguna coincidencia para la comuna `{comuna_faltante}`"
        )
      }

      if (length(resultado) > 1) {
        cli::cli_alert_warning(
          "alerta, se encontraron más de una coincidencia para la comuna `{comuna_faltante}`: {redactar_comunas(resultado)}"
        )
      }

      return(resultado[1])
    }
  ) |>
    purrr::list_c()

  # obtener posición de las que coinciden al limpiarse
  coincidencias_proximidad <- match(
    coincidencias,
    comunas_oficiales_limpias
  )

  resultados <- resultados |>
    dplyr::mutate(
      coincidencia = territorial::comunas()[coincidencias_proximidad]
    )

  # extraer limpiadas en este paso
  comunas_coincididas <- resultados |>
    dplyr::select(coincidencia) |>
    na.omit() |>
    dplyr::pull()

  # informar
  if (length(comunas_coincididas) > 0) {
    cli::cli_alert_info(
      "Se limpiaron {length(comunas_coincididas)} de {length(comunas_coincidir)} comunas por medio de coincidencias aproximadas de texto: {redactar_comunas(comunas_coincididas)}"
    )
  } else {
    cli::cli_alert_warning(
      "No se limpiaron comunas como parte de este paso"
    )
  }
  cli::cli_par()

  # terminar ----
  cli::cli_h3("Conclusión de limpieza de comunas")

  limpiado <- resultados |>
    dplyr::rename(original = nombre_comuna) |>
    dplyr::mutate(
      resultado = dplyr::coalesce(correctas, limpieza, coincidencia)
    )

  comunas_limpiadas <- limpiado |>
    dplyr::select(resultado) |>
    na.omit() |>
    dplyr::pull()

  porcentaje <- length(comunas_limpiadas) / nrow(resultados)

  # informar
  cli::cli_alert_success(
    "De las {nrow(resultados)} comunas, se limpiaron {length(comunas_limpiadas)} en total ({round(porcentaje, 2) * 100}%)"
  )

  if (mostrar_proceso) {
    cli::cli_alert_info("Mostrando proceso:")
    print(limpiado, n = Inf)
  }

  return(limpiado$resultado)
}
