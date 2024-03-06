library(dplyr)

data = data.frame(Year=c("2002","2003","2004","2003","2001","2002", "2001"),
									Month = c("Jan", "Feb", "Mar", "Jan", "Dec", "Jan", "Nov"),
									Name =c("Sam", "Paul", "James", "Ana","Rose", "Juan", "Tim"),
									row.names=NULL, stringsAsFactors = FALSE)



ui<- fluidPage(

	selectInput("year","Year",choices = unique(data$Year)),
	selectInput("month","month",choices = NA),
	selectInput("name","name",choices = NA),
	tableOutput("table")

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

# server <- function(input,output,session){
#
# 	observeEvent(input$year,
# 							 {
# 							 	updateSelectInput(session, inputId = "month","month", choices = unique(data$Month[data$Year==input$year]))
# 							 })
#
# 	observeEvent(input$month,
# 							 {
# 							 	updateSelectInput(session, inputId = "name", "name", choices = unique(data$Name[data$Year==input$year & data$Month==input$month]))
# 							 })
#
# 	output$table <- renderTable(data)
# }

shinyApp(ui,server)



