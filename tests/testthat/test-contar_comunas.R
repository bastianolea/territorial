test_that("revisar comunas completas (346) desde dataframe", {
  expect_condition(
    territorios |>
      contar_comunas(),
    regexp = "correcta"
  )
}) |>
  suppressMessages()


test_that("revisar comunas desde vector no da error", {
  expect_no_error(
    territorios$nombre_comuna |>
      contar_comunas()
  )
}) |>
  suppressMessages()

test_that("revisar comunas desde lista da error", {
  expect_error(
    list(territorios$nombre_comuna) |>
      contar_comunas()
  )
}) |>
  suppressMessages()

test_that("revisar comunas con columna que no existe da error", {
  expect_error(
    territorios |> contar_comunas(nombre_mapache)
  )
}) |>
  suppressMessages()

test_that(
  "revisar comunas sin especificar columna, y no existe nombre_comuna, da error",
  expect_error(
    territorios |>
      dplyr::rename(nombres = nombre_comuna) |>
      contar_comunas()
  )
) |>
  suppressMessages()

test_that("revisar comunas desde dataframe especificando columna", {
  withr::local_seed(7319)
  expect_condition(
    territorios |>
      dplyr::rename(nombres = nombre_comuna) |>
      dplyr::slice_sample(n = 20) |>
      contar_comunas(nombres),
    regexp = "anómala"
  )
}) |>
  suppressMessages()


test_that("revisar comunas completas menos Antártica desde vector", {
  expect_condition(
    territorial::comunas()[territorial::comunas() != "Antártica"] |>
      contar_comunas(),
    regexp = "Antártica"
  )
}) |>
  suppressMessages()

test_that("revisar comunas con muestra pequeña (menos de 345)", {
  withr::local_seed(7319)
  expect_condition(
    territorios |>
      dplyr::slice_sample(n = 10) |>
      contar_comunas(),
    regexp = "anómala"
  )
}) |>
  suppressMessages()

test_that("revisar comunas con muestra intermedia (310)", {
  withr::local_seed(7319)
  expect_condition(
    territorios |>
      dplyr::slice_sample(n = 310) |>
      contar_comunas(),
    regexp = "anómala"
  )
}) |>
  suppressMessages()

test_that("revisar comunas sin datos (0 filas)", {
  expect_condition(
    territorios |>
      dplyr::slice_sample(n = 0) |>
      contar_comunas(),
    regexp = "anómala"
  )
}) |>
  suppressMessages()

test_that("revisar comunas con más de 346 comunas únicas", {
  expect_condition(
    c(territorial::comunas(), "Comuna Falsa") |>
      contar_comunas(),
    regexp = "anómala"
  )
}) |>
  suppressMessages()

test_that("revisar comunas indicando cuáles faltan", {
  withr::local_seed(7319)
  expect_warning(
    territorios |>
      dplyr::slice_sample(n = 10) |>
      contar_comunas()
  )
}) |>
  suppressMessages()

#' territorios |>
#'   dplyr::slice_sample(300) |>
#'   contar_comunas()

test_that("contar_comunas advierte si faltan comunas", {
  expect_warning(
    suppressMessages(contar_comunas(comunas()[1:300])),
    "anómala"
  )
})

test_that("contar_comunas advierte si hay comunas de más", {
  comunas_de_mas <- c(comunas(), paste("comuna inventada", 1:5))

  expect_warning(
    suppressMessages(contar_comunas(comunas_de_mas)),
    "anómala"
  )
})

test_that("contar_comunas retorna la cantidad de comunas de forma invisible", {
  resultado <- suppressMessages(suppressWarnings(
    contar_comunas(comunas()[1:344])
  ))
  expect_equal(resultado, 344)
})
