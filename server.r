# install.packages("rworldmap")
library(shiny)
library(rworldmap)

data <- read.csv("data/malaria_info.csv")

source('./rworldmap/R/mapPolys.R')
source('./rworldmap/R/rwmCheckAndLoadInput.R')
source('./rworldmap/R/joinCountryData2Map.R')
source('./rworldmap/R/getMap.R')
source('./rworldmap/R/rwmGetISO3.R')

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