test_that("felicitar entrega mensajes para respuestas correctas e incorrectas", {
  expect_message(felicitar(TRUE))
  expect_message(felicitar(FALSE))
})
