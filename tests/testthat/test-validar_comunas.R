test_that("validar comunas correctas", {
  expect_condition(
    validar_comunas(comunas()),
    regexp = "correcta"
  )
}) |>
  suppressMessages()

test_that("validar comunas con mayúsculas", {
  expect_condition(
    validar_comunas(c(
      toupper(comunas()[1:4]),
      comunas()[5:16]
    )),
    regexp = "problema"
  )
}) |>
  suppressMessages()

test_that("validar comunas con minúsculas", {
  expect_condition(
    validar_comunas(c(
      tolower(comunas()[1:4]),
      comunas()[5:16]
    )),
    regexp = "problema"
  )
}) |>
  suppressMessages()

test_that("validar comunas con preposiciones en mayúsculas", {
  expect_condition(
    validar_comunas(c("San José De Maipo")),
    regexp = "problema"
  )
}) |>
  suppressMessages()

test_that("validar comuna con preposiciones bien escritas", {
  expect_condition(
    validar_comunas(c("San José de Maipo")),
    regexp = "correcta"
  )
}) |>
  suppressMessages()

test_that("validar comuna O'Higgins sin apóstrofo", {
  expect_condition(
    validar_comunas(c("OHiggins")),
    regexp = "problema"
  )
}) |>
  suppressMessages()

test_that("validar comuna O'Higgins con apóstrofo", {
  expect_condition(
    validar_comunas("O'Higgins"),
    regexp = "correcta"
  )
}) |>
  suppressMessages()

# test_that("validar comuna O'Higgins con apóstrofo incorrecto", {
#   expect_condition(
#     validar_comunas(c("O´Higgins", "o`higgins", "o.higgins", "ohiggins"))
#   )
# }) |>
#   suppressMessages()

test_that("validar comuna Aysén con i latina", {
  expect_condition(
    validar_comunas(c("Aisén")),
    regexp = "problema"
  )
}) |>
  suppressMessages()

test_that("validar comuna Aysén con y griega", {
  expect_condition(
    validar_comunas("Aysén"),
    regexp = "correcta"
  )
}) |>
  suppressMessages()


test_that("validar comuna desde dataframe 1", {
  expect_condition(
    territorios |>
      validar_comunas(nombre_comuna),
    regexp = "correcta"
  )
}) |>
  suppressMessages()


test_that("validar comuna desde dataframe 2", {
  expect_condition(
    {
      datos <- dplyr::tibble(
        nombre_comuna = c("chiguayante", "la florida", "paine")
      )
      datos |>
        validar_comunas(nombre_comuna)
    },
    regexp = "problema"
  )
}) |>
  suppressMessages()

test_that("validar escritura alternativa de paiguano", {
  expect_condition(
    validar_comunas("Paiguano"),
    regexp = "problema"
  )
}) |>
  suppressMessages()

test_that("validar escritura correcta de paiguano", {
  expect_condition(
    validar_comunas("Paihuano"),
    regexp = "correcta"
  )
}) |>
  suppressMessages()


test_that("validar escritura correcta de paiguano", {
  expect_condition(
    validar_comunas("Paihuano"),
    regexp = "correcta"
  )
}) |>
  suppressMessages()


test_that("validar comunas sin especificar columna", {
  expect_no_error(
    territorios |> validar_comunas()
  )
}) |>
  suppressMessages()


test_that(
  "validar comunas desde dataframe especificando columna",
  expect_no_error(
    territorios |> validar_comunas(nombre_comuna)
  )
) |>
  suppressMessages()

test_that(
  "validar comunas desde vector",
  expect_no_error(
    territorios$nombre_comuna |>
      validar_comunas()
  )
) |>
  suppressMessages()

test_that(
  "validar comunas incorrectas desde vector",
  expect_no_error(
    c("Pedro aguirre Cerda", "Penco", "Penaflor", "Penalolen") |>
      validar_comunas()
  )
) |>
  suppressMessages()

test_that(
  "validar comunas desde lista da error",
  expect_error(
    list(c("Pedro aguirre Cerda", "Penco", "Penaflor", "Penalolen")) |>
      validar_comunas()
  )
) |>
  suppressMessages()


test_that(
  "validar comunas con columna que no existe",
  expect_error(
    territorios |> validar_comunas(nombre_mapache)
  )
) |>
  suppressMessages()

test_that(
  "validar comunas sin especificar columna, y no existe nombre_comuna",
  expect_error(
    territorios |>
      dplyr::rename(nombres = nombre_comuna) |>
      validar_comunas()
  )
) |>
  suppressMessages()
