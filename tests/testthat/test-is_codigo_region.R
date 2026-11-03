test_that("confirmar códigos de región válidos", {
  expect_true(is_codigo_region(1))
  expect_true(is_codigo_region(16))
  expect_true(all(is_codigo_region(1:16)))
})

test_that("rechazar códigos de región inválidos", {
  expect_false(is_codigo_region(0))
  expect_false(is_codigo_region("Maule"))
})
