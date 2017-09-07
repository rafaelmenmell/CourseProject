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
  
  points <- eventReactive(input$country, {
   stations %>% filter(CTRY==input$country)
  }, ignoreNULL = FALSE)
   
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(data = points(),lat = ~ LAT, lng = ~ LON, clusterOptions = markerClusterOptions(showCoverageOnHover=FALSE), popup = ~paste(USAF,"-"," ",WBAN,STATION.NAME,sep=""))
  })
  
})
