library(shiny)
library(DT)
library(plotly)
library(dplyr)
library(shinyWidgets)
library(shinydashboard)

id <- c(1:100)
v1 <- rep(LETTERS[1:10], times = 10)
v2 <- sample.int(100, 100)
v3 <- sample.int(200, 100)
v4 <- sample.int(300, 100)
v5 <- rep(c(2000:2019), times = 5)
df <- data.frame(id, v1, v2, v3, v4, v5)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(
    sidebarMenu(
      menuItem("first", tabName = "first")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "first",
        box(
          width = 12, solidHeader = TRUE,
          DT::dataTableOutput("table"),
          # plotlyOutput("plot")
        )
      )
    )
  )
)

server <- function(input, output) {
  df_subset <- reactiveVal(NULL)

  output$table <- DT::renderDataTable({
    DT::datatable(df,
                  options = list(
                    pageLength = 10, paging = TRUE, searching = TRUE
                  ),
                  rownames = FALSE, selection = "single",
    )
  })

  observeEvent(input$table_rows_selected, {
    v1_value <- df[input$table_rows_selected, "v1"]
    df_subset(filter(df, v1 == v1_value))
    showModal(modalDialog(plotlyOutput("plot"), size = "m"))
  })
  glue::glue(message("this is value {v1_value}"))
  click_subset <- df %>% filter(v1 == "B")

  # Plot in popup window
  output$plot <- renderPlotly({
    req(df_subset)
    plot_ly(df_subset(), type = "bar") %>%
      add_trace(
        x = ~v5, y = ~v3
      )
  })
}

shinyApp(ui, server)
