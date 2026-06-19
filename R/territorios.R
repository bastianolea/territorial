#' Tabla de comunas, provincias y regiones de Chile
#'
#' Tabla de datos que contiene todas las comunas del país con sus nombres oficiales, sus códigos únicos comunales, y lo mismo para las provincias y regiones del país. Estos datos corresponden al [Ministerio del Interior de Chile](https://www.subdere.gov.cl/documentacion/códigos-únicos-territoriales-actualizados-al-06-de-septiembre-2018), publicados en el Diario Oficial el 21 de septiembre de 2018, con leves modificaciones.
#'
#' @format A data frame with 346 rows and 6 columns:
#' \describe{
#'   \item{codigo_region}{Código único territorial de las regiones de Chile (número entre 1 y 16)}
#'   \item{nombre_region}{Nombre de las regiones de Chile}
#'   \item{codigo_provincia}{Código único territorial de las provincias de Chile}
#'   \item{nombre_provincia}{Nombre de las provincias de Chile}
#'   \item{codigo_comuna}{Código único territorial de las comunas de Chile}
#'   \item{nombre_comuna}{Nombre de las comunas de Chile}
#' }
#' @source <https://www.subdere.gov.cl/documentacion/códigos-únicos-territoriales-actualizados-al-06-de-septiembre-2018>
"territorios"
