test_that("ordenar regiones funciona (Arica sale primero)", {
  regiones <- dplyr::tribble(
    ~codigo_region , ~nombre_region                              ,
                 1 , "Tarapacá"                                  ,
                 2 , "Antofagasta"                               ,
                 3 , "Atacama"                                   ,
                 4 , "Coquimbo"                                  ,
                 5 , "Valparaíso"                                ,
                 6 , "Libertador General Bernardo O'Higgins"     ,
                 7 , "Maule"                                     ,
                 8 , "Biobío"                                    ,
                 9 , "La Araucanía"                              ,
                10 , "Los Lagos"                                 ,
                11 , "Aysén del General Carlos Ibáñez del Campo" ,
                12 , "Magallanes y de la Antártica Chilena"      ,
                13 , "Metropolitana de Santiago"                 ,
                14 , "Los Ríos"                                  ,
                15 , "Arica y Parinacota"                        ,
                16 , "Ñuble"
  )

  expect_equal(
    regiones |>
      ordenar_regiones() |>
      dplyr::slice(1) |>
      dplyr::pull(nombre_region) |>
      as.character(),
    "Arica y Parinacota"
  )
})


test_that("ordenar regiones pero faltan columnas", {
  expect_error(
    ordenar_regiones(
      data.frame(nombre_region = "prueba", stringsAsFactors = FALSE)
    )
  )
})


test_that("ordenar regiones retorna factor", {
  expect_s3_class(
    ordenar_regiones(
      territorios
    )$nombre_region,
    "factor"
  )
})

test_that("ordenar regiones no cambia estructura de tabla", {
  expect_equal(
    dim(ordenar_regiones(territorios)),
    dim(territorios)
  )
})


test_that("ordenar regiones con invertir = TRUE deja la región más austral primero", {
  regiones <- dplyr::tribble(
    ~codigo_region , ~nombre_region                              ,
                 1 , "Tarapacá"                                  ,
                 2 , "Antofagasta"                               ,
                 3 , "Atacama"                                   ,
                 4 , "Coquimbo"                                  ,
                 5 , "Valparaíso"                                ,
                 6 , "Libertador General Bernardo O'Higgins"     ,
                 7 , "Maule"                                     ,
                 8 , "Biobío"                                    ,
                 9 , "La Araucanía"                              ,
                10 , "Los Lagos"                                 ,
                11 , "Aysén del General Carlos Ibáñez del Campo" ,
                12 , "Magallanes y de la Antártica Chilena"      ,
                13 , "Metropolitana de Santiago"                 ,
                14 , "Los Ríos"                                  ,
                15 , "Arica y Parinacota"                        ,
                16 , "Ñuble"
  )

  primera_region <- regiones |>
    ordenar_regiones(invertir = TRUE) |>
    dplyr::slice(1) |>
    dplyr::pull(nombre_region) |>
    as.character()

  expect_equal(
    primera_region,
    "Magallanes y de la Antártica Chilena"
  )
})


test_that("ordenar regiones avisa si datos vienen agrupados", {
  regiones <- dplyr::tribble(
    ~codigo_region , ~nombre_region ,
                 1 , "Tarapacá"     ,
                 2 , "Antofagasta"
  )

  expect_warning(
    ordenar_regiones(
      dplyr::group_by(regiones, codigo_region)
    ),
    regexp = "agrupado"
  )
})

test_that("ordenar_regiones falla si no recibe un dataframe", {
  expect_error(ordenar_regiones(1), "dataframe")
})

test_that("ordenar_regiones falla si codigo_region no es numérico", {
  datos <- data.frame(codigo_region = "1", nombre_region = "Tarapacá")

  expect_error(ordenar_regiones(datos), "numérica")
})

test_that("ordenar_regiones advierte si los datos están agrupados", {
  datos_agrupados <- dplyr::group_by(territorios, nombre_region)

  expect_warning(
    resultado <- suppressMessages(ordenar_regiones(datos_agrupados)),
    "agrupados"
  )
  expect_false(dplyr::is_grouped_df(resultado))
})

test_that("ordenar_regiones con limpiar = FALSE conserva orden_region", {
  resultado <- suppressMessages(ordenar_regiones(territorios, limpiar = FALSE))

  expect_true("orden_region" %in% names(resultado))
})
