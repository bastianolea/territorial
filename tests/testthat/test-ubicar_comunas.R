test_that("ubicar comunas, más de una", {
  expect_equal(
    ubicar_comunas(c("Cerrillos", "Navidad")),
    c("Metropolitana de Santiago", "Libertador General Bernardo O'Higgins")
  )
})

test_that("ubicar comunas, más de una, con NA", {
  expect_equal(
    ubicar_comunas(c("Cerrillos", "Navidad", NA)),
    c("Metropolitana de Santiago", "Libertador General Bernardo O'Higgins", NA)
  )
})

test_that("ubicar comunas por código de comuna, con NA", {
  expect_equal(
    ubicar_comunas(c(1101, 13103, NA)),
    c("Tarapacá", "Metropolitana de Santiago", NA)
  )
})

test_that("nombres y códigos de las mismas comunas dan el mismo resultado", {
  expect_equal(
    ubicar_comunas(c("Iquique", "La Florida")),
    ubicar_comunas(c(1101, 13110))
  )
})

test_that("códigos y nombres válidos, y NAs de entrada, no arrojan warnings", {
  expect_no_warning(ubicar_comunas(c(1101, 13103, NA)))
  expect_no_warning(ubicar_comunas(c("Cerrillos", "Navidad", NA)))
})

test_that("códigos no existentes se convierten a NA con warning, pero no NAs de entrada", {
  expect_warning(
    res <- ubicar_comunas(c(1101, NA, 99999)),
    regexp = "región: 99999$"
  )
  expect_equal(res, c("Tarapacá", NA, NA))
})

test_that("nombres no reconocidos arrojan warning", {
  expect_warning(
    res <- ubicar_comunas(c("Cerrillos", "Puente Altosh")),
    regexp = "Puente Altosh"
  )
  expect_equal(res, c("Metropolitana de Santiago", NA))
})

test_that("ubicar comunas, sin argumentos", {
  expect_error(
    ubicar_comunas()
  )
})
