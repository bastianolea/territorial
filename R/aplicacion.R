#' Uso interactivo del paquete `territorial`
#'
#' Ejecutar para abrir una aplicación Shiny pequeña donde se pueden usar algunas funciones de manera interactiva.
#'
#' Sirve principalmente para mostrar el paquete a un público menos nerd.
#'
#' @export
aplicacion <- function() {
  appDir <- system.file(
    "aplicaciones",
    "territorial_app",
    package = "territorial"
  )
  if (appDir == "") {
    stop(
      "Could not find example directory. Try re-installing `territorial`.",
      call. = FALSE
    )
  }

  shiny::runApp(appDir, display.mode = "normal")
  # ui <- page_fillable(
  #   title = "App"
  # )
  #
  # server <- function(input, output, session) {}
  #
  # app <- list(ui = ui,
  #             server = server)
  #   runApp(app)
}
