#' my_other_module UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_my_other_module_ui <- function(id){
  ns <- NS(id)
  tagList(
    DT::dataTableOutput(ns("table1")),
    plotOutput(ns("plot1"))
#
#     h2("second module"),
#     plotOutput(ns("plot"))
  )
}

#' my_other_module Server Functions
#'
#' @noRd
mod_my_other_module_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$table1<-DT::renderDT(DT::datatable(mtcars) )
    output$plot1<- shiny::renderPlot(
      ggplot2::ggplot(mtcars, ggplot2::aes(x=wt,y=mpg)) + ggplot2::geom_point()
    )

    # output$plot <- renderPlot({
    #   plot(airquality)
    # })
  })
}

## To be copied in the UI
# mod_my_other_module_ui("my_other_module_1")

## To be copied in the server
# mod_my_other_module_server("my_other_module_1")
