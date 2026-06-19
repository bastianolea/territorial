test_that("confirmar si confirma que es comuna", {
  expect_true(
    territorial::is.comuna("Panguipulli")
  )
})
