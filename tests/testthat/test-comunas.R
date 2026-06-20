test_that("cantidad de comunas correcta", {
  expect_length(
    territorial::comunas(),
    346
  )
})
