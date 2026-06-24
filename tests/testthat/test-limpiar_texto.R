test_that("limpieza de texto", {
  expect_equal(
    limpiar_texto("hóLañAñë/():,"),
    "holanane"
  )
})
