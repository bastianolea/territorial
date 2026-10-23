test_that("ubicar localidades retorna la comuna correcta para coincidencia exacta única", {
  resultado <- ubicar_localidades("La Dormida", procedimiento = FALSE)
  expect_equal(resultado, "Olmué")
}) |>
  suppressMessages()

test_that("ubicar localidades retorna la localidad con mayor población cuando hay múltiples coincidencias exactas", {
  expect_equal(
    ubicar_localidades("La Boca", procedimiento = FALSE),
    "Navidad"
  )
  expect_equal(
    ubicar_localidades("Pomaire", procedimiento = FALSE),
    "Melipilla"
  )
  expect_equal(
    ubicar_localidades("El Alfalfal", procedimiento = FALSE),
    "San José de Maipo"
  )
  expect_equal(
    ubicar_localidades("El Ingenio", procedimiento = FALSE),
    "San José de Maipo"
  )
}) |>
  suppressMessages()

test_that("ubicar localidades acepta un vector de localidades y retorna un vector de comunas en el mismo orden", {
  expect_equal(
    ubicar_localidades(c("La Boca", "Pomaire"), procedimiento = FALSE),
    c("Navidad", "Melipilla")
  )
  expect_equal(
    ubicar_localidades(c("Pomaire", "La Boca"), procedimiento = FALSE),
    c("Melipilla", "Navidad")
  )
}) |>
  suppressMessages()


test_that("ubicar localidades búsqueda sin mayúsculas y minúsculas", {
  expect_equal(
    ubicar_localidades("la boca", procedimiento = FALSE),
    "Navidad"
  )
  expect_equal(
    ubicar_localidades("LA BOCA", procedimiento = FALSE),
    "Navidad"
  )
  expect_equal(
    ubicar_localidades("La Dormida", procedimiento = FALSE),
    "Olmué"
  )
}) |>
  suppressMessages()

test_that("ubicar localidades filtra por región cuando se especifica nombre_region", {
  resultado <- ubicar_localidades(
    "Alfalfal",
    nombre_region = "Metropolitana de Santiago",
    procedimiento = FALSE
  ) |>
    suppressWarnings()
  expect_equal(resultado, "San José de Maipo")
}) |>
  suppressMessages()

test_that("ubicar localidades lanza un error si no se encuentra ninguna localidad", {
  expect_error(
    ubicar_localidades(
      "xyzlocalidadinexistente123",
      procedimiento = FALSE
    ) |>
      suppressWarnings()
  )
}) |>
  suppressMessages()
