test_that("convertir nombre de provincia a código de provincia", {
  expect_equal(
    as_codigo_provincia("Iquique"),
    11
  )
})

test_that("convertir varios nombres de provincia a códigos de provincia", {
  expect_equal(
    as_codigo_provincia(
      c("Antofagasta", "Hola", "Valparaíso", "Perrito")
    ) |>
      suppressWarnings(),
    c(21, NA, 51, NA)
  )
}) |>
  suppressMessages()

test_that("convertir varios nombres de provincia sin importar mayúsculas ni tildes", {
  expect_equal(
    as_codigo_provincia(
      c("elqui", "CHILOÉ", "copiapo", "Talca")
    ),
    c(41, 102, 31, 71)
  )
}) |>
  suppressMessages()

test_that("ignorar prefijo 'provincia de' en los nombres ingresados", {
  expect_equal(
    as_codigo_provincia(
      c("Provincia de Iquique", "provincia de Cardenal Caro")
    ),
    c(11, 62)
  )
}) |>
  suppressMessages()

test_that("ignorar prefijo 'provincia del' en los nombres ingresados", {
  expect_equal(
    as_codigo_provincia(
      c("Provincia del Tamarugal", "provincia del Tamarugal")
    ),
    c(14, 14)
  )
}) |>
  suppressMessages()

test_that("convertir cualquier cosa a códigos de provincia", {
  expect_equal(
    as_codigo_provincia(
      c("Hola", "Perrito", "Mapache")
    ) |>
      suppressWarnings(),
    as.numeric(c(NA, NA, NA))
  )
}) |>
  suppressMessages()

test_that("convertir números a códigos de provincia", {
  expect_error(
    as_codigo_provincia(
      c(1, 3)
    )
  )
})

test_that("convertir missings a códigos de provincia", {
  expect_equal(
    as_codigo_provincia(
      c(NA, NA, NA)
    ) |>
      suppressWarnings(),
    as.numeric(c(NA, NA, NA))
  )
}) |>
  suppressMessages()

test_that("convertir nombres de provincia no existentes arroja warning", {
  expect_warning(
    as_codigo_provincia(
      "Moscú"
    )
  )
}) |>
  suppressMessages()

test_that("warning de nombres de provincia no existentes tiene sentido", {
  expect_warning(
    as_codigo_provincia(
      c("Antofagasta", "Necromunda", "Talca", "Titirilquén")
    ),
    regexp = "Necromunda y Titirilquén"
  )
}) |>
  suppressMessages()

test_that("warning muestra nombres de provincia originales, no limpiados", {
  expect_warning(
    as_codigo_provincia(
      c("Antofagasta", "NECROMUNDA")
    ),
    regexp = "NECROMUNDA"
  )
}) |>
  suppressMessages()

test_that("NAs de entrada no arrojan warning", {
  expect_no_warning(
    as_codigo_provincia(
      c(NA, "Antofagasta")
    ) |>
      suppressMessages()
  )
})

test_that("warning no incluye NAs de entrada", {
  expect_warning(
    as_codigo_provincia(
      c(NA, "Antofagasta", "Sacramentus")
    ),
    regexp = "correctamente: Sacramentus$"
  )
}) |>
  suppressMessages()

test_that("nombres de provincia válidos no arrojan mensajes ni warnings", {
  expect_silent(
    as_codigo_provincia(
      c("Iquique", "Isla de Pascua", "Diguillín")
    )
  )
})
