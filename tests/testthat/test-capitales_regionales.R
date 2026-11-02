test_that("número de capitales regionales", {
  expect_equal(
    nrow(capitales_regionales()),
    16
  )
})
