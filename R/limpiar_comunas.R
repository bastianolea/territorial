limpiar_comunas <- function(nombre_comuna) {
  # nombre_comuna <- c(territorial::comunas()[1:4], toupper(territorial::comunas()[5:8]), "coyiguay", "laflorida", "cerritos", "llay-llay", "asdf")

  # nombre_comuna <- c("Iquique", "Alto Hospicio", "Pozo Almonte", "Camiña", "COLCHANE", "HUARA", "PICA", "ANTOFAGASTA", "coyiguay", "laflorida", "cerritos", "llay-llay", "asdf", NA)

  resultado <- list()

  n_originales <- length(nombre_comuna)

  cli::cli_alert_info(
    "limpiando {n_originales} nombres de comuna{?s} ({dplyr::n_distinct(nombre_comuna)} son distintas)"
  )

  # encontrar correctas ----
  # detectar cuales son correctas y sacarlas
  evaluar_correctas <- nombre_comuna %in% territorial::comunas()
  comunas_correctas <- nombre_comuna[evaluar_correctas]
  comunas_incorrectas <- nombre_comuna[!evaluar_correctas]

  cli::cli_alert_success(
    "paso 1: de las {n_originales} comunas, {length(comunas_correctas)} son correctas: {redactar_comunas(comunas_correctas)}"
  )
  # versiones limpias:
  # comunas_correctas
  resultado$correctas <- comunas_correctas

  # encontrar con limpieza ----
  # bajar a minusculas y sacar tildes, comparar con correctas con mismo tratamiento
  # si coinciden, usar correctas

  # limpiar nombres de comunas oficiales
  comunas_oficiales_limpias <- limpiar_texto(comunas())

  evaluar_limpias_correctas <- limpiar_texto(comunas_incorrectas) %in%
    comunas_oficiales_limpias

  comunas_limpias_correctas <- comunas_incorrectas[evaluar_limpias_correctas]
  comunas_limpias_incorrectas <- comunas_incorrectas[!evaluar_limpias_correctas]

  # obener posición de las que coinciden al limpiarse
  coincidencias_limpias <- match(
    limpiar_texto(comunas_limpias_correctas),
    comunas_oficiales_limpias
  )
  # versiones limpias:
  # territorial::comunas()[coincidencias_limpias]
  resultado$limpieza <- territorial::comunas()[coincidencias_limpias]

  # encontrar por proximidad ----
  # las demás, aproximarlas con agrepl, retornar con advertencia
  coincidencia_parcial <- purrr::map(
    comunas_limpias_incorrectas,
    \(comuna) {
      resultado <- agrep(
        comuna,
        comunas_oficiales_limpias,
        value = TRUE,
        max.distance = 0.2,
        costs = list(insert = 4, delet = 5, subst = 3)
      )

      return(resultado[1])
    }
  ) |>
    purrr::list_c()

  # obener posición de las que coinciden al limpiarse
  coincidencias_proximidad <- match(
    coincidencia_parcial,
    comunas_oficiales_limpias
  )
  # versiones limpias:
  territorial::comunas()[coincidencias_proximidad]

  # seguir con las que quedan NA

  # si no, detectar nombre limpio en texto limpio (para coincidir con "municipio de" etc.
}
