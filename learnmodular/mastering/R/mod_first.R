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
      shiny::selectInput(inputId = "dataset", label = "data set", choices=unique(mtcars$cyl))),
      verbatimTextOutput("summary"),
      tableOutput(ns("table"))
  )
}

#' first Server Functions
#'
#' @noRd
mod_first_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    function(input,output, session){}

  })
}

## To be copied in the UI
# mod_first_ui("first_1")

## To be copied in the server
# mod_first_server("first_1")
