test_that("cantidad de filas de dataframe territorios", {
  expect_equal(
    nrow(comunal::territorios),
    346
  )
})


test_that("columnas de dataframe territorios", {
  expect_equal(
    # solamente pueden haber comunas con "nombre" y "codigo"
    comunal::territorios |>
      dplyr::select(
        -starts_with("codigo"),
        -starts_with("nombre")
      ) |>
      length(),
    0
  )
})
