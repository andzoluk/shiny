#' first UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_first_ui <- function(id){
  ns <- NS(id)
  tagList(
    shiny::fluidPage(
      shiny::selectInput("data", label= "select", choices = unique(mtcars$cyl)),
      verbatimTextOutput(ns("summary")),
      DT::dataTableOutput(ns("table")),
      textOutput(ns("greetings")),
      textInput(ns("name"), "What is your name?")
    )
  )
}

#' first Server Functions
#'
#' @noRd 
mod_first_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    df<-reactive({mtcars})
    
    output$greetings <- renderText({
      paste0("hello ", input$name)
    })
    
    output$table <- DT::renderDataTable({
      df()
    })
    
    output$summary <- shiny::renderPrint({
      summary(df())
    })
    
   
    
  })
}
    
## To be copied in the UI
# mod_first_ui("first_1")
    
## To be copied in the server
# mod_first_server("first_1")
