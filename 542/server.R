#Amanda Tinnemore
#ST542
#Shiny app to demonstrate effect of treatement and type on disease progression curves

library(shiny)
library(tidyverse)
library(ggplot2)


df.csv<-read_csv("Botrytis Data.csv")

#create factors

df.csv$Table<-as.factor(df.csv$Table)
df.csv$Treat<-as.factor(df.csv$Treat)
df.csv$Cv<-as.factor(df.csv$Cv)



shinyServer(function(input, output, session) {
 
getdata<-reactive({
  get<-df.csv %>% group_by(Day, Cv == input$type, Treat ==input$treatment) %>% summarise(Total = sum(Bc_F==1),tots = n_distinct(X1), Prop_undamaged = Total/tots)
})

# plot z score of Report Times
  output$plot <- renderPlot({
    #get filtered data
    list<-getdata()
    ggplot(list, aes(x=Day, y = Prop_undamaged))+ geom_line() +labs(x = "Day", y = "Proportion undamaged")
      })
  })
