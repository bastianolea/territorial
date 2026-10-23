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
