#' Limpieza de nombres de regiones de Chile a sus nombres oficiales
#'
#' A partir de un dataframe con una variable de nombres de región (idealmente `nombre_region`), o un vector de nombres de regiones, se realizan cuatro pasos de limpieza (confirmación de nombres correctos, limpieza de texto, limpieza de casos especiales, y detección por coincidencia) para retornar los nombres de regiones oficiales apropiados. Los nombres de regiones considerados _limpios_ son los que aparecen en [territorial::regiones()], incluyendo también sus versiones cortas (ver [territorial::acortar_regiones()]); por ejemplo, tanto "Aysén" como "Aysén del General Carlos Ibáñez del Campo" se consideran nombres limpios.
#'
#' Los nombres se limpian en cuatro pasos:
#' 1. Contrastando los nombres entregados con los nombres correctos de las regiones ([territorial::regiones()]) y sus versiones cortas ([territorial::acortar_regiones()]), para ver si hay regiones bien escritas antes de proseguir con la limpieza de las demás.
#' 2. Se _limpian_ los nombres de regiones entregados, transformándolos a minúsculas y eliminando todo tipo de símbolos posibles, para dejar las palabras en sus formas más básicas (por ejemplo, `Ñuble` se vuelve `nuble`). Luego, se aplica el mismo proceso a los nombres de regiones correctos (largos y cortos), y se hace un cruce entre ambos conjuntos de nombres: si los nombres coinciden, significa que se entregaron nombres de regiones escritos en mayúsculas o minúsculas, regiones sin tildes o con tildes extra, regiones sin símbolos especiales, entre otras, y son reemplazadas con sus versiones correctas.
#' 3. Se buscan algunos casos especiales de regiones que son típicamente mal escritos, pero que son difíciles de identificar de manera automática, por ejemplo, cuando a la Región Metropolitana le dicen "RM" o "Santiago", o cuando a la región de Aysén le ponen "Aisén" (con i latina).
#' 4. Si en los pasos anteriores quedaron regiones que no coincidieron (es decir, que sus problemas van más allá de tildes, mayúsculas o símbolos), se realiza una coincidencia parcial de textos o _fuzzy matching_ usando la función `base::agrepl()`, que utiliza el [algoritmo de distancia de Levenshtein](https://es.wikipedia.org/wiki/Distancia_de_Levenshtein) para encontrar las regiones correctamente escritas que más se parecen a las regiones entregadas. En todos estos casos se emite una alerta que indica la coincidencia encontrada, ya que al ser una aproximación, no se garantiza que la coincidencia sea correcta. Puedes desactivar este paso poniendo `aproximar = FALSE`.
#' Finalmente, se muestra una tabla que describe el proceso de limpieza para su revisión (que puede ocultarse con `procedimiento = FALSE`), y se retornan los nombres de regiones oficiales (en su versión larga).
#'
#' @param datos Dataframe con una columna de nombres de regiones, o vector de nombres de regiones
#' @param variable Columna del dataframe con los nombres de regiones (se pasa sin comillas, p.ej. `region`). Si no se especifica, se asume `nombre_region`. Si se aplica a un vector, omitir este argumento.
#' @param procedimiento Mostrar una tabla con los resultados intermedios del proceso de limpieza. Elegir entre TRUE o FALSE, por defecto FALSE.
#' @param aproximar El paso de limpieza por aproximación y coincidencia de nombres puede entregar resultados inexactos. Cambiar a FALSE para omitir.
#'
#' @returns Si la entrada es un dataframe, retorna el dataframe con la columna de regiones reemplazada. Si es un vector, retorna un vector de nombres de regiones oficiales (en su versión larga) con correcciones aplicadas.
#' @export
#'
#' @examples
#' limpiar_regiones(c("MAULE", "biobio", "la araucania", "Los rios", "RM", "aisen"))
#'
#' datos <- dplyr::tibble(
#'   nombre_region = c("TARAPACA", "Coquimbo", "valparaiso",
#'                     "santiago", "ohiggins", "NUBLE"),
#'   valores = c(4, 6, 2, 8, 6, 3)
#'   )
#'
#' # si existe `nombre_region`, la función no requiere argumentos:
#' datos |>
#'   limpiar_regiones()
#'
#' # también puede usarse sobre un vector:
#' datos |>
#'   dplyr::mutate(nombre_corregido = limpiar_regiones(nombre_region))
limpiar_regiones <- function(
  datos,
  variable = NULL,
  aproximar = TRUE,
  procedimiento = FALSE
) {
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
  # de los niveles al convertirlos a texto
  if (is.factor(nombre_region)) {
    cli::cli_warn(
      "Los datos están en formato factor: se perderá el orden de los niveles al convertirlos a texto"
    )
  }

  # convertir a caracter antes de continuar con la limpieza
  nombre_region <- as.character(nombre_region)

  # regiones oficiales, en su versión larga y corta
  regiones_oficiales <- regiones()
  regiones_cortas <- acortar_regiones(regiones_oficiales)
  # a las versiones cortas se les asocia su versión larga correspondiente
  regiones_validas <- c(regiones_oficiales, regiones_cortas)
  regiones_resultado <- c(regiones_oficiales, regiones_oficiales)

  # empezar a registrar resultados
  # empezando por la versión original de los nombres
  regiones_originales <- dplyr::tibble(nombre_region)
  # los nombres originales se usarán al final para un left join

  resultados <- regiones_originales |>
    dplyr::distinct()

  cli::cli_alert_info(
    "Limpiando {nrow(regiones_originales)} nombre{?s} de región ({dplyr::n_distinct(nombre_region)} son distintos)"
  )

  # preprocesar ----
  # limpiar regiones eliminando símbolos y bajando a minúsculas
  resultados <- resultados |>
    dplyr::mutate(regiones_limpias = limpiar_texto(nombre_region)) |>
    dplyr::mutate(
      regiones_limpias = stringr::str_remove(
        regiones_limpias,
        "^region (de|del|de la|de los)?\\s*"
      )
    ) |>
    dplyr::mutate(
      regiones_limpias = ifelse(
        regiones_limpias == "",
        NA_character_,
        regiones_limpias
      )
    )

  # correctas ----
  # buscar si son equivalentes a las regiones oficiales (largas o cortas)
  resultados <- resultados |>
    dplyr::mutate(
      correctas = dplyr::if_else(
        nombre_region %in% regiones_validas,
        regiones_resultado[match(nombre_region, regiones_validas)],
        NA
      )
    )

  # extraer limpiadas en este paso
  regiones_correctas <- resultados |>
    dplyr::select(correctas) |>
    na.omit() |>
    dplyr::pull()

  # informar
  cli::cli_alert("Paso 1: confirmar regiones correctas")
  if (length(regiones_correctas) == 0) {
    cli::cli_alert_info(
      "De las {nrow(resultados)} regiones distintas, ninguna tiene nombres 100% correctos. Los siguientes pasos intentarán la limpieza"
    )
  } else {
    cli::cli_alert_info(
      "De las {nrow(resultados)} regiones distintas, {length(regiones_correctas)} ya eran correctas: {redactar_comunas(regiones_correctas, largo = 0)}"
    )
  }

  # limpiar ----
  # bajar a minúsculas y sacar tildes, comparar con correctas con mismo tratamiento
  # si coinciden, usar correctas
  cli::cli_alert("Paso 2: coincidencias por limpieza de texto")

  # limpiar nombres de regiones oficiales (largos y cortos)
  regiones_oficiales_limpias <- limpiar_texto(regiones_validas)

  # detectar regiones limpiadas
  resultados <- resultados |>
    dplyr::mutate(
      limpieza = dplyr::if_else(
        regiones_limpias %in% regiones_oficiales_limpias,
        regiones_resultado[match(
          regiones_limpias,
          regiones_oficiales_limpias
        )],
        NA
      )
    )

  # extraer limpiadas en este paso
  regiones_limpias_paso2 <- resultados |>
    dplyr::select(limpieza) |>
    na.omit() |>
    dplyr::pull()

  # informar
  cli::cli_alert_info(
    "A partir de la limpieza de texto, se limpiaron {length(regiones_limpias_paso2)} de {nrow(resultados)} regiones: {redactar_comunas(regiones_limpias_paso2, largo = 0)}"
  )

  # casos especiales ----
  cli::cli_alert("Paso 3: casos especiales")

  resultados <- resultados |>
    dplyr::mutate(
      especiales = dplyr::case_when(
        stringr::str_detect(regiones_limpias, "^rm$") ~
          "Metropolitana de Santiago",
        stringr::str_detect(regiones_limpias, "^santiago$") ~
          "Metropolitana de Santiago",
        stringr::str_detect(regiones_limpias, "ais(e|é)n") ~
          "Aysén del General Carlos Ibáñez del Campo",
        stringr::str_detect(regiones_limpias, "iba(n|ñ)ez") ~
          "Aysén del General Carlos Ibáñez del Campo",
        stringr::str_detect(regiones_limpias, "^bio\\s*bio$") ~ "Biobío",
        stringr::str_detect(regiones_limpias, "^arica$") ~
          "Arica y Parinacota",
        stringr::str_detect(regiones_limpias, "^parinacota$") ~
          "Arica y Parinacota",
        stringr::str_detect(regiones_limpias, "antartica") ~
          "Magallanes y de la Antártica Chilena",
        stringr::str_detect(regiones_limpias, "^araucania$") ~
          "La Araucanía",
        stringr::str_detect(regiones_limpias, "^rios$") ~ "Los Ríos",
        stringr::str_detect(regiones_limpias, "^lagos$") ~ "Los Lagos"
      )
    )

  # extraer limpiadas en este paso
  regiones_especiales <- resultados |>
    dplyr::select(especiales) |>
    na.omit() |>
    dplyr::pull()

  # informar
  mensaje <- cli::pluralize(
    "Se encontr{?ó/aron} {length(regiones_especiales)} caso{?s} especial{?es}"
  )
  cli::cli_alert_info(
    "{mensaje}: {redactar_comunas(regiones_especiales, largo = 0)}"
  )

  # coincidir ----
  # las demás, aproximarlas con agrepl, retornar con advertencia
  cli::cli_alert("Paso 4: coincidencias aproximadas de texto")

  if (aproximar) {
    faltantes <- resultados |>
      dplyr::mutate(
        coincidir = dplyr::if_else(
          is.na(correctas) & is.na(limpieza) & is.na(especiales),
          regiones_limpias,
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

  # determinar las regiones que se requieren coincidir
  regiones_coincidir <- faltantes |>
    dplyr::select(coincidir) |>
    na.omit() |>
    dplyr::pull()

  # por cada región faltante, buscar coincidencias aproximadas con agrep
  coincidencias <- purrr::map(
    faltantes$coincidir,
    \(region_faltante) {
      if (is.na(region_faltante)) {
        return(NA)
      }

      resultado <-
        agrep(
          region_faltante,
          regiones_oficiales_limpias,
          value = TRUE,
          max.distance = 0.25,
          ignore.case = FALSE,
          fixed = TRUE,
          costs = list(ins = 1, del = 1, sub = 1)
        ) |>
        rev()

      if (length(resultado) == 0) {
        cli::cli_alert_warning(
          "No se encontró ninguna coincidencia para la región `{region_faltante}`"
        )
      }

      if (length(resultado) > 1) {
        cli::cli_alert_warning(
          "Se encontraron {length(resultado)} coincidencias para la región `{region_faltante}`: {redactar_comunas(resultado, largo = 0)}"
        )

        # elegir resultado de menor distancia con el original
        distancia <- adist(
          region_faltante,
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
    regiones_oficiales_limpias
  )

  # agregar a resultados
  resultados <- resultados |>
    dplyr::mutate(
      coincidencia = regiones_resultado[coincidencias_proximidad]
    )

  # extraer limpiadas en este paso
  regiones_coincididas <- resultados |>
    dplyr::select(coincidencia) |>
    na.omit() |>
    dplyr::pull()

  # informar
  if (length(regiones_coincididas) > 0) {
    cli::cli_alert_info(
      "Se limpiaron {length(regiones_coincididas)} de {length(regiones_coincidir)} regiones por medio de coincidencias aproximadas de texto: {redactar_comunas(regiones_coincididas, largo = 0)}"
    )
  } else {
    cli::cli_alert_warning(
      "No se limpiaron regiones como parte de este paso"
    )
  }

  # terminar ----
  cli::cli_alert("Conclusión de limpieza de regiones")

  # separar las originales, y unir los resultados en una sola columna
  limpiado <- resultados |>
    dplyr::rename(original = nombre_region) |>
    dplyr::mutate(
      resultado = dplyr::coalesce(correctas, limpieza, especiales, coincidencia)
    )

  # extraer las limpiadas
  regiones_limpiadas <- limpiado |>
    dplyr::select(resultado) |>
    na.omit() |>
    dplyr::pull()

  porcentaje <- length(regiones_limpiadas) / nrow(resultados)

  # informar
  cli::cli_alert_success(
    "De las {nrow(resultados)} regiones distintas, se limpiaron {length(regiones_limpiadas)} en total ({round(porcentaje, 3) * 100}%)"
  )

  # opcionalmente, mostrar una tabla con las columnas intermedias
  if (procedimiento) {
    cli::cli_alert_info("Mostrando proceso:")
    limpiado |>
      dplyr::distinct() |>
      dplyr::select(-regiones_limpias) |>
      print(n = Inf)
  }

  # volver a unir con las originales
  resultado <- regiones_originales |>
    dplyr::left_join(
      limpiado |>
        dplyr::filter(!is.na(resultado)) |>
        dplyr::select(nombre_region = original, resultado),
      by = "nombre_region"
    )

  if (length(resultado$resultado) != length(nombre_region)) {
    cli::cli_abort("El resultado no es del mismo largo que el input")
  }

  # si es dataframe, agregar columna; si es vector, retornar vector
  if (any(class(datos) %in% "data.frame")) {
    return(dplyr::mutate(datos, !!col_expr := resultado$resultado))
  } else {
    return(resultado$resultado)
  }
}
