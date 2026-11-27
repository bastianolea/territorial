test_that("revisar código de comuna antiguo", {
  expect_true(is_codigo_comuna_antiguo(1102))
})

test_that("revisar código de comuna normal", {
  expect_false(is_codigo_comuna_antiguo(1101))
})

test_that("is_codigo_comuna_antiguo advierte y convierte códigos en texto", {
  expect_warning(
    resultado <- is_codigo_comuna_antiguo("1102"),
    "no es de tipo numérico"
  )
  expect_true(resultado)
})
