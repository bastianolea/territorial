test_that("confirmar si un código de comuna es válido", {
  expect_true(
    territorial::is_codigo_comuna(1101)
  )
})

test_that("confirmar si más de un código de comuna son válidos", {
  expect_equal(
    territorial::is_codigo_comuna(c(1101, 1102, 1107)),
    c(TRUE, FALSE, TRUE)
  )
})
