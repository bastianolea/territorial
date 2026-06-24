test_that("validar regiones correctas", {
  expect_no_condition(
    validar_regiones(territorial::regiones())
  )
})

test_that("validar regiones con mayúsculas", {
  expect_condition(
    validar_regiones(c(
      toupper(territorial::regiones()[1:4]),
      territorial::regiones()[5:16]
    ))
  )
}) |>
  suppressMessages()

test_that("validar regiones con minúsculas", {
  expect_condition(
    validar_regiones(c(
      tolower(territorial::regiones()[1:4]),
      territorial::regiones()[5:16]
    ))
  )
}) |>
  suppressMessages()

test_that("validar regiones con preposiciones en mayúsculas", {
  expect_condition(
    validar_regiones(c("Región Del Maule"))
  )
}) |>
  suppressMessages()

test_that("validar región con preposiciones bien escritas", {
  expect_no_condition(
    validar_regiones("Región del Maule")
  )
})

test_that("validar región Ñuble sin eñe", {
  expect_condition(
    validar_regiones(c("Nuble"))
  )
}) |>
  suppressMessages()

test_that("validar región Ñuble con eñe", {
  expect_no_condition(
    validar_regiones("Región de Ñuble")
  )
})

test_that("validar región O'Higgins sin apóstrofo", {
  expect_condition(
    validar_regiones(c("OHiggins"))
  )
}) |>
  suppressMessages()

test_that("validar región O'Higgins con apóstrofo", {
  expect_no_condition(
    validar_regiones("Región del Libertador General Bernardo O'Higgins")
  )
})

test_that("validar región O'Higgins con apóstrofo incorrecto", {
  expect_condition(
    validar_regiones(c("O´Higgins", "o`higgins", "o.higgins", "ohiggins"))
  )
}) |>
  suppressMessages()


test_that("validar región Aysén con i latina", {
  expect_condition(
    validar_regiones(c("Aisén"))
  )
}) |>
  suppressMessages()

test_that("validar región Aysén con y griega", {
  expect_no_condition(
    validar_regiones("Región de Aysén del General Carlos Ibáñez del Campo")
  )
})

test_that("validar regiones sin sus preposiciones", {
  expect_condition(
    validar_regiones(c("hola", "araucanía", "Lagos", "Los Lagos"))
  )
}) |>
  suppressMessages()
