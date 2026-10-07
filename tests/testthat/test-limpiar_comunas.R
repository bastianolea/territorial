test_that("prueba de limpieza de comunas 1", {
  expect_equal(
    limpiar_comunas(
      c("CERRILLOS", "la florida", "ñunoa", "nunoa")
    ),
    c("Cerrillos", "La Florida", "Ñuñoa", "Ñuñoa")
  )
}) |>
  suppressMessages()

test_that("prueba de limpieza de comunas 2", {
  expect_equal(
    limpiar_comunas(
      c(
        "Iquique",
        "COLCHANE",
        "Alto Hospicio",
        "probidencia",
        "Pozo Almonte",
        "Camiña",
        "HUARA",
        "PICA",
        "ANTOFAGASTA",
        "cerritos",
        "llay-llay",
        "asdf",
        NA
      )
    ),
    c(
      "Iquique",
      "Colchane",
      "Alto Hospicio",
      "Providencia",
      "Pozo Almonte",
      "Camiña",
      "Huara",
      "Pica",
      "Antofagasta",
      "Cerrillos",
      "Llaillay",
      NA,
      NA
    )
  )
}) |>
  suppressMessages()


test_that("prueba de limpieza de comunas 3, antes no se la podía", {
  expect_equal(
    limpiar_comunas(
      c("La Florida", "Quirigue"),
      procedimiento = FALSE
    ) |>
      suppressMessages(),
    c("La Florida", "Quirihue")
  )
})


test_that("prueba de limpieza de comunas 4, antes no se la podía", {
  expect_equal(
    limpiar_comunas(
      c("O´HIGGINS", "TREGUACO"),
      procedimiento = FALSE
    ) |>
      suppressMessages(),
    c("O'Higgins", "Trehuaco")
  )
})

test_that("prueba de limpieza de comunas desde datos de prueba 1", {
  expect_all_false(
    {
      datos <- read.csv(test_path("testdata/test_digitalizacion_municipal.csv"))

      datos_limpios <- datos |>
        dplyr::tibble() |>
        dplyr::mutate(
          nombre_comuna = limpiar_comunas(municipio, procedimiento = FALSE)
        ) |>
        suppressMessages()

      is.na(datos_limpios$nombre_comuna)
    }
  )
})


test_that("prueba de limpieza de comunas 5, cabo de hornos", {
  expect_equal(
    limpiar_comunas(
      c("CABO DE HORNOS (EX-NAVARINO)"),
      procedimiento = FALSE
    ),
    c("Cabo de Hornos")
  )
}) |>
  suppressMessages()


test_that("prueba de limpieza de comunas 6, casos especiales", {
  expect_equal(
    limpiar_comunas(
      c("coihaique", "la calera", "aisén"),
      procedimiento = FALSE
    ),
    c("Coyhaique", "Calera", "Aysén")
  )
}) |>
  suppressMessages()

test_that("prueba de limpieza de comunas donde la limpieza habría dejado texto de 0 caracteres", {
  expect_equal(
    limpiar_comunas(
      c("658145002"),
      procedimiento = FALSE
    ),
    NA_character_
  )
}) |>
  suppressMessages()

test_that("limpiar comunas sin especificar columna retorna dataframe", {
  resultado <- territorios |>
    limpiar_comunas() |>
    suppressMessages()

  expect_s3_class(resultado, "data.frame")
})

test_that("limpiar comunas desde dataframe especificando columna retorna dataframe", {
  resultado <- territorios |>
    limpiar_comunas(nombre_comuna) |>
    suppressMessages()

  expect_s3_class(resultado, "data.frame")
})

test_that("limpiar comunas desde vector retorna vector", {
  resultado <- territorios$nombre_comuna |>
    limpiar_comunas() |>
    suppressMessages()

  expect_true(is.vector(resultado))
})


test_that("limpiar comunas no aplica a listas", {
  expect_error(
    list(comunas = c(1, 2, 3)) |>
      limpiar_comunas()
  )
})

test_that(
  "limpiar comunas con columna que no existe",
  expect_error(
    territorios |> limpiar_comunas(nombre_mapache)
  )
) |>
  suppressMessages()

test_that(
  "limpiar comunas sin especificar columna, y no existe nombre_comuna",
  expect_error(
    territorios |>
      dplyr::rename(nombres = nombre_comuna) |>
      limpiar_comunas()
  )
) |>
  suppressMessages()


test_that("limpiar comunas con aproximar = FALSE no rescata por fuzzy matching", {
  # "cerritos" solo coincide con "Cerrillos" vía fuzzy; sin aproximar debe quedar NA
  expect_equal(
    limpiar_comunas(c("Cerrillos", "cerritos"), aproximar = FALSE) |>
      suppressMessages(),
    c("Cerrillos", NA_character_)
  )
})

test_that("limpiar comunas con input todo-NA no falla", {
  expect_no_error(
    limpiar_comunas(c(NA, NA)) |>
      suppressMessages()
  )
})

test_that("limpiar comunas desde dataframe limpia efectivamente el contenido", {
  datos_sucios <- dplyr::tibble(
    nombre_comuna = c("CERRILLOS", "la florida"),
    valor = c(1, 2)
  )
  resultado <- datos_sucios |>
    limpiar_comunas() |>
    suppressMessages()

  expect_equal(resultado$nombre_comuna, c("Cerrillos", "La Florida"))
})

test_that("limpiar comunas desde dataframe con columna personalizada", {
  datos_sucios <- dplyr::tibble(
    municipio = c("CERRILLOS", "la florida"),
    valor = c(1, 2)
  )
  resultado <- datos_sucios |>
    limpiar_comunas(municipio) |>
    suppressMessages()

  expect_equal(resultado$municipio, c("Cerrillos", "La Florida"))
})

# factores ----
test_that("limpiar comunas funciona con vectores de tipo factor y advierte", {
  nombres <- factor(c("CERRILLOS", "la florida"))

  expect_warning(
    resultado <- limpiar_comunas(nombres) |> suppressMessages(),
    "formato factor"
  )
  expect_type(resultado, "character")
  expect_equal(resultado, c("Cerrillos", "La Florida"))
})

test_that("limpiar comunas funciona con columnas factor en dataframes y advierte", {
  datos <- dplyr::tibble(nombre_comuna = factor(c("CERRILLOS", "la florida")))

  expect_warning(
    resultado <- limpiar_comunas(datos) |> suppressMessages(),
    "formato factor"
  )
  expect_type(resultado$nombre_comuna, "character")
  expect_equal(resultado$nombre_comuna, c("Cerrillos", "La Florida"))
})


# calidad ----
test_that("prueba calidad de limpieza de comunas: minúscula sin símbolos", {
  expect_message(
    comunas() |>
      limpiar_texto() |>
      limpiar_comunas(),
    regexp = "100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de comunas: mayúsculas sin símbolos", {
  expect_message(
    comunas() |>
      limpiar_texto() |>
      toupper() |>
      limpiar_comunas(),
    regexp = "100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de comunas: guiones bajo en vez de espacios", {
  expect_message(
    comunas() |>
      limpiar_texto() |>
      stringr::str_replace_all(" ", "_") |>
      limpiar_comunas(),
    regexp = "100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de comunas: espaciados extra", {
  expect_message(
    territorios |>
      dplyr::select(nombre_comuna) |>
      messy::add_whitespace() |>
      limpiar_comunas(),
    regexp = "100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de comunas: caracteres especiales, nivel 1", {
  expect_message(
    territorios |>
      dplyr::select(nombre_comuna) |>
      messy::add_special_chars(messiness = 0.1) |>
      limpiar_comunas(),
    regexp = "100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de comunas: caracteres especiales, nivel 2", {
  expect_message(
    territorios |>
      dplyr::select(nombre_comuna) |>
      messy::add_special_chars(messiness = 0.3) |>
      limpiar_comunas(),
    regexp = "[95-99].[1-9]%|100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de comunas: mayúsculas y símbolos", {
  expect_message(
    territorios |>
      dplyr::select(nombre_comuna) |>
      messy::change_case() |>
      messy::add_special_chars() |>
      limpiar_comunas(),
    regexp = "100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de comunas: mayúsculas, espacios y símbolos", {
  expect_message(
    territorios |>
      dplyr::select(nombre_comuna) |>
      messy::change_case() |>
      messy::add_whitespace() |>
      messy::add_special_chars() |>
      limpiar_comunas(),
    regexp = "[95-99].[1-9]%|100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de comunas: caracteres faltantes", {
  expect_message(
    comunas() |>
      eliminar_texto(porcentaje = 0.1) |>
      limpiar_comunas(),
    regexp = "100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de comunas: caracteres faltantes, nivel 2", {
  expect_message(
    comunas() |>
      eliminar_texto(porcentaje = 0.3) |>
      limpiar_comunas(),
    regexp = "[92-99].[1-9]%|100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de comunas: caracteres reemplazados", {
  expect_message(
    comunas() |>
      reemplazar_texto(porcentaje = 0.1) |>
      limpiar_comunas(),
    regexp = "100%"
  )
}) |>
  suppressMessages()


test_that("prueba calidad de limpieza de comunas: caracteres reemplazados, nivel 2", {
  expect_message(
    comunas() |>
      reemplazar_texto(porcentaje = 0.3) |>
      limpiar_comunas(),
    regexp = "[92-99].[1-9]%|100%"
  )
}) |>
  suppressMessages()

test_that("prueba de limpieza eliminando prefijos", {
  expect_equal(
    limpiar_comunas(
      c(
        "Ilustre Municipalidad de La Florida",
        "I. Municipalidad de La Pintana",
        "Municipalidad de Cerrillos",
        "Muni Providencia"
      )
    ),
    c("La Florida", "La Pintana", "Cerrillos", "Providencia")
  )
}) |>
  suppressMessages()


test_that(
  "limpiar una sola comuna",
  expect_message(
    limpiar_comunas("Pancagua"),
    "se limpió correctamente"
  )
) |>
  suppressMessages()
