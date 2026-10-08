test_that("actualizar código comunal", {
  expect_equal(
    actualizar_codigo_comuna(c(1102, 8408)),
    c(1402, 16204)
  )
})

test_that("actualizar código comunal con NA", {
  expect_equal(
    actualizar_codigo_comuna(c(1102, NA)),
    c(1402, NA)
  )
}) |>
  suppressMessages()


test_that("actualizar código comunal que no es antiguo", {
  expect_message(
    actualizar_codigo_comuna(1101),
    "no son antiguos"
  )
}) |>
  suppressMessages()

test_that("actualizar código comunal, caso de antiguos", {
  codigo_comuna <- cut_historicos_l$codigo_comuna_historico[12:16]

  resultados <- actualizar_codigo_comuna(codigo_comuna)

  expect_equal(
    resultados,
    c(5802, 5803, 16101, 16102, 16202)
  )
}) |>
  suppressMessages()


test_that("actualizar código comunal, caso mezclando con válidos", {
  codigo_comuna <- c(
    cut_historicos_l$codigo_comuna_historico[12:16],
    codigos_comunas()[5:9]
  )

  resultados <- actualizar_codigo_comuna(codigo_comuna)

  expect_equal(
    resultados,
    c(5802, 5803, 16101, 16102, 16202, 1403, 1404, 1405, 2101, 2102)
  )
}) |>
  suppressMessages()
