library(shiny)
library(zoo)
library(plotly)

shinyServer(function(input, output) {
  
  sb<-cbind(Date=as.Date.yearmon(time(Seatbelts)),as.data.frame(Seatbelts))
  colnames(sb)[2:5]<-c("Killed_Drivers","Killed_Or_Injured_Drivers",
                       "Killed_Or_Injured_Front_Passengers","Killed_Or_Injured_Rear_Passengers")
  o<- reactive({
    outcome <- switch(input$outc,
    Killed_Drivers = "Killed_Drivers",
    Killed_Or_Injured_Drivers = "Killed_Or_Injured_Drivers",
    Killed_Or_Injured_Front_Passengers = "Killed_Or_Injured_Front_Passengers",
    Killed_Or_Injured_Rear_Passengers = "Killed_Or_Injured_Rear_Passengers",
    Killed_Drivers)
    lm(as.formula(paste(outcome," ~ PetrolPrice")), 
       data = subset(sb, Date>=as.Date(input$range[1]) & Date<=as.Date(input$range[2]))) 
    
    })

  output$plot <- renderPlot({
    sb1<-subset(sb, Date>=as.Date(input$range[1]) & Date<=as.Date(input$range[2]))
    plot(sb1[,7], sb1[,input$outc], xlab = "Petrol Price", 
         ylab = "Number Of People", bty = "o", pch = 16,
         xlim = c(min(sb1[,"PetrolPrice"]), max(sb1[,"PetrolPrice"])))
    abline(o(), col = "red", lwd = 2)
  })
  
  output$summary <- renderPrint({
    summary(o())
  })
  
  output$predvalue <- renderPrint({
    paste0("Predicted value of ",input$outc," for Petrol Price of ",input$pp," is ",round(coef(o())[1]+coef(o())[2]*input$pp,0))
  })  
  
})
