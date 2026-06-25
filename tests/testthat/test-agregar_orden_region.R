test_that("funcion orden región: Arica", {
  expect_equal(
    agregar_orden_region(15),
    1
  )
})

test_that("funcion orden región: Magallanes", {
  expect_equal(
    agregar_orden_region(12),
    16
  )
})

test_that("funcion orden región: Magallanes", {
  expect_equal(
    agregar_orden_region(12),
    16
  )
})

test_that("funcion orden región aplicada a dataframe", {
  expect_no_error(
    territorial::territorios |>
      dplyr::select(ends_with("region")) |>
      dplyr::distinct() |>
      dplyr::mutate(orden_region = agregar_orden_region(codigo_region)) |>
      dplyr::arrange(orden_region)
  )
})
