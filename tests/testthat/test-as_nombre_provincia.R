# referencias desde territorial::territorios ----

codigos_validos <- unique(territorial::territorios$codigo_provincia)

codigo_inexistente_1 <- max(codigos_validos) + 1
codigo_inexistente_2 <- max(codigos_validos) + 2


test_that("convertir códigos de provincia a nombres de provincia", {
  expect_equal(
    as_nombre_provincia(
      c(11, 31, codigo_inexistente_1, 151)
    ) |>
      suppressWarnings(),
    c("Iquique", "Copiapó", NA, "Arica")
  )
}) |>
  suppressMessages()


test_that("convertir NAs a nombres de provincia", {
  expect_equal(
    as_nombre_provincia(
      c(NA, 11)
    ),
    c(NA, "Iquique")
  )
}) |>
  suppressMessages()


test_that("convertir texto a nombres de provincia cuando debería ser numérico", {
  expect_message(
    as_nombre_provincia(
      c("hola", "basty", NA)
    )
  ) |>
    suppressMessages() |>
    suppressWarnings()
})


test_that("convertir códigos de provincia no existentes arroja warning", {
  expect_warning(
    as_nombre_provincia(
      codigo_inexistente_1
    )
  )
}) |>
  suppressMessages()


test_that("warning de códigos de provincia no existentes tiene sentido", {
  expect_warning(
    as_nombre_provincia(
      c(11, codigo_inexistente_1, 31, codigo_inexistente_2)
    ),
    regexp = paste0(codigo_inexistente_1, " y ", codigo_inexistente_2)
  )
}) |>
  suppressMessages()


test_that("warning no repite códigos de provincia no existentes", {
  expect_warning(
    as_nombre_provincia(
      c(codigo_inexistente_1, codigo_inexistente_1, 11, codigo_inexistente_2)
    ),
    regexp = paste0(codigo_inexistente_1, " y ", codigo_inexistente_2, "$")
  )
}) |>
  suppressMessages()

# test_that("mensaje indica cantidad de NA obtenidos", {
#   expect_message(
#     as_nombre_provincia(
#       c(11, codigo_inexistente_1, NA, codigo_inexistente_2)
#     ) |>
#       suppressWarnings(),
#     regexp = "3 valores perdidos"
#   )
# })

# test_that("NAs de entrada no arrojan warning, pero sí mensaje", {
#   expect_no_warning(
#     as_nombre_provincia(
#       c(NA, 11)
#     ) |>
#       suppressMessages()
#   )
#
#   expect_message(
#     as_nombre_provincia(
#       c(NA, 11)
#     ),
#     regexp = "1 valor perdido"
#   )
# })

test_that("warning no incluye NAs de entrada", {
  expect_warning(
    as_nombre_provincia(
      c(NA, 11, codigo_inexistente_1)
    ),
    regexp = paste0("provincia: ", codigo_inexistente_1, "$")
  )
}) |>
  suppressMessages()


test_that("códigos de provincia válidos no arrojan mensajes ni warnings", {
  expect_silent(
    as_nombre_provincia(
      codigos_validos
    )
  )
})
