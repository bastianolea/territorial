test_that("convertir códigos de región a capitales regionales", {
  expect_equal(
    as_capital_regional(
      c(13, 14, 15)
    ),
    c("Santiago", "Valdivia", "Arica")
  )
})


test_that("códigos no existentes y NAs se convierten a NA", {
  expect_equal(
    as_capital_regional(
      c(1, 2, 3, NA, 9999)
    ) |>
      suppressWarnings(),
    c("Iquique", "Antofagasta", "Copiapó", NA, NA)
  )
})


test_that("warning menciona códigos no existentes, pero no NAs de entrada", {
  expect_warning(
    as_capital_regional(
      c(1, 2, 3, NA, 9999)
    ),
    regexp = "regionales: 9999$"
  )
})


test_that("convertir nombres de región a capitales regionales", {
  expect_equal(
    as_capital_regional(
      c("Maule", "Ñuble")
    ),
    c("Talca", "Chillán")
  )
}) |>
  suppressMessages()


test_that("códigos válidos y NAs de entrada no arrojan warnings", {
  expect_no_warning(
    as_capital_regional(
      c(NA, 1:16)
    )
  )
})
