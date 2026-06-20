test_that("cantidad de regiones correcta", {
  expect_length(
    territorial::regiones(),
    16
  )
})
