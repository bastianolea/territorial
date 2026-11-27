test_that("reemplazar caracteres", {
  expect_true(
    any(comunas() != reemplazar_texto(comunas()))
  )
})

# territorios |>
#   dplyr::select(nombre_comuna) |>
#   dplyr::mutate(
#     nombre_comuna = reemplazar_texto(nombre_comuna, porcentaje = 0.1)
#   )

test_that("reemplazar_texto conserva NA y textos cortos, y mantiene el largo", {
  resultado <- reemplazar_texto(c(NA, "a", "mapache"), porcentaje = 0.3)

  expect_true(is.na(resultado[1]))
  expect_equal(resultado[2], "a")
  expect_equal(nchar(resultado[3]), nchar("mapache"))
})
