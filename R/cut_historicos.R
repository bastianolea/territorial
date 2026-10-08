#' Códigos únicos territoriales históricos
#'
#' Esta tabla contiene los códigos únicos territoriales de las comunas de Chile junto a los códigos que han tenido a través de los años. Sirve para identificar cambios de CUT y convertir CUT históricos a CUT vigentes.
#'
#' Cada vez que se ha creado una nueva provincia o región de Chile, las comunas que las componen cambian sus códigos únicos territoriales para coincidir con la cifra de la unidad mayor que las contienen. Esta tabla permite identificar qué código único territorial vigente tienen hoy las comunas a partir de sus códigos antiguos o históricos (no vigentes).
#'
#' @format Un data frame con 345 filas y 5 columnas:
#' \describe{
#'   \item{nombre_comuna}{Nombre de las comunas de Chile}
#'   \item{codigo_comuna_2017}{Código único territorial actual y vigente de las comunas de Chile}
#'   \item{codigo_comuna_2010}{Código único territorial histórico (desactualizado y no vigente) de las comunas de Chile en el año 2010}
#'   \item{codigo_comuna_2007}{Código único territorial histórico (desactualizado y no vigente) de las comunas de Chile en el año 2007}
#'   \item{codigo_comuna_2004}{Código único territorial histórico (desactualizado y no vigente) de las comunas de Chile en el año 2004}

#' }
#' @source <https://www.subdere.gov.cl>
"cut_historicos"
