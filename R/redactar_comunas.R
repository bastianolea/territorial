redactar_comunas <- function(x) {
  glue::glue_collapse(unique(x), sep = ", ", last = " y ")
}
