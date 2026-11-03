test_that("confirmar capitales regionales válidos", {
  expect_true(is_capital_regional(13101))
  expect_true(is_capital_regional("Arica"))
  expect_true(all(is_capital_regional(
    capitales_regionales()$nombre_comuna
  )))
})

test_that("rechazar capitales regionales inválidas", {
  expect_false(is_capital_regional(0))
  expect_false(is_capital_regional("La Florida"))
})
