test_that("agregar clasificación comunal", {
  expect_equal(
    agregar_clasificacion(8107) |> as.character(),
    "Mixta"
  )
})


test_that("agregar clasificación comunal con varias y NA", {
  datos <- agregar_clasificacion(
    c(5605, 13122, 8207, 13101, 12201, 5601, 000000)
  ) |>
    as.character()

  expect_equal(
    datos,
    c("Mixta", "Urbana", "Rural", "Urbana", "Rural", "Urbana", NA)
  )
})

test_that("orden de clasificación comunal", {
  datos <- dplyr::tibble(
    clasificacion = agregar_clasificacion(
      c(5605, 13122, 8207, 13101, 12201, 5601)
    )
  ) |>
    dplyr::count(clasificacion) |>
    dplyr::pull(clasificacion) |>
    as.character()

  expect_equal(
    datos,
    c("Rural", "Mixta", "Urbana")
  )
})

test_that("agregar_clasificacion funciona con data frames", {
  datos <- dplyr::tibble(codigo_comuna = c(5605, 13122, 8207), x = 1:3)

  resultado <- agregar_clasificacion(datos, ordenar = FALSE)
  expect_s3_class(resultado, "data.frame")
  expect_identical(names(resultado), c("codigo_comuna", "x", "clasificacion"))
  expect_identical(resultado$clasificacion, c("Mixta", "Urbana", "Rural"))

  # tablas agrupadas se desagrupan
  agrupada <- dplyr::group_by(datos, x)
  expect_false(dplyr::is_grouped_df(agregar_clasificacion(agrupada)))

  # con territorios
  expect_identical(
    agregar_clasificacion(territorios)$clasificacion,
    agregar_clasificacion(territorios$codigo_comuna)
  )

  # sin columnas válidas
  expect_error(
    agregar_clasificacion(dplyr::tibble(a = 1)),
    "codigo_comuna"
  )
})

test_that("agregar_clasificacion valida sus argumentos", {
  expect_error(agregar_clasificacion(list(8107)), "vector de códigos")

  # factores usan sus valores, no sus niveles
  expect_identical(
    agregar_clasificacion(factor(c(8107, 13122))) |> as.character(),
    c("Mixta", "Urbana")
  )
})
