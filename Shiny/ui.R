#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(
  fluidPage(title = "Mapa do Brasil",
            hr(), # inserir uma linha
            "Pontos ganhos por estado no Campeonato Brasileiro desde 2003",
            #hr(), # inserir uma linha,
            #sliderInput(inputId="slider", label = "Mova para ver a evolução ao longo dos anos",
             #           min = 2003, max = 2016, step = 1, value = 2016),
            hr(),
            leafletOutput("mapa"))
            
)
