test_that("confirmar si un nombre de comuna es válido", {
  expect_true(
    territorial::is_nombre_comuna("Panguipulli")
  )
})

test_that("confirmar si más de un nombre de comuna son válidos", {
  expect_equal(
    territorial::is_nombre_comuna(c("Panguipulli", "Mapache", "La Florida")),
    c(TRUE, FALSE, TRUE)
  )
})
