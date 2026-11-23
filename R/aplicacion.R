#' Uso interactivo del paquete `territorial`
#'
#' Ejecutar para abrir una aplicación Shiny pequeña donde se pueden usar algunas funciones de manera interactiva.
#'
#' Sirve principalmente para mostrar el paquete a un público menos nerd.
#'
#' @export
aplicacion <- function() {
  rlang::check_installed("shiny", reason = "para abrir la app interactiva.")
  rlang::check_installed("bslib", reason = "para la interfaz de la app.")

  # ubicar aplicación
  appDir <- system.file(
    "aplicaciones",
    "territorial_app",
    package = "territorial"
  )
  if (appDir == "") {
    stop(
      "No se encontró la aplicación. Reinstala `territorial`.",
      call. = FALSE
    )
  }

  # ejecutar aplicación
  shiny::runApp(appDir, display.mode = "normal")
  # https://deanattali.com/2015/04/21/r-package-shiny-app/
}
