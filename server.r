# library the packages needed
library(shiny)
library(rworldmap)
library(dplyr)

# Read in data
data <- read.csv("data/overall_malaria.csv")

source('./scripts/mapPolys.R')
source('./scripts/rwmCheckAndLoadInput.R')
source('./scripts/joinCountryData2Map.R')
source('./scripts/getMap.R')
source('./scripts/rwmGetISO3.R')
source('./scripts/buildMap.R')

# Creates a new data frame, with codes from the joinContryData2Map file
sPDF <- joinCountryData2Map(data, joinCode='NAME', nameJoinColumn='Country')

# Generate the Map 
shinyServer(function(input, output) {
  # Generates a map of malaria cases/country built with plotly
  output$mCases <- renderPlotly({
    return (BuildMap(data, input$cases))
  })
  
  # Generates a map of malaria deaths/country built with plotly
  output$mDeaths <- renderPlotly({
    return (BuildMap(data, input$deaths))
  })
})
