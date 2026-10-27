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
}) |>
  suppressMessages()

test_that("convertir cualquier cosa a códigos de comuna", {
  expect_equal(
    as_codigo_comuna(
      c("Hola", "Perrito", "Mapache")
    ) |>
      suppressWarnings(),
    as.numeric(c(NA, NA, NA))
  )
}) |>
  suppressMessages()


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
}) |>
  suppressMessages()


test_that("convertir nombres de comuna no existentes arroja warning", {
  expect_warning(
    as_codigo_comuna(
      "Puente Altosh"
    )
  )
}) |>
  suppressMessages()


test_that("warning de nombres de comuna no existentes tiene sentido", {
  expect_warning(
    as_codigo_comuna(
      c("La Florida", "Puente Altosh", "Iquique", "Mapache")
    ),
    regexp = "Puente Altosh y Mapache"
  )
}) |>
  suppressMessages()


test_that("warning recomienda limpiar_comunas()", {
  expect_warning(
    as_codigo_comuna(
      "Puente Altosh"
    ),
    regexp = "limpiar_comunas"
  )
}) |>
  suppressMessages()


# test_that("mensaje indica cantidad de NA obtenidos", {
#   expect_message(
#     as_codigo_comuna(
#       c("La Florida", "Mapache", NA)
#     ) |>
#       suppressWarnings(),
#     regexp = "2 valores perdidos"
#   )
# })

test_that("NAs de entrada no arrojan warning", {
  expect_no_warning(
    as_codigo_comuna(
      c(NA, "La Florida")
    ) |>
      suppressMessages()
  )
})


test_that("warning no incluye NAs de entrada", {
  expect_warning(
    as_codigo_comuna(
      c(NA, "La Florida", "Mapache")
    ),
    regexp = "correctamente: Mapache\\."
  )
}) |>
  suppressMessages()


test_that("nombres de comuna válidos no arrojan mensajes ni warnings", {
  expect_silent(
    as_codigo_comuna(
      c("La Florida", "Iquique", "Mejillones")
    )
  )
})
