#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  mod_first_module_server("first_module_1")
  mod_my_other_module_server("my_other_module_1")
  observeEvent(input$browser,{
    browser()
  })

}
