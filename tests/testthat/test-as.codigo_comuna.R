test_that("convertir nombres de comuna a códigos de comuna", {
  expect_equal(
    as.codigo_comuna(
      c("Mejillones", "Hola", "Iquique", "Perrito")
    ),
    c(2102, NA, 1101, NA)
  )
})

test_that("convertir cualquier cosa a códigos de comuna", {
  expect_equal(
    as.codigo_comuna(
      c("Hola", "Perrito", "Mapache")
    ),
    as.numeric(c(NA, NA, NA))
  )
})




