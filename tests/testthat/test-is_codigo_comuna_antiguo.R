test_that("revisar código de comuna antiguo", {
  expect_true(is_codigo_comuna_antiguo(1102))
})

test_that("revisar código de comuna normal", {
  expect_false(is_codigo_comuna_antiguo(1101))
})
