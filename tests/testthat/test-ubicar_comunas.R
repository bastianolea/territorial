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
