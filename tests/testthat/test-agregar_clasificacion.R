test_that("agregar clasificación comunal", {
  expect_equal(
    agregar_clasificacion(8107) |> as.character(),
    "Mixta"
  )
})


test_that("agregar clasificación comunal con varias y NA", {
  datos <- agregar_clasificacion(
    c(5605, 13122, 8207, 13101, 12201, 5601, 000000)
  ) |>
    as.character()

  expect_equal(
    datos,
    c("Mixta", "Urbana", "Rural", "Urbana", "Rural", "Urbana", NA)
  )
})

test_that("orden de clasificación comunal", {
  datos <- dplyr::tibble(
    clasificacion = agregar_clasificacion(
      c(5605, 13122, 8207, 13101, 12201, 5601)
    )
  ) |>
    dplyr::count(clasificacion) |>
    dplyr::pull(clasificacion) |>
    as.character()

  expect_equal(
    datos,
    c("Rural", "Mixta", "Urbana")
  )
})
