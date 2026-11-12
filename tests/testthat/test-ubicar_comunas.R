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

test_that("ubicar comunas en provincias con nivel = 'provincia'", {
  expect_equal(
    ubicar_comunas(c("Puente Alto", "Cerrillos", "Navidad"), nivel = "provincia"),
    c("Cordillera", "Santiago", "Cardenal Caro")
  )
})

test_that("ubicar comunas en provincias por código, con NA", {
  expect_equal(
    ubicar_comunas(c(1101, 13201, NA), nivel = "provincia"),
    c("Iquique", "Cordillera", NA)
  )
})

test_that("nivel explícito 'región' equivale al valor por defecto", {
  expect_equal(
    ubicar_comunas(c("Cerrillos", "Navidad"), nivel = "región"),
    ubicar_comunas(c("Cerrillos", "Navidad"))
  )
})

test_that("nivel no distingue mayúsculas", {
  expect_equal(
    ubicar_comunas("Puente Alto", nivel = "Provincia"),
    ubicar_comunas("Puente Alto", nivel = "provincia")
  )
})

test_that("nivel = 'provincia' no arroja warnings con entradas válidas y NA", {
  expect_no_warning(ubicar_comunas(c(1101, 13103, NA), nivel = "provincia"))
  expect_no_warning(ubicar_comunas(c("Cerrillos", NA), nivel = "provincia"))
})

test_that("códigos inexistentes con nivel = 'provincia' dan NA y warning que menciona el nivel", {
  expect_warning(
    res <- ubicar_comunas(c(1101, NA, 99999), nivel = "provincia"),
    regexp = "provincia: 99999$"
  )
  expect_equal(res, c("Iquique", NA, NA))
})

test_that("nombres no reconocidos con nivel = 'provincia' arrojan warning", {
  expect_warning(
    res <- ubicar_comunas(c("Cerrillos", "Puente Altosh"), nivel = "provincia"),
    regexp = "Puente Altosh"
  )
  expect_equal(res, c("Santiago", NA))
})

test_that("nivel inválido arroja error", {
  expect_error(ubicar_comunas("Cerrillos", nivel = "comuna"))
})
