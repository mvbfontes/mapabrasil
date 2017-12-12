#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$mapa <- renderLeaflet({
    
    pal <- colorBin("Blues",domain = NULL,bins=12)
    
    
    # draw the histogram with the specified number of bins
    state_popup <- paste0("<strong>Estado: </strong>", 
                          brasileiropg$NM_ESTADO, 
                          "<br><strong>Pontos: </strong>", 
                          brasileiropg$cumsum)
    
    leaflet(data = brasileiropg) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(fillColor = ~pal(brasileiropg$cumsum), 
                  fillOpacity = 0.8, 
                  color = "#BDBDC3", 
                  weight = 1, 
                  popup = state_popup) %>%
      addLegend("bottomright", pal = pal, values = ~brasileiropg$cumsum,
                title = "Pontos Conquistados",
                opacity = 1)
    
  })
  
  
})


