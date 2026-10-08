#' Actualizar códigos únicos territoriales comunales antiguos o desactualizados
#'
#' Función que recibe códigos únicos territoriales desactualizados (confirmar con [territorial::is_codigo_comuna_antiguo()]), y retorna las versiones actualizadas al 2017 (posterior a la creación de la región de Ñuble).
#'
#' @param codigo_comuna Códigos comunales en formato numérico
#'
#' @returns Códigos comunales actualizados correspondientes a los desactualizados entregados
#' @export
#'
#' @examples
#' actualizar_codigo_comuna(8408)
#'
actualizar_codigo_comuna <- function(codigo_comuna) {
  # codigo_comuna <- sample(cut_historicos_l$codigo_comuna_historico, 4)

  if (!any(is_codigo_comuna_antiguo(codigo_comuna))) {
    cli::cli_alert_warning("Algunos códigos comunales no son antiguos!")
  }

  # identificar filas donde las comunas coinciden con códigos en tabla
  filas <- match(
    codigo_comuna,
    cut_historicos_l$codigo_comuna_historico
  )

  # extraer los valores de columna de códigos actuales a partir de las filas
  resultado <- cut_historicos_l$codigo_comuna_actual[filas]

  return(resultado)
}
