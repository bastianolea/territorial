# niveles (de norte a sur) y asignaciones esperadas para cada tipo de macrozona
niveles_macrozonas <- list(
  c("Norte", "Centro", "Sur", "Austral"),
  c("Norte", "Centro", "Centro/sur", "Sur"),
  c("Norte", "Centro", "Metropolitana", "Centro sur", "Sur", "Austral"),
  c("Norte Grande", "Norte Chico", "Zona central", "Zona Sur", "Zona Austral"),
  c("Norte", "Centro", "Sur")
)

asignaciones_macrozonas <- list(
  c(
    "Norte",
    "Norte",
    "Norte",
    "Norte",
    "Centro",
    "Centro",
    "Centro",
    "Sur",
    "Sur",
    "Sur",
    "Austral",
    "Austral",
    "Centro",
    "Sur",
    "Norte",
    "Sur"
  ),
  c(
    "Norte",
    "Norte",
    "Norte",
    "Centro",
    "Centro",
    "Centro",
    "Centro/sur",
    "Centro/sur",
    "Centro/sur",
    "Sur",
    "Sur",
    "Sur",
    "Centro",
    "Sur",
    "Norte",
    "Centro/sur"
  ),
  c(
    "Norte",
    "Norte",
    "Norte",
    "Centro",
    "Centro",
    "Centro sur",
    "Centro sur",
    "Centro sur",
    "Sur",
    "Sur",
    "Austral",
    "Austral",
    "Metropolitana",
    "Sur",
    "Norte",
    "Centro sur"
  ),
  c(
    "Norte Grande",
    "Norte Grande",
    "Norte Chico",
    "Norte Chico",
    "Norte Chico",
    "Zona central",
    "Zona central",
    "Zona central",
    "Zona Sur",
    "Zona Sur",
    "Zona Austral",
    "Zona Austral",
    "Zona central",
    "Zona Sur",
    "Norte Grande",
    "Zona central"
  ),
  c(
    "Norte",
    "Norte",
    "Norte",
    "Norte",
    "Centro",
    "Centro",
    "Centro",
    "Centro",
    "Centro",
    "Sur",
    "Sur",
    "Sur",
    "Centro",
    "Centro",
    "Norte",
    "Centro"
  )
)

test_that("agregar_macrozona asigna y ordena correctamente todos los tipos", {
  for (tipo_n in 1:5) {
    info_tipo <- paste("tipo", tipo_n)
    asignacion <- asignaciones_macrozonas[[tipo_n]]
    niveles <- niveles_macrozonas[[tipo_n]]

    # ordenar = FALSE entrega los valores como caracter
    expect_identical(
      agregar_macrozona(1:16, tipo = tipo_n, ordenar = FALSE),
      asignacion,
      info = info_tipo
    )

    # ordenar = TRUE entrega factor con los mismos valores y niveles de norte a sur
    expect_identical(
      agregar_macrozona(1:16, tipo = tipo_n, ordenar = TRUE),
      factor(asignacion, levels = niveles),
      info = info_tipo
    )
  }
})

test_that("agregar_macrozona usa el tipo 1 por defecto", {
  expect_identical(
    agregar_macrozona(c(15, 13, 12), ordenar = FALSE),
    c("Norte", "Centro", "Austral")
  )
})

test_that("agregar_macrozona convierte códigos en caracter, con alerta", {
  expect_warning(
    resultado <- agregar_macrozona(
      c("15", "13", "12"),
      tipo = 1,
      ordenar = FALSE
    )
  )
  expect_equal(resultado, c("Norte", "Centro", "Austral"))
})

test_that("agregar_macrozona convierte nombres de región", {
  expect_identical(
    agregar_macrozona(
      c("Arica y Parinacota", "Metropolitana de Santiago", "Magallanes"),
      ordenar = FALSE
    ),
    c("Norte", "Centro", "Austral")
  )

  # insensible a mayúsculas y tildes, y acepta factores
  expect_identical(
    agregar_macrozona(c("BIOBÍO", "Ñuble"), tipo = 2, ordenar = FALSE),
    c("Centro/sur", "Centro/sur")
  )
  expect_identical(
    agregar_macrozona(factor(c("Maule", "Los Lagos")), ordenar = FALSE),
    c("Centro", "Sur")
  )

  # resultado igual al de los códigos equivalentes
  expect_identical(
    agregar_macrozona(c("Tarapacá", "Maule"), tipo = 3),
    agregar_macrozona(c(1, 7), tipo = 3)
  )
})

test_that("agregar_macrozona conserva NA y acepta valores mixtos", {
  expect_identical(
    agregar_macrozona(c("Maule", NA), ordenar = FALSE),
    c("Centro", NA)
  )

  expect_warning(
    resultado <- agregar_macrozona(c("1", "Biobío", "13"), ordenar = FALSE),
    "formato caracter"
  )
  expect_identical(resultado, c("Norte", "Sur", "Centro"))
})

test_that("agregar_macrozona maneja nombres no reconocidos", {
  # algunos reconocidos: advierte y entrega NA
  expect_warning(
    resultado <- agregar_macrozona(c("Maule", "Narnia"), ordenar = FALSE),
    "no fueron reconocidos"
  )
  expect_identical(resultado, c("Centro", NA))

  # ninguno reconocido: error
  expect_error(
    suppressWarnings(agregar_macrozona(c("xx", "yy"))),
    "No se pudo interpretar"
  )
})

test_that("agregar_macrozona funciona con data frames", {
  datos <- dplyr::tibble(codigo_region = c(15, 13, 12), x = 1:3)

  resultado <- agregar_macrozona(datos, ordenar = FALSE)
  expect_s3_class(resultado, "data.frame")
  expect_identical(names(resultado), c("codigo_region", "x", "macrozona"))
  expect_identical(resultado$macrozona, c("Norte", "Centro", "Austral"))

  # con territorios
  expect_identical(
    agregar_macrozona(territorios, tipo = 2)$macrozona,
    agregar_macrozona(territorios$codigo_region, tipo = 2)
  )

  # sin columnas válidas
  expect_error(
    agregar_macrozona(dplyr::tibble(a = 1)),
    "codigo_region"
  )
})

test_that("agregar_macrozona valida sus argumentos", {
  # tipo inválido
  for (tipo_invalido in list(6, 0, -1, 1.5, NA_real_)) {
    expect_error(
      agregar_macrozona(1:16, tipo = tipo_invalido),
      "debe ser un número entre 1 y 5",
      info = paste("tipo", tipo_invalido)
    )
  }

  # input no atómico, códigos comunales y códigos fuera de rango
  expect_error(agregar_macrozona(list(1, 2, 3)), "vector de códigos")
  expect_error(agregar_macrozona(1101), "códigos comunales")
  expect_error(agregar_macrozona(c(0, 17, 99)), "fuera de rango")
})
