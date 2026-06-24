test_that("confirmar un código de comuna", {
  expect_true(
    is_codigo_comuna(1101)
  )
})

test_that("probar error al confirmar código de comuna", {
  expect_error(
    is_codigo_comuna("1234")
  )
})
