library(shiny)
library(bslib)
library(territorial)
# https://deanattali.com/2015/04/21/r-package-shiny-app/

ui <- page_fluid(
  title = "App",
  includeCSS("estilos.css"),

  theme = bs_theme(
    fg = "#5c534a",
    bg = "#f9f1e5",
    primary = "#7CB096",
    "bslib_spacer" = "1rem"
  ),

  # contenedor centrado con ancho máximo
  div(
    class = "mx-auto",
    style = "margin-top: 24px; max-width: 800px;",

    HTML(
      '<a href="https://bastianolea.github.io/territorial/"><img src="https://bastianolea.github.io/territorial/logo.png" align="right" height="130" alt="territorial website" /></a>'
    ),

    h1("Utilidades", tags$code("territorial")),

    markdown(
      "Versión interactiva de algunas de las funciones del [paquete de R `territorial`](https://bastianolea.github.io/), enfocado en ayudarte a limpiar, validar y procesar datos de regiones y comunas de Chile."
    ),

    markdown(
      "Para usar estas funciones sobre tus bases datos, con mayor flexibilidad y diagnósticos, [instala el paquete!](https://bastianolea.github.io/territorial/articles/territorial.html#instalación)"
    ),

    # nombre a código ----
    card(
      h3("Convertir nombre de comuna a código territorial"),

      div(
        span("Por ejemplo:"),
        span("La Florida", style = "color: #E0B27F"),
        span("→"),
        span("13110", style = "color: #7CB096")
      ),

      div(
        style = "display: flex; align-items: center; gap: 12px;",
        textInput(
          "convertir_nombre_comuna",
          label = tags$b("Nombre de comuna"),
          value = "",
          placeholder = NULL,
          width = 240
        ),

        div(
          style = "margin-top: 6px;",
          htmlOutput("convertir_nombre_comuna")
        )
      ),

      div(
        style = "margin-top: -14px;",
        span("Código de R:"),
        htmlOutput("convertir_nombre_comuna_codigo")
      )
    ),

    # codigo a nombre ----
    card(
      h3("Convertir código territorial a nombre de comuna"),

      div(
        span("Por ejemplo:"),
        span("13201", style = "color: #E0B27F"),
        span("→"),
        span("Puente Alto", style = "color: #7CB096")
      ),

      div(
        style = "display: flex; align-items: center; gap: 12px;",
        textInput(
          "convertir_codigo_comuna",
          label = tags$b("Código de comuna"),
          value = "",
          placeholder = NULL,
          width = 240
        ),

        div(
          style = "margin-top: 6px;",
          htmlOutput("convertir_codigo_comuna")
        )
      ),

      div(
        style = "margin-top: -14px;",
        span("Código de R:"),
        htmlOutput("convertir_codigo_comuna_codigo")
      )
    ),

    div(
      style = "font-size: 80%; opacity: 80%;",
      markdown(
        "Creado por [Bastián Olea Herrera](https://bastianolea.rbind.io) en R."
      )
    )
  )
)

server <- function(input, output, session) {
  # comuna al azar
  observe({
    updateTextInput(
      session,
      "convertir_nombre_comuna",
      placeholder = sample(comunas(), 1)
    )
  })

  output$convertir_nombre_comuna <- renderUI({
    req(input$convertir_nombre_comuna)
    resultado <- as_codigo_comuna(input$convertir_nombre_comuna)

    if (input$convertir_nombre_comuna == "") {
      return(em("Ingresar nombre de comuna"))
    } else if (is.na(resultado)) {
      return(em("Comuna no encontrada"))
    } else {
      return(resultado)
    }
  })

  output$convertir_nombre_comuna_codigo <- renderUI({
    tags$code(
      HTML(paste0(
        '<span style="color: #7CB096">territorial::</span>',
        '<a href="https://bastianolea.github.io/territorial/reference/as_codigo_comuna.html">as_codigo_comuna</a>(',
        '<span style="color: #E0B27F;">',
        '"',
        htmltools::htmlEscape(input$convertir_nombre_comuna),
        '"',
        '</span>',
        ')'
      ))
    )
  })

  # comuna al azar
  observe({
    updateTextInput(
      session,
      "convertir_codigo_comuna",
      placeholder = sample(codigos_comunas(), 1)
    )
  })

  output$convertir_codigo_comuna <- renderUI({
    req(input$convertir_codigo_comuna)
    resultado <- as_nombre_comuna(as.numeric(input$convertir_codigo_comuna))

    if (input$convertir_codigo_comuna == "") {
      return(em("Ingresar código de comuna"))
    } else if (is.na(resultado)) {
      return(em("Código de comuna no encontrado"))
    } else {
      return(resultado)
    }
  })

  output$convertir_codigo_comuna_codigo <- renderUI({
    tags$code(
      HTML(paste0(
        '<span style="color: #7CB096">territorial::</span>',
        '<a href="https://bastianolea.github.io/territorial/reference/as_nombre_comuna.html">as_nombre_comuna</a>(',
        '<span style="color: #E0B27F;">',
        htmltools::htmlEscape(input$convertir_codigo_comuna),
        '</span>',
        ')'
      ))
    )
  })
}

shinyApp(ui, server)
