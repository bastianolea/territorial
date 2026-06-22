test_that("agregar clasificación comunal funciona", {
  expect_equal(
    agregar_clasificacion(8107),
    "Mixta"
  )
})


test_that("agregar clasificación comunal funciona con varias y NA", {
  expect_equal(
    agregar_clasificacion(
      c(5605, 13122, 8207, 13101, 12201, 5601, 000000)
      ),
    c("Mixta", "Urbana", "Rural", "Urbana", "Rural", "Urbana", NA )
  )
})
