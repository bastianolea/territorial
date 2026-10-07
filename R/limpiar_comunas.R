#' Limpieza de nombres de comunas de Chile a sus nombres oficiales
#'
#' A partir de un dataframe con una variable de nombres de comuna (idealmente `nombre_comuna`), o un vector de nombres de comunas, se realizan cuatro pasos de limpieza (confirmación de nombres correctos, limpieza de texto, limpieza de casos especiales, y detección por coincidencia) para retornar los nombres de comunas oficiales apropiados. Los nombres de comunas considerados _limpios_ son los que aparecen en [territorial::comunas()].
#'
#' Los nombres se limpian en cuatro pasos:
#' 1. Contrastando los nombres entregados con los nombres correctos de las comunas ([territorial::comunas()]), para ver si hay comunas bien escritas antes de proseguir con la limpieza de las demás.
#' 2. Se _limpian_ los nombres de comunas entregados, transformándolos a minúsculas y eliminando todo tipo de símbolos posibles, para dejar las palabras en sus formas más básicas (por ejemplo, `Ñuñoa` se vuelve `nunoa`). Luego, se aplica el mismo proceso a los nombres de comunas correctos ([territorial::comunas()]), y se hace un cruce entre ambos conjuntos de nombres: si los nombres coinciden, significa que se entregaron nombres de comunas escritos en mayúsculas o minúsculas, comunas sin tildes o con tildes extra, comunas sin símbolos especiales o si eñe, entre otras, y son reemplazadas con sus versiones correctas.
#' 3. Se buscan algunos casos especiales de comunas que son típicamente mal escritos, pero que son difíciles de identificar de manera automática, por ejemplo, cuando a la comuna de _Cabo de Hornos_ le ponen "Ex-Navarino".
#' 4. Si en los pasos anteriores quedaron comunas que no coincidieron (es decir, que sus problemas van más allá de tildes, mayúsculas o símbolos), se realiza una coincidencia parcial de textos o _fuzzy matching_ usando la función `base::agrepl()`, que utiliza el [algoritmo de distancia de Levenshtein](https://es.wikipedia.org/wiki/Distancia_de_Levenshtein) para encontrar las comunas correctamente escritas que más se parecen a las comunas entregadas. Se esta forma, se pueden encontrar las comunas correctamente escritas para casos de comunas con faltas de ortografía (`Pobidencia` en vez de `Providencia`), comunas sin espacios entre sus palabras (`laflorida` en vez de `La Florida`), y formas alternativas de escribir las comunas (`llay-llay` en vez de `Llaillay`). En todos estos casos se emite una alerta que indica la coincidencia encontrada, ya que al ser una aproxmación, no se garantiza que la coincidencia sea correcta. Puedes desactivar este paso poniendo `aproximar = FALSE`.
#' Finalmente, se muestra una tabla que describe el proceso de limpieza para su revisión (que puede ocultarse con `procedimiento = FALSE`, y se retornan las comunas correctas.
#'
#' @param datos Dataframe con una columna de nombres de comunas, o vector de nombres de comunas
#' @param variable Columna del dataframe con los nombres de comunas (se pasa sin comillas, p.ej. `comuna`). Si no se especifica, se asume `nombre_comuna`. Si se aplica a un vector, omitir este argumento.
#' @param procedimiento Mostrar una tabla con los resultados intermedios del proceso de limpieza. Elegir entre TRUE o FALSE, por defecto FALSE.
#' @param aproximar El paso de limpieza por aproximación y coincidencia de nombres puede entregar resultados inexactos. Cambiar a FALSE para omitir.
#'
#' @returns Si la entrada es un dataframe, retorna el dataframe con la columna de comunas reemplazada. Si es un vector, retorna un vector de nombres de comunas con correcciones aplicadas.
#' @export
#'
#' @examples
#' limpiar_comunas(c("COLCHANE", "Alto Ospicio", "probidencia", "huara", "laflorida", "cerritos", "llay-llay"))
#'
#' datos <- dplyr::tibble(
#'   nombre_comuna = c("PIRQUE", "El Monte", "Maipu",
#'                     "santiago", "prohibidencia", "CERRILLOS",
#'                     "San José De Maipo", "OHiggins"),
#'   valores = c(4, 6, 2, 8, 6, 3, 5, 8)
#'   )
#'
#' # si existe `nombre_comuna`, la función no requiere argumentos:
#' datos |>
#'   limpiar_comunas()
#'
#' # también puede usarse sobre un vector:
#' datos |>
#'   dplyr::mutate(nombre_corregido = limpiar_comunas(nombre_comuna))
limpiar_comunas <- function(
  datos,
  variable = NULL,
  aproximar = TRUE,
  procedimiento = FALSE
) {
  # la función funciona con tablas o vectores, y con o sin especificar la columna (se asume `nombre_comuna`)
  # si es dataframe, la columna se extrae como vector
  if (any(class(datos) %in% "data.frame")) {
    col_expr <- rlang::enquo(variable)

    # si no se especifica columna, asumir `nombre_comuna`
    if (rlang::quo_is_null(col_expr)) {
      col_expr <- rlang::sym("nombre_comuna")
    }

    # error si la columna exista no existe
    if (!rlang::as_name(col_expr) %in% names(datos)) {
      cli::cli_abort("La columna {.var {rlang::as_name(col_expr)}} no existe!")
    }

    # desagrupar tabla
    datos <- dplyr::ungroup(datos)

    # extraer columna como vector
    nombre_comuna <- dplyr::pull(datos, !!col_expr)

    # resultado_vec <- limpiar_comunas(
    #   nombre_comuna_vec,
    #   aproximar = aproximar,
    #   procedimiento = procedimiento
    # )
    # return(dplyr::mutate(datos, !!col_expr := resultado_vec))
    #
  } else if (!is.list(datos)) {
    # si se entrega vector (incluye factores), continuar como vector
    nombre_comuna <- datos
  } else {
    # error si no es dataframe ni vector
    cli::cli_abort("Datos de tipo incompatible, debe ser dataframe o vector")
  }

  # si los datos vienen en formato factor, advertir que se perderá el orden
  # de los niveles al convertirlos a texto
  if (is.factor(nombre_comuna)) {
    cli::cli_warn(
      "Los datos están en formato factor: se perderá el orden de los niveles al convertirlos a texto"
    )
  }

  # convertir a caracter antes de continuar con la limpieza
  nombre_comuna <- as.character(nombre_comuna)

  # nombre_comuna <- c(territorial::comunas()[1:4], toupper(territorial::comunas()[5:8]), "coyiguay", "laflorida", "cerritos", "llay-llay", "asdf")

  # nombre_comuna <- c("Iquique", "COLCHANE", "Alto Hospicio", "probidencia", "Pozo Almonte", "Camiña", "HUARA", "PICA", "ANTOFAGASTA", "laflorida", "cerritos", "llay-llay", "asdf", NA )

  # nombre_comuna <- c("O´HIGGINS", "TREHUACO")

  # nombre_comuna <- c("PORVENIR", "PORVENIR", "NATALES", "NATALES", "CABO DE HORNOS(EX-NAVARINO)", "AISEN")

  # empezar a registrar resultados
  # empezando por la versión original de los nombres
  comunas_originales <- dplyr::tibble(nombre_comuna)
  # los nombres originales se usarán al final para un left join

  resultados <- comunas_originales |>
    dplyr::distinct()

  cli::cli_alert_info(
    "Limpiando {nrow(comunas_originales)} nombre{?s} de comuna{?s} ({dplyr::n_distinct(nombre_comuna)} son distintas)"
  )

  # preprocesar ----
  # limpiar comunas eliminando símbolos y bajando a minúsculas
  resultados <- resultados |>
    dplyr::mutate(comunas_limpias = limpiar_texto(nombre_comuna)) |>
    dplyr::mutate(
      comunas_limpias = stringr::str_remove(
        comunas_limpias,
        "(ilustre|i|ilus) municipalidad|municipalidad de|municipalidad|municipio de|municipio|^muni|alcald(ía|e|esa) de"
      )
    ) |>
    dplyr::mutate(
      comunas_limpias = ifelse(
        comunas_limpias == "",
        NA_character_,
        comunas_limpias
      )
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
  cli::cli_alert("Paso 1: confirmar comunas correctas")
  if (length(comunas_correctas) == 0) {
    cli::cli_alert_info(
      "De las {nrow(resultados)} comunas distintas, ninguna tiene nombres 100% correctos. Los siguientes pasos intentarán la limpieza..."
    )
  } else {
    cli::cli_alert_info(
      "De las {nrow(resultados)} comunas distintas, {length(comunas_correctas)} ya eran correctas: {redactar_comunas(comunas_correctas)}"
    )
  }
  # cli::cli_par()

  # limpiar ----
  # bajar a minúsculas y sacar tildes, comparar con correctas con mismo tratamiento
  # si coinciden, usar correctas
  cli::cli_alert("Paso 2: coincidencias por limpieza de texto")

  # limpiar nombres de comunas oficiales
  comunas_oficiales_limpias <- limpiar_texto(comunas())

  # detectar comunas limpiadas
  resultados <- resultados |>
    dplyr::mutate(
      limpieza = dplyr::if_else(
        comunas_limpias %in% comunas_oficiales_limpias,
        territorial::comunas()[match(
          comunas_limpias,
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
  if (length(comunas_limpias) == 0) {
    cli::cli_alert_info(
      "No se limpiaron comunas por medio de limpieza de texto"
    )
  } else if (length(comunas_limpias) == 1) {
    cli::cli_alert_info(
      "Se limpió la comuna a partir de limpieza de texto: {redactar_comunas(comunas_limpias)}"
    )
  } else {
    cli::cli_alert_info(
      "A partir de la limpieza de texto, se limpiaron {length(comunas_limpias)} de {nrow(resultados)} comunas: {redactar_comunas(comunas_limpias)}"
    )
  }
  # cli::cli_par()

  # casos especiales ----
  cli::cli_alert("Paso 3: casos especiales")

  resultados <- resultados |>
    dplyr::mutate(
      especiales = dplyr::case_when(
        stringr::str_detect(comunas_limpias, "cabo.*hornos") ~ "Cabo de Hornos",
        stringr::str_detect(comunas_limpias, "navarino") ~ "Cabo de Hornos",
        stringr::str_detect(comunas_limpias, "coihaique") ~ "Coyhaique",
        stringr::str_detect(comunas_limpias, "ais(e|é)n") ~ "Aysén",
        stringr::str_detect(comunas_limpias, "la calera") ~ "Calera",
        stringr::str_detect(comunas_limpias, "puerto s(aa|a)vedra") ~ "Saavedra"
      )
    )

  # extraer limpiadas en este paso
  comunas_especiales <- resultados |>
    dplyr::select(especiales) |>
    na.omit() |>
    dplyr::pull()

  # informar
  if (length(comunas_especiales) == 0) {
    cli::cli_alert_info("No se encontraron casos especiales")
  } else {
    mensaje <- cli::pluralize(
      "Se encontr{?ó/aron} {length(comunas_especiales)} caso{?s} especial{?es}"
    )
    cli::cli_alert_info(
      "{mensaje}: {redactar_comunas(comunas_especiales)}"
    )
  }
  # cli::cli_par()

  # coincidir ----
  # las demás, aproximarlas con agrepl, retornar con advertencia
  cli::cli_alert("Paso 4: coincidencias aproximadas de texto")

  if (aproximar) {
    faltantes <- resultados |>
      dplyr::mutate(
        coincidir = dplyr::if_else(
          is.na(correctas) & is.na(limpieza) & is.na(especiales),
          comunas_limpias,
          NA
        )
      )
  } else {
    cli::cli_alert_info("Omitiendo limpieza por coincidencias aproximadas")
    faltantes <- resultados |>
      dplyr::mutate(
        coincidir = NA
      )
  }

  # determinar las comunas que se requieren coincidir
  comunas_coincidir <- faltantes |>
    dplyr::select(coincidir) |>
    na.omit() |>
    dplyr::pull()

  # browser()
  # por cada comuna faltante, buscar coincidencias aproximadas con agrep
  coincidencias <- purrr::map(
    faltantes$coincidir,
    \(comuna_faltante) {
      if (is.na(comuna_faltante)) {
        return(NA)
      }
      # comuna_faltante <- faltantes$coincidir[11]

      # comuna_faltante <- "rio urtado" # sale en 2
      # comuna_faltante <- "dasalanca" # sale en 2
      # comuna_faltante <- "csablanca" # sale en 2
      # comuna_faltante <- "as cabras" # sale en 2
      # comuna_faltante <- "isla de ascua" # sale en 2
      # comuna_faltante <- "a uiguera" # sale en 2
      # comuna_faltante <- "ichideguq" # sale en 2
      # comuna_faltante <- "zsablanca"
      # comuna_faltante <- "isn des maipo"

      resultado <-
        agrep(
          comuna_faltante,
          comunas_oficiales_limpias,
          value = TRUE,
          max.distance = 0.25,
          ignore.case = FALSE,
          fixed = TRUE,
          costs = list(ins = 1, del = 1, sub = 1)
        )

      # si no hay coincidencias, avisar
      if (length(resultado) == 0) {
        cli::cli_alert_warning(
          'No se encontró ninguna coincidencia para la comuna "{comuna_faltante}"'
        )
        return(NA)
      }

      # si hay más de una, elegir
      if (length(resultado) > 1) {
        cli::cli_alert_warning(
          'Se encontraron {length(resultado)} coincidencias para la comuna "{comuna_faltante}": {redactar_comunas(resultado)}'
        )

        # elegir resultado de menor distancia con el original
        distancia <- adist(
          comuna_faltante,
          resultado
        )

        distancia <- dplyr::tibble(
          resultado,
          distancia = as.vector(distancia)
        )

        resultado <- distancia |>
          dplyr::slice_min(distancia, with_ties = FALSE) |>
          dplyr::pull(resultado)
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

  # agregar a resultados
  resultados <- resultados |>
    dplyr::mutate(
      coincidencia = territorial::comunas()[coincidencias_proximidad]
    )

  # resultados |>
  #   print(n=60)

  # extraer limpiadas en este paso
  comunas_coincididas <- resultados |>
    dplyr::select(coincidencia) |>
    na.omit() |>
    dplyr::pull()

  # informar
  if (length(comunas_coincididas) == 1) {
    cli::cli_alert_info(
      "Se limpió la comuna por medio de coincidencia aproximada de texto: {redactar_comunas(comunas_coincididas)}"
    )
  } else if (length(comunas_coincididas) > 1) {
    cli::cli_alert_info(
      "Se limpiaron {length(comunas_coincididas)} de {length(comunas_coincidir)} comunas por medio de coincidencias aproximadas de texto: {redactar_comunas(comunas_coincididas)}"
    )
  } else {
    cli::cli_alert_warning(
      "No se limpiaron comunas como parte de este paso"
    )
  }
  # cli::cli_par()

  # terminar ----
  cli::cli_alert("Conclusión de limpieza de comunas")

  # separar las originales, y unir los resultados en una sola columna
  limpiado <- resultados |>
    dplyr::rename(original = nombre_comuna) |>
    dplyr::mutate(
      resultado = dplyr::coalesce(correctas, limpieza, especiales, coincidencia)
    )

  # extraer las limpiadas
  comunas_limpiadas <- limpiado |>
    dplyr::select(resultado) |>
    na.omit() |>
    dplyr::pull()

  porcentaje <- length(comunas_limpiadas) / nrow(resultados)

  # informar
  if (nrow(resultados) == 1) {
    cli::cli_alert_success(
      "La comuna se limpió correctamente"
    )
  } else {
    cli::cli_alert_success(
      "De las {nrow(resultados)} comunas distintas, se limpiaron {length(comunas_limpiadas)} en total ({round(porcentaje, 3) * 100}%)"
    )
  }

  # opcionalmente, mostrar una tabla con las columnas intermedias
  if (procedimiento) {
    cli::cli_alert_info("Mostrando proceso:")
    limpiado |>
      dplyr::distinct() |>
      dplyr::select(-comunas_limpias) |>
      print(n = Inf)
    # browser()
  }

  # volver a unir con las originales
  resultado <- comunas_originales |>
    dplyr::left_join(
      limpiado |>
        dplyr::filter(!is.na(resultado)) |>
        dplyr::select(nombre_comuna = original, resultado),
      by = "nombre_comuna"
    )

  if (length(resultado$resultado) != length(nombre_comuna)) {
    cli::cli_abort("El resultado no es del mismo largo que el input")
  }

  # si es dataframe, agregar columna; si es vector, retornar vector
  if (any(class(datos) %in% "data.frame")) {
    return(dplyr::mutate(datos, !!col_expr := resultado$resultado))
  } else {
    return(resultado$resultado)
  }
}
