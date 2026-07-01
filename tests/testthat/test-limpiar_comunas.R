test_that("prueba de limpieza de comunas 1", {
  expect_equal(
    limpiar_comunas(
      c("CERRILLOS", "la florida", "ñunoa", "nunoa"),
      mostrar_proceso = FALSE
    ) |>
      suppressMessages(),
    c("Cerrillos", "La Florida", "Ñuñoa", "Ñuñoa")
  )
})

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
        "laflorida",
        "cerritos",
        "llay-llay",
        "asdf",
        NA
      ),
      mostrar_proceso = FALSE
    ) |>
      suppressMessages(),
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
      "La Florida",
      "Cerrillos",
      "Llaillay",
      NA,
      NA
    )
  )
})


test_that("prueba de limpieza de comunas 3, antes no se la podía", {
  expect_equal(
    limpiar_comunas(
      c("La Florida", "Quirigue"),
      mostrar_proceso = FALSE
    ) |>
      suppressMessages(),
    c("La Florida", "Quirihue")
  )
})


test_that("prueba de limpieza de comunas 4, antes no se la podía", {
  expect_equal(
    limpiar_comunas(
      c("O´HIGGINS", "TREGUACO"),
      mostrar_proceso = FALSE
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
          nombre_comuna = limpiar_comunas(municipio, mostrar_proceso = FALSE)
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
      mostrar_proceso = FALSE
    ),
    c("Cabo de Hornos")
  )
}) |>
  suppressMessages()


test_that("prueba de limpieza de comunas 6, casos especiales", {
  expect_equal(
    limpiar_comunas(
      c("coihaique", "la calera", "aisén"),
      mostrar_proceso = FALSE
    ),
    c("Coyhaique", "Calera", "Aysén")
  )
}) |>
  suppressMessages()
