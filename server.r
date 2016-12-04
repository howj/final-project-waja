library(shiny)
library(rworldmap)
library(dplyr)

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

  # Generates a map of malaria deaths/country built with rworldmap
  output$mPlot <- renderPlot({
    mapParams <- mapPolys(sPDF, nameColumnToPlot=input$yearvar, mapRegion='world',
                          missingCountryCol='dark grey', numCats=10, 
                          colourPalette=c('green4','green1','greenyellow','yellow','yellow2','orange','coral','red','red3','red4'),
                          addLegend=TRUE,
                          oceanCol='light blue')
    mtext("[Grey Color: No Data Available]",side=1,line=-1)
  })
  
  # Generates a map of malaria cases/country built with plotly
  output$mCases <- renderPlotly({
    return (BuildMap(data, input$cases))
  })
})
