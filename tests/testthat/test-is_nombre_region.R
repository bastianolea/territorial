test_that("confirmar nombre de región", {
  expect_true(
    is_nombre_region("Maule")
  )
})

test_that("confirmar nombre incorrecto de región", {
  expect_false(
    is_nombre_region("Niuble")
  )
})


test_that("confirmar nombre de región pero con errorr", {
  expect_error(
    is_nombre_region(1234)
  )
})
