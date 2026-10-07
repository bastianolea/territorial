test_that("acortar_regiones acorta región O'Higgins", {
  resultado <- acortar_regiones("Libertador Gral. Bernardo O'Higgins")
  expect_equal(resultado, "O'Higgins")
})

test_that("acortar_regiones acorta región Aysén", {
  resultado <- acortar_regiones("Aysén del General Carlos Ibáñez del Campo")
  expect_equal(resultado, "Aysén")
})

test_that("acortar_regiones acorta región Metropolitana", {
  resultado <- acortar_regiones("Región Metropolitana de Santiago")
  expect_equal(resultado, "Metropolitana")
})

test_that("acortar_regiones acorta región Magallanes", {
  resultado <- acortar_regiones("Magallanes y de la Antártica Chilena")
  expect_equal(resultado, "Magallanes")
})

test_that("acortar_regiones elimina 'Región de' correctamente", {
  resultado <- acortar_regiones("Región de Arica y Parinacota")
  expect_equal(resultado, "Arica y Parinacota")
})

test_that("acortar_regiones vectoriza correctamente", {
  nombres <- c(
    "Libertador Gral. Bernardo O'Higgins",
    "Aysén del General Carlos Ibáñez del Campo",
    "Región Metropolitana de Santiago"
  )
  resultado <- acortar_regiones(nombres)
  expect_equal(length(resultado), 3)
  expect_equal(resultado[1], "O'Higgins")
  expect_equal(resultado[2], "Aysén")
  expect_equal(resultado[3], "Metropolitana")
})

test_that("acortar_regiones maneja regiones sin cambios", {
  nombre <- "Los Lagos"
  resultado <- acortar_regiones(nombre)
  expect_equal(resultado, "Los Lagos")
})

test_that("acortar_regiones lanza error si input es numérico", {
  expect_error(
    acortar_regiones(1),
    "Se necesitan nombres de regiones en tipo caracter!"
  )
})

test_that("acortar_regiones valida longitud del resultado", {
  nombres <- c("Región de Arica y Parinacota", "Región de Tarapacá")
  resultado <- acortar_regiones(nombres)
  expect_equal(length(resultado), length(nombres))
})

# dataframes ----
test_that("acortar_regiones sin especificar columna retorna dataframe", {
  datos <- dplyr::tibble(
    nombre_region = c(
      "Libertador Gral. Bernardo O'Higgins",
      "Aysén del General Carlos Ibáñez del Campo"
    ),
    valores = c(4, 6)
  )

  resultado <- acortar_regiones(datos)

  expect_s3_class(resultado, "data.frame")
  expect_equal(resultado$nombre_region, c("O'Higgins", "Aysén"))
  expect_equal(resultado$valores, c(4, 6))
})

test_that("acortar_regiones desde dataframe con columna personalizada", {
  datos <- dplyr::tibble(
    region = c(
      "Región Metropolitana de Santiago",
      "Magallanes y de la Antártica Chilena"
    ),
    valores = c(1, 2)
  )

  resultado <- acortar_regiones(datos, region)

  expect_s3_class(resultado, "data.frame")
  expect_equal(resultado$region, c("Metropolitana", "Magallanes"))
})

test_that("acortar_regiones desde vector sigue retornando vector", {
  resultado <- acortar_regiones(c(
    "Región de Los Lagos",
    "Región de Valparaíso"
  ))
  expect_true(is.vector(resultado))
  expect_false(is.data.frame(resultado))
})

test_that("acortar_regiones con dataframe y columna que no existe lanza error", {
  datos <- dplyr::tibble(nombre_region = "Región de Los Lagos")

  expect_error(
    acortar_regiones(datos, nombre_mapache)
  )
})

test_that("acortar_regiones sin especificar columna, y no existe nombre_region, lanza error", {
  datos <- dplyr::tibble(region = "Región de Los Lagos")

  expect_error(
    acortar_regiones(datos)
  )
})

test_that("acortar_regiones no aplica a listas", {
  expect_error(
    acortar_regiones(list(
      regiones = c("Región de Los Lagos", "Región de Los Ríos")
    ))
  )
})

# factores ----
test_that("acortar_regiones funciona con vectores de tipo factor y advierte", {
  nombres <- factor(c(
    "Aysén del General Carlos Ibáñez del Campo",
    "Región Metropolitana de Santiago"
  ))

  expect_warning(
    resultado <- acortar_regiones(nombres),
    "formato factor"
  )
  expect_type(resultado, "character")
  expect_equal(resultado, c("Aysén", "Metropolitana"))
})

test_that("acortar_regiones funciona con columnas factor en dataframes y advierte", {
  datos <- dplyr::tibble(
    nombre_region = factor(c(
      "Aysén del General Carlos Ibáñez del Campo",
      "Región Metropolitana de Santiago"
    ))
  )

  expect_warning(
    resultado <- acortar_regiones(datos),
    "formato factor"
  )
  expect_type(resultado$nombre_region, "character")
  expect_equal(resultado$nombre_region, c("Aysén", "Metropolitana"))
})

test_that("acortar_regiones funciona tras ordenar_regiones() (columna factor)", {
  expect_warning(
    resultado <- territorios |>
      ordenar_regiones() |>
      dplyr::mutate(nombre_region_corto = acortar_regiones(nombre_region)) |>
      dplyr::distinct(nombre_region, nombre_region_corto),
    "formato factor"
  )

  expect_true(is.character(resultado$nombre_region_corto))
  expect_false(any(is.na(resultado$nombre_region_corto)))
})
