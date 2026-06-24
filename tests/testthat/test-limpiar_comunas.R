test_that("prueba de limpieza de comunas", {
  expect_equal(
    limpiar_comunas(
      c("CERRILLOS", "la florida", "ñunoa", "nunoa")
    ),
    c("Cerrillos", "La Florida", "Ñuñoa", "Ñuñoa")
  )
})
