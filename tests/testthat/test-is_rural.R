test_that("identificar comunas rurales con códigos y nombres", {
  expect_true(is_rural(1401))
  expect_true(is_rural("Camiña"))
  expect_equal(is_rural(c(1401, 1402)), c(TRUE, TRUE))
})

test_that("comunas urbanas y mixtas no son rurales", {
  expect_false(is_rural(13101))
  expect_false(is_rural("Santiago"))
  # casablanca es mixta
  expect_false(is_rural(5102))
})

test_that("retorna NA para comunas inexistentes", {
  expect_true(is.na(is_rural(0)))
  expect_true(is.na(is_rural(NA_real_)))
})

test_that("retorna vector lógico del mismo largo", {
  entrada <- c(13101, NA, 1401, 5102, 0)
  resultado <- is_rural(entrada)

  expect_type(resultado, "logical")
  expect_length(resultado, length(entrada))
  expect_equal(resultado, c(FALSE, NA, TRUE, FALSE, NA))
})

test_that("concuerda con la tabla de clasificación", {
  esperado <- clasificacion$clasificacion == "Rural"
  expect_equal(is_rural(clasificacion$codigo_comuna), esperado)
  expect_equal(sum(is_rural(clasificacion$codigo_comuna)), 185)
})
