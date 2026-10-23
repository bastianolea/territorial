test_that("contextualizar datos de nivel territorial desde codigo_comuna", {
  expect_no_error(
    {
      datos <- dplyr::tibble(
        codigo_comuna = c(1101, 13101, 1401),
        valor = c(1, 2, 3)
      )

      datos |>
        contextualizar(codigo_comuna)
    }
  )
}) |>
  suppressMessages()

test_that("contextualizar datos de nivel territorial desde nombre_comuna", {
  expect_no_error(
    {
      datos <- dplyr::tibble(
        nombre_comuna = c("Cerrillos", "Arica", "Putre"),
        valor = c(1, 2, 3)
      )

      datos |>
        contextualizar(nombre_comuna)
    }
  )
}) |>
  suppressMessages()


test_that("contextualizar datos de nivel territorial con más de una definida debe arrojar error", {
  expect_error(
    {
      datos <- dplyr::tibble(
        codigo_comuna = c(13102, 15101, 15201),
        nombre_comuna = c("Cerrillos", "Arica", "Putre"),
        valor = c(1, 2, 3)
      )

      datos |>
        contextualizar(variable = c("nombre_comuna", "codigo_comuna"))
    }
  )
}) |>
  suppressMessages()


test_that("contextualizar datos de nivel territorial con una variable territorial cuando existen otras también", {
  expect_no_error(
    {
      datos <- dplyr::tibble(
        codigo_comuna = c(13102, 15101, 15201),
        nombre_comuna = c("Cerrillos", "Arica", "Putre"),
        valor = c(1, 2, 3)
      )

      datos |>
        contextualizar(nombre_comuna) |>
        suppressWarnings()
    }
  )
}) |>
  suppressMessages()


test_that("contextualizar datos de nivel territorial cuando no existe la variable", {
  expect_error(
    {
      datos <- dplyr::tibble(
        codigo_comuna = c(13102, 15101, 15201),
        nombre_comuna = c("Cerrillos", "Arica", "Putre"),
        valor = c(1, 2, 3)
      )

      datos |>
        contextualizar(nombrecito)
    }
  )
}) |>
  suppressWarnings() |>
  suppressMessages()


test_that(
  "contextualizar sin especificar columna, con nombre_comuna presente",
  expect_no_error(
    dplyr::tibble(
      nombre_comuna = c("Cerrillos", "Arica", "Putre"),
      valor = c(1, 2, 3)
    ) |>
      contextualizar()
  )
) |>
  suppressMessages()


test_that(
  "contextualizar sin especificar columna, sin nombre_comuna, debe arrojar error",
  expect_error(
    dplyr::tibble(
      codigo_comuna = c(1101, 13101, 1401),
      valor = c(1, 2, 3)
    ) |>
      contextualizar()
  )
) |>
  suppressMessages()


test_that(
  "contextualizar sin especificar columna avisa que asume nombre_comuna",
  expect_message(
    dplyr::tibble(
      nombre_comuna = "Cerrillos",
      valor = 1
    ) |>
      contextualizar(),
    regexp = "nombre_comuna"
  )
) |>
  suppressMessages()


# tests de estructura del output

datos_test <- dplyr::tibble(
  nombre_comuna = c("Cerrillos", "Arica", "Putre"),
  valor = c(1, 2, 3)
)

resultado_test <- datos_test |>
  contextualizar() |>
  suppressMessages()

test_that("contextualizar agrega todas las variables territoriales", {
  columnas_territoriales <- c(
    "codigo_region",
    "nombre_region",
    "codigo_provincia",
    "nombre_provincia",
    "codigo_comuna",
    "nombre_comuna"
  )
  expect_true(all(columnas_territoriales %in% names(resultado_test)))
})

test_that("contextualizar ubica las variables territoriales al inicio", {
  columnas_territoriales <- c(
    "codigo_region",
    "nombre_region",
    "codigo_provincia",
    "nombre_provincia",
    "codigo_comuna",
    "nombre_comuna"
  )
  expect_equal(names(resultado_test)[1:6], columnas_territoriales)
})

test_that("contextualizar conserva las columnas originales", {
  expect_true(all(names(datos_test) %in% names(resultado_test)))
})

test_that("contextualizar conserva el número de filas", {
  expect_equal(nrow(resultado_test), nrow(datos_test))
})

test_that("contextualizar produce más columnas que el input", {
  expect_gt(ncol(resultado_test), ncol(datos_test))
})


test_that("contextualizar con codigo_comuna como character arroja error", {
  expect_error(
    dplyr::tibble(
      codigo_comuna = c("13101", "15101"),
      valor = c(1, 2)
    ) |>
      contextualizar(codigo_comuna) |>
      suppressMessages(),
    regexp = "numérica"
  )
}) |>
  suppressMessages()


test_that("contextualizar con múltiples variables arroja error claro", {
  expect_error(
    dplyr::tibble(
      codigo_comuna = c(13101, 15101),
      nombre_comuna = c("Cerrillos", "Arica"),
      valor = c(1, 2)
    ) |>
      contextualizar(variable = c("nombre_comuna", "codigo_comuna")),
    regexp = "solo una variable"
  )
})


test_that("contextualizar avisa cuando hay filas sin match en el catálogo", {
  expect_warning(
    dplyr::tibble(
      nombre_comuna = c("Cerrillos", "Perrito"),
      valor = c(1, 2)
    ) |>
      contextualizar(),
    regexp = "coincid"
  )
}) |>
  suppressMessages()
