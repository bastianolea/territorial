test_that("contextualizar datos de nivel territorial desde codigo_comuna", {
  expect_no_error(
    {
      datos <- dplyr::tribble(
        ~codigo_comuna , ~valor ,
                  1101 ,      1 ,
                 13101 ,      2 ,
                  1401 ,      3
      )

      datos |>
        contextualizar(codigo_comuna) |>
        suppressMessages()
    }
  )
})

test_that("contextualizar datos de nivel territorial desde nombre_comuna", {
  expect_no_error(
    {
      datos <- dplyr::tribble(
        ~nombre_comuna , ~valor ,
        "Cerrillos"    ,      1 ,
        "Arica"        ,      2 ,
        "Putre"        ,      3
      )

      datos |>
        contextualizar(nombre_comuna) |>
        suppressMessages()
    }
  )
})


test_that("contextualizar datos de nivel territorial con más de una definida debe arrojar error", {
  expect_error(
    {
      datos <- dplyr::tribble(
        ~codigo_comuna , ~nombre_comuna , ~valor ,
                 13102 , "Cerrillos"    ,      1 ,
                 15101 , "Arica"        ,      2 ,
                 15201 , "Putre"        ,      3
      )

      datos |>
        contextualizar(variable = c("nombre_comuna", "codigo_comuna"))
    }
  )
})


test_that("contextualizar datos de nivel territorial con una variable territorial cuando existen otras también", {
  expect_no_error(
    {
      datos <- dplyr::tribble(
        ~codigo_comuna , ~nombre_comuna , ~valor ,
                 13102 , "Cerrillos"    ,      1 ,
                 15101 , "Arica"        ,      2 ,
                 15201 , "Putre"        ,      3
      )

      datos |>
        contextualizar(nombre_comuna) |>
        suppressWarnings() |>
        suppressMessages()
    }
  )
})


test_that("contextualizar datos de nivel territorial cuando no existe la variable", {
  expect_error(
    {
      datos <- dplyr::tribble(
        ~codigo_comuna , ~nombre_comuna , ~valor ,
                 13102 , "Cerrillos"    ,      1 ,
                 15101 , "Arica"        ,      2 ,
                 15201 , "Putre"        ,      3
      )

      datos |>
        contextualizar(nombrecito) |>
        suppressWarnings() |>
        suppressMessages()
    }
  )
})
