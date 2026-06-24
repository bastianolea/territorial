#' Crear abreviaciones de 3 letras desde nombres comunas
#'
#' A partir de un vector de nombres de comunas (como [territorial::comunas()]), retorna nombres de comunas abreviados, como siglas de 3 caracteres (a excepción de Santiago, que queda STGO). Sirve para poner nombres de comunas donde hay poco espacio, como en mapas. Las abreviaciones no necesariamente son únicas.
#'
#' Las siglas se construyen con las tres primeras letras de las comunas con nombres de una palabra, y en las comuna de dos o más palabras con la primera letra de la primera palabra y las dos primeras letras de la segunda palabra. Se ajustan algunos casos, como eliminar símbolos (como en O'Higgins), y sacar la "u" de las comunas que empiezan con "Que" para reducir coincidencias de abreviaciones.
#'
#' @param nombre_comuna Vector de nombres de comunas, como [territorial::comunas()]
#'
#' @returns Vector con siglas de comunas de tres o cuatro caracteres
#' @export
#'
#' @examples
#' abreviar_comunas(c("Cerrillos", "La Florida", "Quellón"))
abreviar_comunas <- function(nombre_comuna) {
  # nombre_comuna <- comunas()

  if (!is.vector(nombre_comuna)) {
    cli::cli_abort("debe ser vector")
  }

  preposiciones <- c(
    "del",
    "de",
    "las",
    # "la",
    "el"
    # "lo"
  )

  preposiciones_regex <- paste0(
    "\\b",
    toupper(preposiciones),
    "\\b",
    collapse = "|"
  )

  nombre_limpio <- nombre_comuna |>
    stringr::str_to_upper() |>
    stringr::str_remove_all(preposiciones_regex) |>
    stringr::str_remove_all("[:punct:]") |>
    stringr::str_replace_all("^QU", "Q") |>
    stringr::str_squish()

  nombre_limpio

  comuna_palabras <- stringr::str_count(nombre_limpio, "\\w+")

  siglas <- dplyr::case_when(
    nombre_limpio == "SANTIAGO" ~ "STGO",
    comuna_palabras == 1 ~ stringr::str_extract(nombre_limpio, "^..."),
    comuna_palabras >= 2 ~ stringr::str_split(nombre_limpio, pattern = " ") |>
      # unlist() |>
      purrr::map(
        ~ stringr::str_extract(.x, "^..") |>
          paste(collapse = "")
      ) |>
      purrr::list_c() |>
      stringr::str_sub_all(start = c(1, 3), end = c(1, 4)) |>
      purrr::map(
        ~ paste(.x, collapse = "")
      ) |>
      purrr::list_c()
  )

  if (!length(siglas) == length(nombre_comuna)) {
    cli::cli_abort("largo de resultado no es igual al de input")
  }

  # dplyr::tibble(nombre_comuna, nombre_limpio, siglas) |>
  #   print(n = Inf)

  return(siglas)
}
