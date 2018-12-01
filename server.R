library(shiny)
library(reshape2)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {
  both <- read.csv("marriage/both_sexes.csv",stringsAsFactors = FALSE)
  men <- read.csv("marriage/men.csv",stringsAsFactors = FALSE)
  women <- read.csv("marriage/women.csv",stringsAsFactors = FALSE)
  divorce <- read.csv("marriage/divorce.csv",stringsAsFactors = FALSE)
  
  output$contents <- renderPlot({
    if(input$select_2=="1"){
      both <- both %>% select(year,4:27)
    }else if(input$select_2=="2"){
      both <- both %>% select(year,28:51)
    }else{
      both <- both %>% select(year,52:75)
    }
    if(input$select_1=="region"){
      both <- both %>% select(year,3:7)
      colnames(both) <- c("year","High school graduate or less","Some college","Bachelor's degree or more","Bachelor's degree, no graduate degre","Graduate degree")
    }else if(input$select_1=="race"){
      both <- both %>% select(year,8:10)
      colnames(both) <- c("year","Non-Hispanic white","Black or African-American","Hispanic of any race")
    }else{
      both <- both %>% select(year,11:16)
      colnames(both) <- c("year","New England","Mid-Atlantic","Midwest","South","Mountain West","Pacific")
    }
    both <- melt(both,id="year")
    ggplot(both,aes(year,value,colour=variable))+geom_line()
  })
})