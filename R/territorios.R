#' Tabla de comunas, provincias y regiones de Chile
#'
#' Tabla de datos que contiene todas las comunas del país con sus nombres oficiales, sus códigos únicos comunales, y lo mismo para las provincias y regiones del país. Al ser una tabla de las comunas de Chile, tiene 346 filas. Estos datos corresponden al [Ministerio del Interior de Chile](https://www.subdere.gov.cl/documentacion/códigos-únicos-territoriales-actualizados-al-06-de-septiembre-2018), publicados en el Diario Oficial el 21 de septiembre de 2018, con leves modificaciones.
#'
#' Las modificaciones realizadas a los datos son: formas alternativas de escribir las comunas de Treguaco (Trehuaco) y Paiguano (Paihuano), optando por las formas que son usadas por sus municipios (Trehuaco y Paihuano, respectivamente).
#'
#' @format Un data frame con 346 filas y 6 columnas:
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
