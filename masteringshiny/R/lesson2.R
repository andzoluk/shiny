ui<-fluidPage(
  
  textInput("name", "wahts oyur name"),
  passwordInput("pass","whats your password? "),
  textAreaInput("story","tell me about yourseelf",rows=3)
  
)

server<-function(input,output){}

shinyApp(ui, server)