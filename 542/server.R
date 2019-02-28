#Amanda Tinnemore
#ST542
#Shiny app to demonstrate effect of treatement and type on disease progression curves

library(shiny)
library(tidyverse)
library(ggplot2)


df.csv<-read_csv("Botrytis Data.csv")

#create factors, rename factors

df.csv$Table<-as.factor(df.csv$Table)
df.csv$Treat<-as.factor(df.csv$Treat)
df.csv$Cv<-as.factor(df.csv$Cv)

levels(df.csv$Cv)[levels(df.csv$Cv)=="V"]<-"Vendela"
levels(df.csv$Cv)[levels(df.csv$Cv)=="C"]<-"Cuenca"
levels(df.csv$Cv)[levels(df.csv$Cv)=="D"]<-"Daphnee"
levels(df.csv$Cv)[levels(df.csv$Cv)=="F"]<-"Freedom"



shinyServer(function(input, output, session) {
 
getdata<-reactive({
  
  if (input$treatment == "Both"){
      get<-df.csv %>% group_by(Day, Cv, Treat) %>% summarise(Total = sum(Bc_F==1),tots = n_distinct(X1), Prop_undamaged = Total/tots)} else if (input$treatment == "Water"){
      get<-df.csv %>% filter(post == "0") %>% group_by(Day, Cv, Treat) %>% summarise(Total = sum(Bc_F==1),tots = n_distinct(X1), Prop_undamaged = Total/tots)} else if (input$treatment == "Botrytis") {
        get<-df.csv %>% filter(post == "1") %>% group_by(Day, Cv, Treat) %>% summarise(Total = sum(Bc_F==1),tots = n_distinct(X1), Prop_undamaged = Total/tots)
      }
})

# plot z score of Report Times
  output$plot <- renderPlot({
    #get filtered data
    list<-getdata()
    list<-list %>% filter(Cv==input$type)
    
      ggplot(list, aes(x=Day, y = Prop_undamaged, col = Treat))+ geom_line() +labs(x = "Day", y = "Proportion undamaged") + xlim(1,5)
        
      })
      
  })
