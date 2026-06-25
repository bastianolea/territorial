test_that("validar comunas correctas", {
  expect_no_condition(
    validar_comunas(territorial::comunas())
  )
})

test_that("validar comunas con mayúsculas", {
  expect_condition(
    validar_comunas(c(
      toupper(territorial::comunas()[1:4]),
      territorial::comunas()[5:16]
    ))
  )
}) |>
  suppressMessages()

test_that("validar comunas con minúsculas", {
  expect_condition(
    validar_comunas(c(
      tolower(territorial::comunas()[1:4]),
      territorial::comunas()[5:16]
    ))
  )
}) |>
  suppressMessages()

test_that("validar comunas con preposiciones en mayúsculas", {
  expect_condition(
    validar_comunas(c("San José De Maipo"))
  )
}) |>
  suppressMessages()

test_that("validar comuna con preposiciones bien escritas", {
  expect_no_condition(
    validar_comunas(c("San José de Maipo"))
  )
})

test_that("validar comuna O'Higgins sin apóstrofo", {
  expect_condition(
    validar_comunas(c("OHiggins"))
  )
}) |>
  suppressMessages()

test_that("validar comuna O'Higgins con apóstrofo", {
  expect_no_condition(
    validar_comunas("O'Higgins")
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
    validar_comunas(c("Aisén"))
  )
}) |>
  suppressMessages()

test_that("validar comuna Aysén con y griega", {
  expect_no_condition(
    validar_comunas("Aysén")
  )
})


test_that("validar comuna desde dataframe 1", {
  expect_no_condition(
    territorial::territorios |>
      validar_comunas()
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
        validar_comunas()
    }
  )
}) |>
  suppressMessages()
