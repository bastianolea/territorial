test_that("convertir nombre de región a código de región", {
  expect_equal(
    as_codigo_region("Tarapacá"),
    1
  )
})

test_that("convertir varios nombres de región a códigos de región", {
  expect_equal(
    as_codigo_region(
      c("Atacama", "Hola", "Valparaíso", "Perrito")
    ) |>
      suppressWarnings(),
    c(3, NA, 5, NA)
  )
}) |>
  suppressMessages()

test_that("convertir varios nombres de región a códigos de región", {
  expect_equal(
    as_codigo_region(
      c("atacama", "TARAPACÁ", "Maule", "ohiggins")
    ),
    c(3, 1, 7, 6)
  )
}) |>
  suppressMessages()

test_that("convertir cualquier cosa a códigos de región", {
  expect_equal(
    as_codigo_region(
      c("Hola", "Perrito", "Mapache")
    ) |>
      suppressWarnings(),
    as.numeric(c(NA, NA, NA))
  )
}) |>
  suppressMessages()

test_that("convertir números a códigos de región", {
  expect_error(
    as_codigo_region(
      c(1, 3)
    )
  )
})

test_that("convertir missings a códigos de región", {
  expect_equal(
    as_codigo_region(
      c(NA, NA, NA)
    ) |>
      suppressWarnings(),
    as.numeric(c(NA, NA, NA))
  )
}) |>
  suppressMessages()


test_that("convertir nombres de región no existentes arroja warning", {
  expect_warning(
    as_codigo_region(
      "Mordor"
    )
  )
}) |>
  suppressMessages()


test_that("warning de nombres de región no existentes tiene sentido", {
  expect_warning(
    as_codigo_region(
      c("Atacama", "Mordor", "Maule", "Narnia")
    ),
    regexp = "Mordor y Narnia"
  )
}) |>
  suppressMessages()


test_that("warning muestra nombres de región originales, no limpiados", {
  expect_warning(
    as_codigo_region(
      c("Atacama", "MORDÓR")
    ),
    regexp = "MORDÓR"
  )
}) |>
  suppressMessages()


# test_that("mensaje indica cantidad de NA obtenidos", {
#   expect_message(
#     as_codigo_region(
#       c("Atacama", "Mordor", NA, "Narnia")
#     ) |>
#       suppressWarnings(),
#     regexp = "3 valores perdidos"
#   )
# })

test_that("NAs de entrada no arrojan warning", {
  expect_no_warning(
    as_codigo_region(
      c(NA, "Atacama")
    ) |>
      suppressMessages()
  )
})


test_that("warning no incluye NAs de entrada", {
  expect_warning(
    as_codigo_region(
      c(NA, "Atacama", "Mordor")
    ),
    regexp = "correctamente: Mordor$"
  )
}) |>
  suppressMessages()


test_that("nombres de región válidos no arrojan mensajes ni warnings", {
  expect_silent(
    as_codigo_region(
      c("Atacama", "Metropolitana de Santiago", "Ñuble")
    )
  )
})
