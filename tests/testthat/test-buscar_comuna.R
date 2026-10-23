test_that("buscar_comuna encuentra una coincidencia exacta por defecto", {
  resultados <- territorios |> buscar_comuna("Iquique")

  expect_equal(resultados$nombre_comuna[1], "Iquique")
  expect_equal(resultados$puntaje[1], 1.0)
}) |>
  suppressMessages()

test_that("buscar_comuna no retorna filas cuando nada cumple el umbral", {
  resultados <- territorios |> buscar_comuna("xyzxyzxyz", similitud = 0.9) |> suppressWarnings()

  expect_equal(nrow(resultados), 0)
}) |>
  suppressMessages()

test_that("buscar_comuna funciona con una tabla y columna personalizadas", {
  datos_prueba <- dplyr::tibble(
    comuna_id = 1:3,
    nombre_zona = c("Iquique", "Alto Hospicio", "Pica")
  )

  resultados <- datos_prueba |>
    buscar_comuna("iquique", columna = nombre_zona, similitud = 0.3)

  # coincidencia exacta (salvo mayúsculas) debe quedar primera con puntaje 1
  expect_equal(resultados$nombre_zona[1], "Iquique")
  expect_equal(resultados$puntaje[1], 1.0)

  # comuna sin relación queda fuera del umbral de similitud
  expect_false("Pica" %in% resultados$nombre_zona)
}) |>
  suppressMessages()

test_that("buscar_comuna lanza un error si la columna no existe en datos", {
  datos_prueba <- dplyr::tibble(
    comuna_id = 1:3,
    nombre_zona = c("Iquique", "Alto Hospicio", "Pica")
  )

  # no se especifica `columna`, por lo que se usa el valor por defecto
  # `nombre_comuna`, que no existe en `datos_prueba`
  expect_error(
    datos_prueba |> buscar_comuna("iquique")
  )
}) |>
  suppressMessages()

test_that("buscar_comuna exige el argumento datos", {
  expect_error(
    buscar_comuna(texto = "iquique")
  )
}) |>
  suppressMessages()

test_that("buscar_comuna respeta el argumento cantidad", {
  # buscamos algo que tenga muchas matches
  resultados_inf <- territorios |> buscar_comuna("a", cantidad = Inf)
  resultados_limit <- territorios |> buscar_comuna("a", cantidad = 5)

  expect_equal(nrow(resultados_limit), 5)
  expect_true(nrow(resultados_inf) >= 5)
}) |>
  suppressMessages()

