test_that("prueba de limpieza de regiones 1", {
  expect_equal(
    limpiar_regiones(
      c("MAULE", "la araucania", "nuble", "biobio"),
      procedimiento = F
    ),
    c("Maule", "La Araucanía", "Ñuble", "Biobío")
  )
}) |>
  suppressMessages()

test_that("prueba de limpieza de regiones 2", {
  expect_equal(
    limpiar_regiones(
      c(
        "TARAPACA",
        "Coquimbo",
        "valparaiso",
        "santiago",
        "ohiggins",
        "NUBLE",
        "asdf",
        NA
      ),
      procedimiento = F
    ) |>
      suppressMessages(),
    c(
      "Tarapacá",
      "Coquimbo",
      "Valparaíso",
      "Metropolitana de Santiago",
      "Libertador General Bernardo O'Higgins",
      "Ñuble",
      NA,
      NA
    )
  )
})

test_that("prueba de limpieza de regiones 3, versiones cortas", {
  expect_equal(
    limpiar_regiones(
      c("Metropolitana", "O'Higgins", "Aysén", "Magallanes"),
      procedimiento = FALSE
    ) |>
      suppressMessages(),
    c(
      "Metropolitana de Santiago",
      "Libertador General Bernardo O'Higgins",
      "Aysén del General Carlos Ibáñez del Campo",
      "Magallanes y de la Antártica Chilena"
    )
  )
})

test_that("prueba de limpieza de regiones 4, casos especiales", {
  expect_equal(
    limpiar_regiones(
      c("RM", "aisen", "antartica", "parinacota", "lagos"),
      procedimiento = FALSE
    ) |>
      suppressMessages(),
    c(
      "Metropolitana de Santiago",
      "Aysén del General Carlos Ibáñez del Campo",
      "Magallanes y de la Antártica Chilena",
      "Arica y Parinacota",
      "Los Lagos"
    )
  )
})

test_that("prueba de limpieza de regiones 5, coincidencia aproximada", {
  expect_equal(
    limpiar_regiones(
      c("Bio", "Ríos", "Araucania")
    ),
    c("Biobío", "Los Ríos", "La Araucanía")
  )
}) |>
  suppressMessages()

test_that("prueba de limpieza de regiones donde la limpieza habría dejado texto de 0 caracteres", {
  expect_equal(
    limpiar_regiones(
      c("658145002")
    ) |>
      suppressMessages(),
    NA_character_
  )
})

test_that("limpiar regiones sin especificar columna retorna dataframe", {
  resultado <- territorios |>
    limpiar_regiones() |>
    suppressMessages()

  expect_s3_class(resultado, "data.frame")
})

test_that("limpiar regiones desde dataframe especificando columna retorna dataframe", {
  resultado <- territorios |>
    limpiar_regiones(nombre_region) |>
    suppressMessages()

  expect_s3_class(resultado, "data.frame")
})

test_that("limpiar regiones desde vector retorna vector", {
  resultado <- territorios$nombre_region |>
    limpiar_regiones()

  expect_true(is.vector(resultado))
}) |>
  suppressMessages()


test_that("limpiar regiones no aplica a listas", {
  expect_error(
    list(regiones = c(1, 2, 3)) |>
      limpiar_regiones()
  )
}) |>
  suppressMessages()

test_that(
  "limpiar regiones con columna que no existe",
  expect_error(
    territorios |> limpiar_regiones(nombre_mapache)
  )
) |>
  suppressMessages()

test_that(
  "limpiar regiones sin especificar columna, y no existe nombre_region",
  expect_error(
    territorios |>
      dplyr::rename(nombres = nombre_region) |>
      limpiar_regiones()
  )
) |>
  suppressMessages()

test_that("limpiar regiones con aproximar = FALSE no rescata por fuzzy matching", {
  # "rio" solo coincide con "Los Ríos" vía fuzzy; sin aproximar debe quedar NA
  expect_equal(
    limpiar_regiones(c("Los Ríos", "rio"), aproximar = FALSE) |>
      suppressMessages(),
    c("Los Ríos", NA_character_)
  )
})

test_that("limpiar puros NA no falla", {
  expect_no_error(
    limpiar_regiones(c(NA, NA)) |>
      suppressMessages()
  )
})

test_that("limpiar regiones desde dataframe limpia efectivamente el contenido", {
  datos_sucios <- dplyr::tibble(
    nombre_region = c("MAULE", "la araucania"),
    valor = c(1, 2)
  )
  resultado <- datos_sucios |>
    limpiar_regiones() |>
    suppressMessages()

  expect_equal(resultado$nombre_region, c("Maule", "La Araucanía"))
})

test_that("limpiar regiones desde dataframe con columna personalizada", {
  datos_sucios <- dplyr::tibble(
    region = c("santiago", "ohiggins"),
    valor = c(1, 2)
  )
  resultado <- datos_sucios |>
    limpiar_regiones(region) |>
    suppressMessages()

  expect_equal(
    resultado$region,
    c("Metropolitana de Santiago", "Libertador General Bernardo O'Higgins")
  )
})

# factores ----
test_that("limpiar regiones funciona con vectores de tipo factor y advierte", {
  nombres <- factor(c("MAULE", "la araucania"))

  expect_warning(
    resultado <- limpiar_regiones(nombres) |> suppressMessages(),
    "formato factor"
  )
  expect_type(resultado, "character")
  expect_equal(resultado, c("Maule", "La Araucanía"))
})

test_that("limpiar regiones funciona con columnas factor en dataframes y advierte", {
  datos <- dplyr::tibble(nombre_region = factor(c("MAULE", "la araucania")))

  expect_warning(
    resultado <- limpiar_regiones(datos) |> suppressMessages(),
    "formato factor"
  )
  expect_type(resultado$nombre_region, "character")
  expect_equal(resultado$nombre_region, c("Maule", "La Araucanía"))
})


# calidad ----
test_that("prueba calidad de limpieza de regiones: minúscula sin símbolos", {
  expect_message(
    regiones() |>
      limpiar_texto() |>
      limpiar_regiones(),
    regexp = "100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de regiones: mayúsculas sin símbolos", {
  expect_message(
    regiones() |>
      limpiar_texto() |>
      toupper() |>
      limpiar_regiones(),
    regexp = "100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de regiones: guiones bajo en vez de espacios", {
  expect_message(
    regiones() |>
      limpiar_texto() |>
      stringr::str_replace_all(" ", "_") |>
      limpiar_regiones(),
    regexp = "100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de regiones: espaciados extra", {
  expect_message(
    territorios |>
      dplyr::distinct(nombre_region) |>
      messy::add_whitespace() |>
      limpiar_regiones(),
    regexp = "100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de regiones: caracteres especiales, nivel 1", {
  expect_message(
    territorios |>
      dplyr::distinct(nombre_region) |>
      messy::add_special_chars(messiness = 0.1) |>
      limpiar_regiones(),
    regexp = "100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de regiones: caracteres especiales, nivel 2", {
  expect_message(
    territorios |>
      dplyr::distinct(nombre_region) |>
      messy::add_special_chars(messiness = 0.3) |>
      limpiar_regiones(),
    regexp = "[95-99].[1-9]%|100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de regiones: mayúsculas y símbolos", {
  expect_message(
    territorios |>
      dplyr::distinct(nombre_region) |>
      messy::change_case() |>
      messy::add_special_chars() |>
      limpiar_regiones(),
    regexp = "100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de regiones: mayúsculas, espacios y símbolos", {
  expect_message(
    territorios |>
      dplyr::select(nombre_region) |>
      messy::change_case() |>
      messy::add_whitespace() |>
      messy::add_special_chars() |>
      limpiar_regiones(),
    regexp = "[95-99].[1-9]%|100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de regiones: caracteres faltantes", {
  expect_message(
    regiones() |>
      eliminar_texto(porcentaje = 0.1) |>
      limpiar_regiones(procedimiento = F),
    regexp = "100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de regiones: caracteres faltantes, nivel 2", {
  expect_message(
    regiones() |>
      eliminar_texto(porcentaje = 0.2) |>
      limpiar_regiones(procedimiento = F),
    regexp = "[95-99].[1-9]%|100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de regiones: caracteres reemplazados", {
  expect_message(
    regiones() |>
      reemplazar_texto(porcentaje = 0.1) |>
      limpiar_regiones(procedimiento = F),
    regexp = "100%"
  )
}) |>
  suppressMessages()

test_that("prueba calidad de limpieza de regiones: caracteres reemplazados, nivel 2", {
  expect_message(
    regiones() |>
      reemplazar_texto(porcentaje = 0.2) |>
      limpiar_regiones(procedimiento = F),
    regexp = "[95-99].[1-9]%|100%"
  )
}) |>
  suppressMessages()
