test_that("convertir códigos de comuna a nombres de comuna", {
  expect_equal(
    as_nombre_comuna(
      c(1401, 1403, 9999999, 1404)
    ) |>
      suppressWarnings(),
    c("Pozo Almonte", "Colchane", NA, "Huara")
  )
}) |>
  suppressMessages()


test_that("convertir NAs a nombres de comuna", {
  expect_equal(
    as_nombre_comuna(
      c(NA, 1401)
    ),
    c(NA, "Pozo Almonte")
  )
}) |>
  suppressMessages()


test_that("convertir texto a nombres de comuna cuando debería ser numérico", {
  expect_error(
    as_nombre_comuna(
      c("hola", "basty", NA)
    )
  )
}) |>
  suppressMessages()


test_that("convertir códigos de comuna no existentes arroja warning", {
  expect_warning(
    as_nombre_comuna(
      14904
    )
  )
}) |>
  suppressMessages()

test_that("warning de códigos de comuna no existentes tiene sentido", {
  expect_warning(
    as_nombre_comuna(
      c(1401, 1403, 9999, 1404, 14904)
    ),
    regexp = "9999 y 14904"
  )
}) |>
  suppressMessages()


test_that("warning no repite códigos de comuna no existentes", {
  expect_warning(
    as_nombre_comuna(
      c(9999, 9999, 1401, 14904)
    ),
    regexp = "9999 y 14904$"
  )
}) |>
  suppressMessages()


# test_that("mensaje indica cantidad de NA obtenidos", {
#   expect_message(
#     as_nombre_comuna(
#       c(1401, 9999, NA, 14904)
#     ) |>
#       suppressWarnings(),
#     regexp = "3 valores perdidos"
#   )
# })

# test_that("NAs de entrada no arrojan warning, pero sí mensaje", {
#   expect_no_warning(
#     as_nombre_comuna(
#       c(NA, 1401)
#     ) |>
#       suppressMessages()
#   )
#
#   expect_message(
#     as_nombre_comuna(
#       c(NA, 1401)
#     ),
#     regexp = "1 valor perdido"
#   )
# })

test_that("warning no incluye NAs de entrada", {
  expect_warning(
    as_nombre_comuna(
      c(NA, 1401, 9999)
    ),
    regexp = "comunas: 9999$"
  )
}) |>
  suppressMessages()


test_that("códigos de comuna válidos no arrojan mensajes ni warnings", {
  expect_silent(
    as_nombre_comuna(
      c(1101, 13110, 2102)
    )
  )
})
