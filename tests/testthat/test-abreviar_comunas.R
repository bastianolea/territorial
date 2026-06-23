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
