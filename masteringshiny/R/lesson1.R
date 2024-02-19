library(shiny)
library(DT)

# Shiny app UI
ui <- fluidPage(
  dataTableOutput("mtcars_table"),
  uiOutput("modal")
)

# Shiny app server
server <- function(input, output, session) {
  # Render the mtcars table
  output$mtcars_table <- renderDataTable({
    datatable(
      mtcars,
      selection = 'none',
      rownames = FALSE,
      options = list(
        pageLength = 10
      )
    )
  })
  
  # Create modal dialog
  output$modal <- renderUI({
    modalDialog(
      title = "Information",
      "Here is information"
    )
  })
  
  # Show modal when row is clicked
  observeEvent(input$mtcars_table_rows_selected, {
    showModal(uiOutput("modal"))
  })
}

# Run the Shiny app
shinyApp(ui, server)
