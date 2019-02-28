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
                                             h4("The aim of this app is to aid in the visualization of the disease progression of Botrytis on roses. ")),
                                         br(),
                                         h2("Study description"),
                                         box(background = "purple", width = 12,
                                             h4("Four types of roses, Vendela, Cuenca, Daphnee, and Freedom, were selected for this study based on their known susceptibility to either Botrytis or ethylene damage.  The rose cultivars were treated with one of five pretreatments: water, silver thiosulfate (STS), 1-methylcyclopropene (1-MCP), or exposure to either 0 or 1.0 ppm ethylene for twenty hours.  After treatment the flowers were either sprayed with tap water or inoculated with Botrytis spores before being incubated for 24 hours."),
                                             br(),
                                             h4("Daily observations of the prevalence of disease were performed.  Observations used a subjective scale of 1-8 to classify the amount of visual Botrytis damage on each flower.  One denoted no symptoms. Two denoted the presence of 1-4 pinpoint lesions (approximately  1% f the flower was diseased).  Three denoted the presence of 5-19 pinpoint lesions (approximately  2-5% f the flower was diseased).  Four denoted the presence of more than 20 pinpoint lesions (approximately  6-12% f the flower was diseased).  Five denoted that approximately 13-15% of the flower was diseased. Six denoted that approximately 26-50% of the flower was diseased. Seven denoted that approximately 51-75% of the flower was diseased. Eight denoted that approximately 76-100% of the flower was diseased or the flower head had collapsed. These ratings were used Flowers were terminated when they received a rating of 8 and records were kept as to the reason for termination."),
                                             br(),
                                             h4("The disease progression curves presented in this app represent the daily porportion of flowers with a rating of '1' for each combination of treatment, pretreatment, and type of rose"),
                                             br(),
                                             h6("Please note, the proportions do not always decrease as expected as flowers were terminated from the study effected the overal  number of flowers in the proprotion. "))
                                             
                                         )),
                        tabItem(tabName = "app",
                                fluidRow(
                                  column(3, 
                                  #box(background = "purple", width = 5, title = "Select type of cultivar to visualize the effect the treatments had on each type of rose.  Select 'Water' or 'Botrytis' to see the change in curves based off of the inoculation status of the roses. "),
                                             selectizeInput("type", "Please select type of cultivar", selected = "C", choices = levels(df.csv$Cv)),
                                             selectizeInput("treatment", "Treatment", choices = c( "Water", "Botrytis", "Both"), selected = "Both"))),
                                   #tabBox( id = "tabset1", height = "500px", width = "250px"),
                                           tabPanel("Disease Progression Curves", 
                                                    br(),
                                                    
                                                    plotOutput("plot")
                                                    
                                                    )))
                                           )
                                         )
                          
                      