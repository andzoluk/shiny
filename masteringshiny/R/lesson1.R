#page 11, ex 1

ui<- fluidPage(
  
  sliderInput("one", label="if x is", min=1, max=50, value=30),
  sliderInput("two", label = "and y is", min=1, max=50, value=5),
  textOutput("txt"),
  textOutput("txt2")
  
)

server<- function(input,output){
  
  output$txt <- renderText({
    paste0("then x times 5 is ", input$one * 5)
  })
  output$txt2 <- renderText({
    paste0("then, x times y is ", input$two*input$one)
  })
  
}


shinyApp(ui,server)

