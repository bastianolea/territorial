test_that("prueba de limpieza de comunas", {
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


test_that("prueba de limpieza de comunas 3, no se la puede", {
  expect_no_error(
    limpiar_comunas(
      c(
        "La Florida",
        "Coyiguay"
      ),
      mostrar_proceso = FALSE
    ) |>
      suppressMessages()
  )
})
