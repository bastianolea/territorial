test_that("ubicar provincias, más de una", {
  expect_equal(
    ubicar_provincias(c("Iquique", "Santiago")),
    c("Tarapacá", "Metropolitana de Santiago")
  )
})

test_that("ubicar provincias, más de una, con NA", {
  expect_equal(
    ubicar_provincias(c("Iquique", "Santiago", NA)),
    c("Tarapacá", "Metropolitana de Santiago", NA)
  )
})

test_that("ubicar provincias por código de provincia, con NA", {
  codigos <- as_codigo_provincia(c("Iquique", "Santiago"))
  expect_equal(
    ubicar_provincias(c(codigos, NA)),
    c("Tarapacá", "Metropolitana de Santiago", NA)
  )
})

test_that("ubicar provincias por código entero funciona igual que numérico", {
  codigos <- as_codigo_provincia(c("Iquique", "Santiago"))
  expect_equal(
    ubicar_provincias(as.integer(codigos)),
    ubicar_provincias(codigos)
  )
})

test_that("nombres y códigos de las mismas provincias dan el mismo resultado", {
  expect_equal(
    ubicar_provincias(c("Iquique", "Chiloé")),
    ubicar_provincias(as_codigo_provincia(c("Iquique", "Chiloé")))
  )
})

test_that("el prefijo 'Provincia de' y 'Provincia del' es ignorado", {
  expect_equal(
    ubicar_provincias("Provincia de Chiloé"),
    ubicar_provincias("Chiloé")
  )
  expect_equal(
    ubicar_provincias("Provincia del Tamarugal"),
    "Tarapacá"
  )
})

test_that("nombres sin tildes y en mayúsculas o minúsculas dan el mismo resultado", {
  expect_equal(
    ubicar_provincias(c("chiloe", "IQUIQUE")),
    ubicar_provincias(c("Chiloé", "Iquique"))
  )
})

test_that("provincias distintas de una misma región devuelven la misma región", {
  expect_equal(
    ubicar_provincias(c("Santiago", "Cordillera")),
    c("Metropolitana de Santiago", "Metropolitana de Santiago")
  )
})

test_that("el largo y el orden de la entrada se conservan, incluyendo duplicados", {
  expect_equal(
    ubicar_provincias(c("Iquique", "Chiloé", "Iquique")),
    c("Tarapacá", "Los Lagos", "Tarapacá")
  )
})

test_that("nombres y códigos válidos, y NAs de entrada, no arrojan warnings", {
  expect_no_warning(ubicar_provincias(c("Iquique", "Santiago", NA)))
  expect_no_warning(ubicar_provincias(as_codigo_provincia(c("Iquique", NA))))
})

test_that("entrada solo con NA devuelve NA sin warnings", {
  expect_no_warning(res <- ubicar_provincias(NA))
  expect_equal(res, NA_character_)
})

test_that("entrada vacía devuelve vector vacío", {
  expect_equal(ubicar_provincias(character(0)), character(0))
})

test_that("códigos no existentes se convierten a NA con warning, pero no NAs de entrada", {
  codigo_iquique <- as_codigo_provincia("Iquique")
  expect_warning(
    res <- ubicar_provincias(c(codigo_iquique, NA, 99999)),
    regexp = "región: 99999$"
  )
  expect_equal(res, c("Tarapacá", NA, NA))
})

test_that("nombres no reconocidos arrojan warning", {
  expect_warning(
    res <- ubicar_provincias(c("Iquique", "Santiagoo")),
    regexp = "Santiagoo"
  )
  expect_equal(res, c("Tarapacá", NA))
})

test_that("varios nombres no reconocidos aparecen juntos en el warning", {
  expect_warning(
    res <- ubicar_provincias(c("Santiagoo", "Iquiquee")),
    regexp = "Santiagoo y Iquiquee$"
  )
  expect_equal(res, c(NA_character_, NA_character_))
})

test_that("ubicar provincias, sin argumentos, arroja error", {
  expect_error(ubicar_provincias())
})
