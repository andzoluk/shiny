library(dplyr)
library(shiny)

data = data.frame(Year=c("2002","2003","2004","2003","2001","2002", "2001"),
									Month = c("Jan", "Feb", "Mar", "Jan", "Dec", "Jan", "Nov"),
									Name =c("Sam", "Paul", "James", "Ana","Rose", "Juan", "Tim"),
									row.names=NULL, stringsAsFactors = FALSE)



ui<- fluidPage(
	fluidRow(column(width=2, selectInput("year","Year",choices = unique(data$Year))),
					 column(width=2,selectInput("month","month",choices = NA)),
					 column(width=2,selectInput("name","name",choices = NA)),
					 column(width=6, tableOutput("table")))





)

server <- function(input,output,session){

	dat_reactive<- reactive({
		dplyr::filter(data, Year==input$year)
	})

	observeEvent(dat_reactive(),
							 {
							 	choices<-unique(dat_reactive()$Month)
							 	updateSelectInput(inputId = "month",choices = choices)
							 })




	month_reactive<- reactive({
		req(input$month)
		dplyr::filter(dat_reactive(), Month == input$month)
	})

	observeEvent(month_reactive(),
							 {
							 	choices<- unique(month_reactive()$Name)
							 	updateSelectInput(inputId = "name",  choices = choices )
							 })

	output$table <- renderTable({
		req(input$name)

		month_reactive() %>%
			filter(Name == input$name)


	})
}


shinyApp(ui,server)



