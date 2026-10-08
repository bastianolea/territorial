#' Tabla de códigos únicos territoriales históricos
#'
#' Cada vez que se ha creado una nueva provincia o región de Chile, las comunas que las componen cambian sus códigos únicos territoriales para coincidir con la cifra de la unidad mayor que las contienen. Esta tabla permite identificar qué código único territorial vigente tienen hoy las comunas a partir de sus códigos antiguos o históricos (no vigentes).
#'
#' @format Un data frame con 346 filas y 6 columnas:
#' \describe{
#'   \item{codigo_comuna_historico}{Código único territorial histórico (desactualizado y no vigente) de las comunas de Chile}
#'   \item{año}{Último año de vigencia del código único territorial}
#'   \item{codigo_comuna_actual}{Código único territorial actual y vigente de las comunas de Chile}
#' }
#' @source <https://www.subdere.gov.cl>
"cut_historicos"
