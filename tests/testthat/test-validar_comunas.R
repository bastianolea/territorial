test_that("validar comunas correctas", {
  expect_condition(
    validar_comunas(territorial::comunas()),
    regexp = "correcta"
  )
})

test_that("validar comunas con mayúsculas", {
  expect_condition(
    validar_comunas(c(
      toupper(territorial::comunas()[1:4]),
      territorial::comunas()[5:16]
    )),
    regexp = "problema"
  )
}) |>
  suppressMessages()

test_that("validar comunas con minúsculas", {
  expect_condition(
    validar_comunas(c(
      tolower(territorial::comunas()[1:4]),
      territorial::comunas()[5:16]
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
})

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
})

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
})


test_that("validar comuna desde dataframe 1", {
  expect_condition(
    territorial::territorios |>
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
})
