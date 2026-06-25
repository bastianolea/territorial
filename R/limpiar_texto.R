limpiar_texto <- function(texto) {
  texto |>
    stringr::str_remove_all("[:punct:]") |>
    stringr::str_remove_all("´|\\'|\\`") |>
    stringr::str_remove_all("\\d+") |>
    stringr::str_to_lower() |>
    stringi::stri_trans_general("Latin-ASCII") |>
    stringr::str_squish()
}
