test_that("redacción de regiones funciona", {
  expect_equal(
    redactar_region(c("Maule", "Ñuble")),
    c("Región del Maule", "Región de Ñuble")
  )
})
