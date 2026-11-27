test_that("artículos de región funciona", {
  expect_equal(
    preposicion_region(
      c("Ñuble", "Biobío", "Metropolitana", "Santiago")
    ),
    c("de", "del", "", "de")
  )
})


test_that("artículos de región funciona con nombres no estándar", {
  expect_equal(
    preposicion_region(
      c("O'Higgins", "Araucanía", "Lagos")
    ),
    c("de", "de la", "de los")
  )
})

test_that("preposicion_region falla si no recibe texto", {
  expect_error(preposicion_region(1), "texto")
})

test_that("preposicion_region entrega todas las variantes de preposición", {
  expect_equal(
    preposicion_region(c("Maule", "Metropolitana", "Araucanía", "Lagos")),
    c("del", "", "de la", "de los")
  )
})
