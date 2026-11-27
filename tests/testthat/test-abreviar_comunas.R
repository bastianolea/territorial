test_that("abreviaciones de comuna funcionan", {
  expect_no_error(
    abreviar_comunas(c("cerrillos", "la florida", "santiago", "puente alto"))
  )
})

test_that("abreviaciones de comuna retornan mismo largo", {
  expect_length(
    abreviar_comunas(territorial::comunas()),
    346
  )
})

test_that("abreviar_comunas falla si no recibe un vector", {
  expect_error(abreviar_comunas(data.frame(a = 1)), "vector")
})
