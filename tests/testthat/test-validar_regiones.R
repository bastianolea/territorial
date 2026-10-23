test_that("validar regiones correctas", {
  expect_condition(
    validar_regiones(regiones()),
    regexp = "correcta"
  )
}) |>
  suppressMessages()

test_that("validar regiones con mayúsculas", {
  expect_warning(
    validar_regiones(c(
      toupper(regiones()[1:4]),
      regiones()[5:16]
    )),
    regexp = "escritas en mayúsculas"
  ) |>
    suppressWarnings()
}) |>
  suppressMessages()

test_that("validar regiones con minúsculas", {
  expect_warning(
    validar_regiones(c(
      tolower(regiones()[1:4]),
      regiones()[5:16]
    )),
    regexp = "escritas en minúsculas"
  ) |>
    suppressWarnings()
}) |>
  suppressMessages()

test_that("validar regiones con preposiciones en mayúsculas", {
  expect_warning(
    validar_regiones(c("Región Del Maule")),
    regexp = "preposiciones.*mayúsculas"
  ) |>
    suppressWarnings()
}) |>
  suppressMessages()

test_that("validar región con preposiciones bien escritas", {
  expect_condition(
    validar_regiones("Región del Maule"),
    regexp = "correcta"
  )
}) |>
  suppressMessages()

test_that("validar región Ñuble sin eñe", {
  expect_warning(
    validar_regiones(c("Nuble")),
    regexp = "sin eñe"
  ) |>
    suppressWarnings()
}) |>
  suppressMessages()

test_that("validar región Ñuble con eñe", {
  expect_condition(
    validar_regiones("Región de Ñuble"),
    regexp = "correcta"
  )
}) |>
  suppressMessages()

test_that("validar región O'Higgins sin apóstrofo", {
  expect_warning(
    validar_regiones(c("OHiggins")),
    regexp = "sin su apóstrofo"
  ) |>
    suppressWarnings()
}) |>
  suppressMessages()

test_that("validar región O'Higgins con apóstrofo", {
  expect_condition(
    validar_regiones("Región del Libertador General Bernardo O'Higgins"),
    regexp = "correcta"
  )
}) |>
  suppressMessages()

test_that("validar región O'Higgins con apóstrofo incorrecto", {
  expect_warning(
    validar_regiones(c("O´Higgins", "o`higgins", "o.higgins", "ohiggins")),
    regexp = "apóstrofo \\('\\) incorrecto"
  ) |>
    suppressWarnings()
}) |>
  suppressMessages()


test_that("validar región Aysén con i latina", {
  expect_warning(
    validar_regiones(c("Aisén")),
    regexp = "'i' latina"
  ) |>
    suppressWarnings()
}) |>
  suppressMessages()

test_that("validar región Aysén con y griega", {
  expect_condition(
    validar_regiones("Región de Aysén del General Carlos Ibáñez del Campo"),
    regexp = "correcta"
  )
}) |>
  suppressMessages()

test_that("validar regiones sin sus preposiciones", {
  expect_warning(
    validar_regiones(c("hola", "araucanía", "Lagos", "Los Lagos")),
    regexp = "sin sus preposiciones"
  ) |>
    suppressWarnings()
}) |>
  suppressMessages()


test_that("validar regiones desde dataframe", {
  expect_condition(
    territorios |>
      validar_regiones(nombre_region),
    regexp = "correcta"
  )
}) |>
  suppressMessages()


test_that("validar regiones sin especificar columna", {
  expect_no_error(
    territorios |> validar_regiones()
  )
}) |>
  suppressMessages()


test_that(
  "validar regiones desde vector",
  expect_no_error(
    territorios$nombre_region |>
      validar_regiones()
  )
) |>
  suppressMessages()


test_that(
  "validar regiones con columna que no existe",
  expect_error(
    territorios |> validar_regiones(nombre_mapache)
  )
) |>
  suppressMessages()

test_that(
  "validar regiones sin especificar columna, y no existe nombre_region",
  expect_error(
    territorios |>
      dplyr::rename(nombres = nombre_region) |>
      validar_regiones()
  )
) |>
  suppressMessages()
