test_that("actualizar código comunal", {
  expect_equal(
    actualizar_codigo_comuna(c(1102, 8408)),
    c(1402, 16204)
  )
})

test_that("actualizar código comunal con NA", {
  expect_equal(
    actualizar_codigo_comuna(c(1102, NA)),
    c(1402, NA)
  )
})


test_that("actualizar código comunal que no es antiguo", {
  expect_message(
    actualizar_codigo_comuna(1101),
    "no son antiguos"
  )
})
