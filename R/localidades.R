#' Tabla de localidades de Chile
#'
#' Tabla de datos que contiene todas las localidades de Chile, asentamientos o áreas subcomunales que no son entidades administrativas. Según la definición del INE, una localidad es un "Área geográfica con nombre propio de conocimiento generalizado por la población. Puede estar poblada o no, aunque debe contener, a lo menos, una vivienda susceptible de ser habitada. Generalmente, se circunscribe dentro de un distrito censal; no obstante, puede rebasar a éste.” Esta tabla de localidades proviene del estudio de **Identificación de localidades en condición de aislamiento**, realizado por la Subsecretaría de Desarrollo Regional y Administrativo y publicado el año 2021.
#'
#' @format Un data frame con 29.256 filas y 6 columnas:
#' \describe{
#'   \item{codigo_comuna}{Código único territorial de las comunas de Chile}
#'   \item{localidad}{Nombre de la localidad}
#'   \item{tipo}{Tipo de localidad}
#'   \item{subtipo}{Subtipo de la localidad}
#'   \item{habitantes}{Habitantes de la localidad}
#'   \item{viviendas}{Viviendas de la localidad}
#' }
#' @source <https://ide.subdere.gov.cl/estudio-actualizacion-de-base-censal-identificacion-de-localidades-en-condicion-de-aislamiento/>
"localidades"
