test_that("validar regiones correctas", {
  expect_condition(
    validar_regiones(territorial::regiones()),
    regexp = "correcta"
  )
})

test_that("validar regiones con mayúsculas", {
  expect_condition(
    validar_regiones(c(
      toupper(territorial::regiones()[1:4]),
      territorial::regiones()[5:16]
    )),
    regexp = "problema"
  )
}) |>
  suppressMessages()

test_that("validar regiones con minúsculas", {
  expect_condition(
    validar_regiones(c(
      tolower(territorial::regiones()[1:4]),
      territorial::regiones()[5:16]
    )),
    regexp = "problema"
  )
}) |>
  suppressMessages()

test_that("validar regiones con preposiciones en mayúsculas", {
  expect_condition(
    validar_regiones(c("Región Del Maule")),
    regexp = "problema"
  )
}) |>
  suppressMessages()

test_that("validar región con preposiciones bien escritas", {
  expect_condition(
    validar_regiones("Región del Maule"),
    regexp = "correcta"
  )
})

test_that("validar región Ñuble sin eñe", {
  expect_condition(
    validar_regiones(c("Nuble")),
    regexp = "problema"
  )
}) |>
  suppressMessages()

test_that("validar región Ñuble con eñe", {
  expect_condition(
    validar_regiones("Región de Ñuble"),
    regexp = "correcta"
  )
})

test_that("validar región O'Higgins sin apóstrofo", {
  expect_condition(
    validar_regiones(c("OHiggins")),
    regexp = "problema"
  )
}) |>
  suppressMessages()

test_that("validar región O'Higgins con apóstrofo", {
  expect_condition(
    validar_regiones("Región del Libertador General Bernardo O'Higgins"),
    regexp = "correcta"
  )
})

test_that("validar región O'Higgins con apóstrofo incorrecto", {
  expect_condition(
    validar_regiones(c("O´Higgins", "o`higgins", "o.higgins", "ohiggins")),
    regexp = "problema"
  )
}) |>
  suppressMessages()


test_that("validar región Aysén con i latina", {
  expect_condition(
    validar_regiones(c("Aisén")),
    regexp = "problema"
  )
}) |>
  suppressMessages()

test_that("validar región Aysén con y griega", {
  expect_condition(
    validar_regiones("Región de Aysén del General Carlos Ibáñez del Campo"),
    regexp = "correcta"
  )
})

test_that("validar regiones sin sus preposiciones", {
  expect_condition(
    validar_regiones(c("hola", "araucanía", "Lagos", "Los Lagos")),
    regexp = "problema"
  )
}) |>
  suppressMessages()


test_that("validar regiones desde dataframe", {
  expect_condition(
    territorial::territorios |>
      validar_regiones(nombre_region),
    regexp = "correcta"
  )
}) |>
  suppressMessages()
