library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Tabsets"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      radioButtons("outc", "Outcome variable:",
                   c("Killed Drivers" = "Killed_Drivers",
                     "Killed Or Injured Drivers" = "Killed_Or_Injured_Drivers",
                     "Killed Or Injured Front Passengers" = "Killed_Or_Injured_Front_Passengers",
                     "Killed Or Injured Rear Passengers" = "Killed_Or_Injured_Rear_Passengers")),
      
      br(),
      
      sliderInput("pp",
                  "Petrol Price",
                  value = 0.1,
                  min = 0.07,
                  max = 0.14),
      
      sliderInput("range", "Range:",
                  min = as.Date("1969-01-01"), max = as.Date("1984-12-01"),
                  value = c(as.Date("1969-01-01"),as.Date("1984-12-01"))),
      
      submitButton("Submit")
      
    ),

    mainPanel(

      tabsetPanel(type = "tabs",
                  tabPanel("README", "The purpose of this project is to investigate 
                          relations between road casualties and petrol prices in UK 
                          between 1969-1984 using a linear regression model with casualties
                          as an outcome and petrol price as a predictor.
                          In the sidebar of the app, select data to analyze and click 'Submit' 
                          to perform calculations. Then the follwing output will be provided: 
                          a plot with selected data points and regression line (tab 'Plot'),
                          summary of the regression model (tab 'Summary'),
                          predicted value of the selected outcome after choosing petrol price 
                          and time range (tab 'Predicted value')."),
                  tabPanel("Plot", plotOutput("plot")),
                  tabPanel("Summary", verbatimTextOutput("summary")),
                  tabPanel("Predicted Value", verbatimTextOutput("predvalue"))
      )
      
    )
  )
)
)
