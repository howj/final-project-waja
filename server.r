# install.packages("rworldmap")
library(shiny)
library(rworldmap)

data <- read.csv("data/malaria_info.csv")

source('./scripts/mapPolys.R')
source('./scripts/rwmCheckAndLoadInput.R')
source('./scripts/joinCountryData2Map.R')
source('./scripts/getMap.R')
source('./scripts/rwmGetISO3.R')

sPDF <- joinCountryData2Map(data, joinCode='NAME', nameJoinColumn='Country')

# Generate the Map 
shinyServer(function(input, output) {
  output$mPlot <- renderPlot({
    mapParams <- mapPolys(sPDF, nameColumnToPlot='X2014.malaria.deaths', mapRegion='world',
                          missingCountryCol='dark grey', numCats=10, 
                          colourPalette=c('green4','green1','greenyellow','yellow','yellow2','orange','coral','red','red3','red4'),
                          addLegend=TRUE,
                          oceanCol='light blue')
    mtext("[Grey Color: No Data Available]",side=1,line=-1)
  })
})