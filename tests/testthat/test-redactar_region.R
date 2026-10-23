test_that("redacción de regiones funciona", {
  expect_equal(
    redactar_region(c("Maule", "Ñuble")),
    c("Región del Maule", "Región de Ñuble")
  )
})

test_that("redacción de regiones numéricas", {
  expect_error(
    redactar_region(c(15, 1))
  )
})


test_that("redacción de regiones en factor", {
  expect_no_error(
    territorios |>
      dplyr::select(dplyr::ends_with("region")) |>
      dplyr::distinct() |>
      ordenar_regiones() |>
      dplyr::mutate(texto = redactar_region(nombre_region)) |>
      suppressWarnings()
  )
})

test_that(
  "redacción de regiones error con dataframe",
  expect_error(
    territorios |>
      redactar_region()
  )
)
