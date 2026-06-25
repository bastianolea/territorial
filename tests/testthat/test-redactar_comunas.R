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
  expect_equal(
    redactar_comunas(comunas()[10:19]),
    "Sierra Gorda, Taltal, Calama, Ollagüe, San Pedro de Atacama, Tocopilla, María Elena, Copiapó, Caldera y Tierra Amarilla"
  )
})

test_that("redacción de más de 10 comunas", {
  expect_equal(
    redactar_comunas(comunas()[20:40]),
    "Chañaral, Diego de Almagro, Vallenar, Alto del Carmen, Freirina, Huasco, La Serena, Coquimbo, Andacollo, La Higuera y 11 comunas más"
  )
})
