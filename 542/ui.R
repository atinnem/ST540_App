#Amanda Tinnemore
#ST542
#Shiny app to demonstrate effect of treatement and type on disease progression curves

#Amanda Tinnemore
#ST503
#Project 2

library(shiny)
library(tidyverse)
library(shinydashboard)
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



ui <- dashboardPage(skin="purple",
                    header<-dashboardHeader(title = "Progression of Botrytis"),
                    sidebar<-dashboardSidebar(
                      sidebarMenu(menuItem("about", tabName = "about", icon = icon("archive")),
                                  menuItem("application", tabName = "app",icon = icon("laptop")))),
                    dashboardBody(
                      tabItems(
                        tabItem(tabName = "about",
                                fluidRow(
                                 
                                         h1("What does this app do?"),
                                         box(background = "purple", width = 12,
                                             h4("Disease progression")),
                                             h4("mpore")
                                             
                                         )),
                        tabItem(tabName = "app",
                                fluidRow(
                                  box(background = "purple", width = 5, title = "Select type of cultivar to visualize the effect the treatments had on each type of rose.  Select 'Water' or 'Botrytis' to "),
                                             selectizeInput("type", "Please select type of cultivar", selected = "C", choices = levels(df.csv$Cv)),
                                             selectizeInput("treatment", "Treatment", choices = c("Both", "Water", "Botrytis"), selected = "Both")),
                                   #tabBox( id = "tabset1", height = "500px", width = "250px"),
                                           tabPanel("Disease Progression Curves", 
                                                    br(),
                                                    
                                                    plotOutput("plot", click = "plot_click")
                                                    
                                                    )))
                                           )
                                         )
                          
                      