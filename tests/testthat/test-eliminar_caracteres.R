test_that("eliminar caracteres", {
  expect_true(
    any(comunas() != eliminar_texto(comunas()))
  )
})

# territorios |>
#   dplyr::select(nombre_comuna) |>
#   dplyr::mutate(
#     nombre_comuna = eliminar_texto(nombre_comuna, porcentaje = 0.1)
#   )

test_that("eliminar_texto conserva NA y textos cortos, y acorta textos largos", {
  resultado <- eliminar_texto(c(NA, "a", "mapache"), porcentaje = 0.3)

  expect_true(is.na(resultado[1]))
  expect_equal(resultado[2], "a")
  expect_lt(nchar(resultado[3]), nchar("mapache"))
})
