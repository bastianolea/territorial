test_that("ordenar regiones pero faltan columnas", {
  expect_error(
    ordenar_regiones(
      data.frame(nombre_region = "prueba")
    )
  )
})


test_that("ordenar regiones retorna factor", {
  expect_s3_class(
    ordenar_regiones(
      territorial::territorios
    )$nombre_region,
    "factor"
  )
})

test_that("ordenar regiones no cambia estructura de tabla", {
  expect_equal(
    dim(ordenar_regiones(territorial::territorios)),
    dim(territorial::territorios)
  )
})
