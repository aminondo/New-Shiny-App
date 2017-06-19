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
library(rattle)
library(ggplot2)
library(dplyr)
#library(party)

# Define UI for application that draws a histogram
#View(iris)
fit = rpart(Species ~ ., data=iris)
ui <- fluidPage(
  
   
   # Application title
   titlePanel("Iris Data Set"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         
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
         textOutput("prediction"),
         textOutput("probs"),
         plotOutput("tree")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   output$prediction = renderText({
       new_data = data.frame(
         Petal.Length = input$petal_length,
         Petal.Width = input$petal_width,
         Sepal.Length = 0,
         Sepal.Width = 0
       )
       species = predict(fit, newdata=new_data, type="class")
       pred = sprintf("This is my prediction: %s",species)

       paste(pred)
   })
   output$probs = renderText({
     new_data = data.frame(
       Petal.Length = input$petal_length,
       Petal.Width = input$petal_width,
       Sepal.Length = 0,
       Sepal.Width = 0
     )
     prob = predict(fit, newdata=new_data, type="prob")
     probs = sprintf("Probabilities are: { setosa: %.2f, versicolor: %.2f, virginica: %.2f }",
                     prob[[1]]*100,prob[[2]]*100,prob[[3]]*100)
     paste(probs)
     #paste(probs)
   })
     #nput$petal_length
     #"Output is text"
   output$tree = renderPlot({
    # new_data = data.frame(
     #  Petal.Length = input$petal_length,
      # Petal.Width = input$petal_width,
      # Sepal.Length = input$sepal_length,
      # Sepal.Width = input$sepal_width
     #)
     #predict(input$fit, newdata=new_data, type="class")
     fancyRpartPlot(fit)
     #plot(input$fit)
     #ggplot(iris, aes(x=Petal.Length,y=Petal.Width,color=Species)) +geom_point()
   }) 
     

}

# Run the application 
shinyApp(ui = ui, server = server)

