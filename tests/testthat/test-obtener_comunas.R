comunas_tarapaca <- c(
  "Iquique",
  "Alto Hospicio",
  "Pozo Almonte",
  "Camiña",
  "Colchane",
  "Huara",
  "Pica"
)

comunas_arica <- c("Arica", "Camarones", "Putre", "General Lagos")

test_that(
  "obtener comunas por nombre de región",
  expect_equal(
    obtener_comunas("Tarapacá"),
    comunas_tarapaca
  )
) |>
  suppressMessages()

test_that(
  "obtener comunas por nombre de región, nombrando argumento",
  expect_equal(
    obtener_comunas(codigo_region = "Tarapacá"),
    comunas_tarapaca
  )
) |>
  suppressMessages()

test_that(
  "obtener comunas por nombre de región como factor",
  expect_equal(
    obtener_comunas(factor("Tarapacá")),
    comunas_tarapaca
  )
) |>
  suppressMessages()

test_that(
  "obtener comunas por código de región",
  expect_equal(
    obtener_comunas(15),
    comunas_arica
  )
) |>
  suppressMessages()

test_that(
  "obtener comunas con más de un código",
  expect_equal(
    obtener_comunas(c(15, 1)),
    c(comunas_tarapaca, comunas_arica)
  )
) |>
  suppressMessages()

test_that(
  "nombres y códigos de las mismas regiones dan el mismo resultado",
  expect_equal(
    obtener_comunas(c("Arica y Parinacota", "Tarapacá")),
    obtener_comunas(c(15, 1))
  )
) |>
  suppressMessages()

test_that("nombre de región incorrecto arroja warning y error", {
  expect_error(
    expect_warning(
      obtener_comunas("Titirilquén"),
      regexp = "Titirilquén"
    ),
    regexp = "no encontrada"
  )
})

test_that("código de región inexistente arroja error", {
  expect_error(
    obtener_comunas(99),
    regexp = "no encontrada"
  )
})

test_that(
  "obtener comunas tira error si está vacía",
  expect_error(
    obtener_comunas()
  )
)
