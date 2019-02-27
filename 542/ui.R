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

#create factors

df.csv$Table<-as.factor(df.csv$Table)
df.csv$Treat<-as.factor(df.csv$Treat)
df.csv$Cv<-as.factor(df.csv$Cv)




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
                                  box(width = 12, title = "Please select type of cultivar"),
                                             selectizeInput("type", "Type", selected = "C", choices = c("C", "D")),
                                             selectizeInput("treatment", "Treatment", choices = levels(as.factor(df.csv$Treat)), selected = "1")),
                                   #tabBox( id = "tabset1", height = "500px", width = "250px"),
                                           tabPanel("Disease Progression Curves", 
                                                    br(),
                                                    
                                                    plotOutput("plot", click = "plot_click"), 
                                                    h4("Click on the peak of a bar to view the staff_id and z_score.")
                                                    
                                                    )))
                                           )
                                         )
                          
                      