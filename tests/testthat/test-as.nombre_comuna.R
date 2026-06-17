test_that("convertir códigos de comuna a nombres de comuna", {
  expect_equal(
    as.nombre_comuna(
      c(1401, 1403, 9999999, 1404)
    ),
    c("Pozo Almonte", "Colchane", NA, "Huara")
    )
})


test_that("convertir NAs a nombres de comuna", {
  expect_equal(
    as.nombre_comuna(
      c(NA, 1401)
    ),
    c(NA, "Pozo Almonte")
  )
})


test_that("convertir texto a nombres de comuna cuando debería ser numérico", {
  expect_error(
    as.nombre_comuna(
      c("hola", "basty", NA)
    )
  )
})

