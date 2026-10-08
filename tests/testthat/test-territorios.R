test_that("cantidad de filas de dataframe territorios", {
  expect_equal(
    nrow(territorios),
    346
  )
})


test_that("columnas de dataframe territorios", {
  expect_equal(
    # solamente pueden haber comunas con "nombre" y "codigo"
    territorios |>
      dplyr::select(
        -dplyr::starts_with("codigo"),
        -dplyr::starts_with("nombre")
      ) |>
      length(),
    0
  )
})
