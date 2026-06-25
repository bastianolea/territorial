test_that("limpieza de texto", {
  expect_equal(
    limpiar_texto("hóLañAñë/():,"),
    "holanane"
  )
})

test_that("limpieza de texto 2", {
  expect_equal(
    limpiar_texto("O´HIGGINS"),
    "ohiggins"
  )
})

test_that("limpieza de texto 3", {
  expect_equal(
    limpiar_texto("O'HIGGINS"),
    "ohiggins"
  )
})
