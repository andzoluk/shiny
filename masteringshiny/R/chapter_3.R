library(shiny)

ui <- fluidPage(
  fluidRow(
    column(4,
           textInput("txt", "add something"),
           actionButton("click", "click")
    ),
    column(4,
           radioButtons("button", "how you feel", choices = c("good", "bad", "excellent"))
    ),
    column(4,
           sliderInput("num","HP",min=min(mtcars$hp),max=max(mtcars$hp), value=min(mtcars$hp))
    )
  ),
  fluidRow(
    column(12,
           plotOutput("plot")
    )
  )
)

server <- function(input, output) {

  data <- eventReactive(input$click, {
    subset_data <- mtcars[mtcars$hp >= input$num, "cyl"]
    hist(subset_data, main = "Histogram of Number of Cylinders", xlab = "Number of Cylinders", ylab = "Frequency")
  })

  output$plot <- renderPlot({
    data()
  })

}

shinyApp(ui, server)
