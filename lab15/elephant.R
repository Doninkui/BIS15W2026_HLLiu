library(tidyverse)
library(janitor)
library(shiny)
library(shinydashboard)

ui <-
  dashboardPage(dashboardHeader(title = "Range of age and height by sex of elephant"),
                dashboardSidebar(selectInput(inputId = "sex",
                                             label="choose sex:",
                                             choices = c("M","F"),
                                             selected ="M")),
                dashboardBody(plotOutput("plot", 
                                         width = "500px", 
                                         height = "400px")))

server <- function(input, output, session) {
  output$plot <- renderPlot({
    df <- elephants %>% 
      filter(sex==input$sex)
    ggplot(df,aes(x=age,y=height))+
      geom_point(color=ifelse(input$sex=="M","blue","red"))+
      labs(title = paste("age vs height(sex=",input$sex,")"),x="Age",y="Height")+
      theme_minimal()
  })
}

shinyApp(ui, server)