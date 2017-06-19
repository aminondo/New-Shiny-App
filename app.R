#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(rpart)
#library(rattle)
library(ggplot2)
library(dplyr)
#library(party)

# Define UI for application that draws a histogram
#View(iris)
ui <- fluidPage(
  
   fit = rpart(Species ~ ., data=iris),
  
   # Application title
   titlePanel("Iris Data Set"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("sepal_width",
                     "Sepal Width:",
                     min = 2.0,
                     max = 4.5,
                     step = .25,
                     value = 3.0),
         sliderInput("sepal_length",
                     "Sepal Length:",
                     min = 4.0,
                     max = 8.0,
                     step = .25,
                     value = 5.8),
         sliderInput("petal_width",
                     "Petal Width:",
                     min = 0.0,
                     max = 2.5,
                     step = .25,
                     value = 1.2),
         sliderInput("petal_length",
                     "Petal Length:",
                     min = 1,
                     max = 7,
                     step = .25,
                     value = 3.8)
         
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         textOutput("prediction")#,
         #plotOutput("tree")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   output$prediction = renderText({
       new_data = data.frame(
         Petal.Length = input$petal_length,
         Petal.Width = input$petal_width,
         Sepal.Length = input$sepal_length,
         Sepal.Width = input$sepal_width
       )
       species = predict(input$fit, newdata=new_data, type="class")
       
       paste("this works")
   })
     #nput$petal_length
     #"Output is text"
   #output$tree = renderPlot({
    # new_data = data.frame(
     #  Petal.Length = input$petal_length,
      # Petal.Width = input$petal_width,
      # Sepal.Length = input$sepal_length,
      # Sepal.Width = input$sepal_width
     #)
     #predict(input$fit, newdata=new_data, type="class")
     #fancyRpartPlot(input$fit)
     #plot(input$fit)
     #ggplot(iris, aes(x=Petal.Length,y=Petal.Width,color=Species)) +geom_point()
   #}) 
     

}

# Run the application 
shinyApp(ui = ui, server = server)

