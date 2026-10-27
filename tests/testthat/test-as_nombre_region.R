test_that("convertir códigos de región a nombres de región", {
  expect_equal(
    as_nombre_region(
      c(1, 3, 9999999, 5)
    ) |>
      suppressWarnings(),
    c("Tarapacá", "Atacama", NA, "Valparaíso")
  )
}) |>
  suppressMessages()


test_that("convertir NAs a nombres de región", {
  expect_equal(
    as_nombre_region(
      c(NA, 1)
    ),
    c(NA, "Tarapacá")
  )
}) |>
  suppressMessages()


test_that("convertir texto a nombres de región cuando debería ser numérico", {
  expect_error(
    as_nombre_region(
      c("hola", "basty", NA)
    )
  )
})


test_that("convertir códigos de región no existentes arroja warning", {
  expect_warning(
    as_nombre_region(
      99
    )
  )
}) |>
  suppressMessages()


test_that("warning de códigos de región no existentes tiene sentido", {
  expect_warning(
    as_nombre_region(
      c(15, 4, 99, 10, 77)
    ),
    regexp = "99 y 77"
  )
}) |>
  suppressMessages()


test_that("warning no repite códigos de región no existentes", {
  expect_warning(
    as_nombre_region(
      c(99, 99, 1, 77)
    ),
    regexp = "99 y 77$"
  )
}) |>
  suppressMessages()

#
# test_that("mensaje indica cantidad de NA obtenidos", {
#   expect_message(
#     as_nombre_region(
#       c(1, 99, NA, 77)
#     ) |>
#       suppressWarnings(),
#     regexp = "3 valores perdidos"
#   )
# })

# test_that("NAs de entrada no arrojan warning, pero sí mensaje", {
#   expect_no_warning(
#     as_nombre_region(
#       c(NA, 1)
#     ) |>
#       suppressMessages()
#   )
#
#   expect_message(
#     as_nombre_region(
#       c(NA, 1)
#     ),
#     regexp = "1 valor perdido"
#   )
# })

test_that("warning no incluye NAs de entrada", {
  expect_warning(
    as_nombre_region(
      c(NA, 1, 99)
    ),
    regexp = "regiones: 99$"
  )
}) |>
  suppressMessages()


test_that("códigos de región válidos no arrojan mensajes ni warnings", {
  expect_silent(
    as_nombre_region(
      1:16
    )
  )
})
