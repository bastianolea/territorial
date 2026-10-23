test_that("convertir nombre de comuna a código de comuna", {
  expect_equal(
    as_codigo_comuna("La Florida"),
    13110
  )
})

test_that("convertir varios nombres de comuna a códigos de comuna", {
  expect_equal(
    as_codigo_comuna(
      c("Mejillones", "Hola", "Iquique", "Perrito")
    ) |>
      suppressWarnings(),
    c(2102, NA, 1101, NA)
  )
})

test_that("convertir cualquier cosa a códigos de comuna", {
  expect_equal(
    as_codigo_comuna(
      c("Hola", "Perrito", "Mapache")
    ) |>
      suppressWarnings(),
    as.numeric(c(NA, NA, NA))
  )
})


test_that("convertir números a códigos de comuna", {
  expect_error(
    as_codigo_comuna(
      c(1101)
    )
  )
})

test_that("convertir missings a códigos de comuna", {
  expect_equal(
    as_codigo_comuna(
      c(NA, NA, NA)
    ) |>
      suppressWarnings(),
    as.numeric(c(NA, NA, NA))
  )
})
