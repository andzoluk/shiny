ui<- fluidPage(
  
  sliderInput("one", label="if x is", min=1, max=50, value=30),
  "then x times 5 is ",
  textOutput("txt")
  
)

server<- function(input,output){
  
  output$txt <- renderText({
    input$one * 5
  })
  
}


shinyApp(ui,server)