#' first_module UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_first_module_ui <- function(id){
  ns <- NS(id)
  tagList(

    shinydashboard::dashboardPage(
      shinydashboard::dashboardHeader(title = "MTCART"),
      shinydashboard::dashboardSidebar(
        shinydashboard::sidebarMenu(

          shinydashboard::menuItem(text = "Data", tabName = "data2",icon=icon("table")),
          shinydashboard::menuItem(text = "Plots", tabName = "plots2",icon=icon("chart-bar")),
          shiny::selectInput(inputId = "selectCylinder", label = "Select a cylinder:", choices = unique(mtcars$cyl))
        )
      ),
      shinydashboard::dashboardBody(
        shinydashboard::tabItems(
          shinydashboard::tabItem(tabName = "plots2",
                                  shiny::plotOutput(ns("plot1"))
          ),
          shinydashboard::tabItem(tabName = "data2",
                                  DT::DTOutput(ns("data1")))
        )
      )
    )

    # h2("cos tam cos"),
    # plotOutput(ns("plot"))

  )
}

#' first_module Server Functions
#'
#' @noRd
mod_first_module_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns


    dataFiltered <- reactive({
      data<-mtcars[mtcars$cyl %in% input$selectCylinder,]
      return(data)
    })

    output$data1<- DT::renderDT(DT::datatable(dataFiltered()))
    output$plot1<-renderPlot({
      ggplot2::ggplot(data=dataFiltered(),ggplot2::aes(x=mpg,y=hp)) + ggplot2::geom_point()
    })

    # output$plot <- renderPlot({
    #   plot(iris)
    # })
  })
}

## To be copied in the UI
# mod_first_module_ui("first_module_1")

## To be copied in the server
# mod_first_module_server("first_module_1")
