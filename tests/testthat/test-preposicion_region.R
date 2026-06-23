test_that("artículos de región funciona", {
  expect_equal(
    preposicion_region(
      c("Ñuble", "Biobío", "Metropolitana", "Santiago")
    ),
    c("de", "del", "", "de")
  )
})
