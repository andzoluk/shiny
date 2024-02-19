ui<-fluidPage(
  selectInput("elo","co to takiego",c("a","b"), multiple=TRUE),
  radioButtons("elo2","a to co?", choiceNames = list(
    icon("angry"),
    icon("smile")
  ),
  choiceValues = c("angry","happyw")),

  checkboxGroupInput("morelo","fafourite", c("cat", "dog", "fish")),

  fileInput("upload",NULL),
  actionButton("drink","drink me", icon=icon("cocktail")),

  actionButton("spr2","ciekawe co wyjdzie", class = "btn-warning btn-lg")
)

server<-function(input,output){

}

shiny::shinyApp(ui, server)

#page 21 ex1

ui<-fluidPage(
  textInput("e","enter",placeholder = "Your name"),
  sliderInput(
    "dates",
    "When should we deliver?",
    min = as.Date("2019-08-09"),
    max = as.Date("2019-08-16"),
    value = as.Date("2019-08-10")
  ),
  sliderInput("secomd","choose",min=0, max=100,step=5, value=0),

  selectInput("zad3","select from the list", choices = list(
    'zwierze'=list("cat","dog","fish"),
    'cos'=list('one','two','three','four')
  ))
)



server<-function(input,output){

}




ui <- fluidPage(
  textOutput("text"),
  verbatimTextOutput("code")
)
server <- function(input, output, session) {
  output$text <- renderText({
    "Hello friend!"
  })
  output$code <- renderPrint(
    summary(1:10)
  )
}

shiny::shinyApp(ui, server)



ui<-fluidPage(
  plotOutput("pl","here is a plot", width = "7000px", height = "300px")
)


server<-function(input,output){
  output$pl<-renderPlot({
    plot(mtcars)
  })
}

shiny::shinyApp(ui, server)


