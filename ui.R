#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(dplyr)
library(leaflet)
stations <<- read.csv(file = "ftp://ftp.ncdc.noaa.gov/pub/data/noaa/isd-history.csv")
stations <<- stations %>% filter(!is.na(LAT) & !is.na(LON))
stations <<- stations %>% filter(CTRY!="")

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("SYNOP stations by country"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      p("This shiny app shows synops stations by country, chage country label in the selector and the map will show you that country's ststions"),
       selectInput("country",
                   "Country",
                   choices=as.list(sort(unique(stations$CTRY))),
                   selected = "SP"
                   )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("mymap")
    )
  )
))
