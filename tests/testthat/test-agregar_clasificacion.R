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

test_that("agregar_clasificacion funciona con nombres de comunas", {
  nombres <- c("El Tabo", "Peñalolén", "Tirúa", "Santiago")

  expect_identical(
    agregar_clasificacion(nombres, ordenar = FALSE),
    c("Mixta", "Urbana", "Rural", "Urbana")
  )

  # equivale a usar los códigos de comuna
  expect_identical(
    agregar_clasificacion(nombres),
    agregar_clasificacion(c(5605, 13122, 8207, 13101))
  )
})

test_that("agregar_clasificacion con nombres entrega factor ordenado", {
  resultado <- agregar_clasificacion(c("Santiago", "Tirúa"))

  expect_s3_class(resultado, "factor")
  expect_identical(levels(resultado), c("Rural", "Mixta", "Urbana"))
})

test_that("agregar_clasificacion con nombres de comuna como factor", {
  expect_identical(
    agregar_clasificacion(factor(c("Santiago", "Tirúa")), ordenar = FALSE),
    c("Urbana", "Rural")
  )
})

test_that("agregar_clasificacion con nombres mantiene NA y advierte de no reconocidos", {
  # NA de entrada no genera advertencia
  expect_no_warning(
    resultado <- agregar_clasificacion(c("Santiago", NA), ordenar = FALSE)
  )
  expect_identical(resultado, c("Urbana", NA))

  # nombres inexistentes dan NA y advertencia
  expect_warning(
    resultado <- agregar_clasificacion(
      c("Santiago", "Comuna Inventada"),
      ordenar = FALSE
    ),
    "Comuna Inventada"
  )
  expect_identical(resultado, c("Urbana", NA))
})

test_that("agregar_clasificacion con nombres funciona dentro de data frames", {
  # la columna codigo_comuna con nombres de comuna también se convierte
  datos <- dplyr::tibble(codigo_comuna = c("Santiago", "Tirúa"))

  resultado <- agregar_clasificacion(datos, ordenar = FALSE)
  expect_identical(resultado$clasificacion, c("Urbana", "Rural"))
})

test_that("agregar_clasificacion valida sus argumentos", {
  expect_error(agregar_clasificacion(list(8107)), "vector de códigos")

  # factores usan sus valores, no sus niveles (niveles en orden inverso)
  expect_identical(
    agregar_clasificacion(
      factor(c("Santiago", "Tirúa"), levels = c("Tirúa", "Santiago"))
    ) |>
      as.character(),
    c("Urbana", "Rural")
  )
})
