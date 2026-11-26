test_that("redacción de comunas retorna largo 1", {
  expect_length(
    redactar_comunas(c("Paine", "Isla de Maipo", "Pirque")),
    1
  )
})


test_that("redacción de 3 comunas", {
  expect_equal(
    redactar_comunas(c("Paine", "Isla de Maipo", "Pirque")),
    "Paine, Isla de Maipo y Pirque"
  )
})

test_that("redacción de 10 comunas", {
  comunas_prueba <- c(
    "Sierra Gorda",
    "Taltal",
    "Calama",
    "Ollagüe",
    "San Pedro de Atacama",
    "Tocopilla",
    "María Elena",
    "Copiapó",
    "Caldera",
    "Tierra Amarilla"
  )

  expect_equal(
    redactar_comunas(comunas_prueba),
    "Sierra Gorda, Taltal, Calama, Ollagüe, San Pedro de Atacama, Tocopilla, María Elena, Copiapó, Caldera y Tierra Amarilla"
  )
})

test_that("redacción de más de 10 comunas", {
  comunas_prueba <- c(
    "Chañaral",
    "Diego de Almagro",
    "Vallenar",
    "Alto del Carmen",
    "Freirina",
    "Huasco",
    "La Serena",
    "Coquimbo",
    "Andacollo",
    "La Higuera",
    "Paihuano",
    "Vicuña",
    "Illapel",
    "Canela",
    "Los Vilos",
    "Salamanca",
    "Ovalle",
    "Combarbalá",
    "Monte Patria",
    "Punitaqui",
    "Río Hurtado"
  )

  expect_equal(
    redactar_comunas(comunas_prueba),
    "Chañaral, Diego de Almagro, Vallenar, Alto del Carmen, Freirina, Huasco, La Serena, Coquimbo, Andacollo, La Higuera y 11 comunas más"
  )
})

test_that("redacción de comunas tomadas del vector comunas()", {
  # independiente del orden: se compara contra las mismas comunas redactadas a mano
  comunas_prueba <- comunas()[10:19]

  expect_equal(
    redactar_comunas(comunas_prueba),
    paste0(
      paste(comunas_prueba[1:9], collapse = ", "),
      " y ",
      comunas_prueba[10]
    )
  )
})
