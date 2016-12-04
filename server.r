library(shiny)
library(rworldmap)

data <- read.csv("data/overall_malaria.csv")

source('./scripts/mapPolys.R')
source('./scripts/rwmCheckAndLoadInput.R')
source('./scripts/joinCountryData2Map.R')
source('./scripts/getMap.R')
source('./scripts/rwmGetISO3.R')
source('./scripts/BuildWorldMapCases.R')

sPDF <- joinCountryData2Map(data, joinCode='NAME', nameJoinColumn='Country')

# light grey boundaries
l <- list(color = toRGB("grey"), width = 0.5)

# specify map projection/options
g <- list(
  showframe = FALSE,
  showcoastlines = FALSE,
  projection = list(type = 'Mercator')
)

# Generate the Map 
shinyServer(function(input, output) {
  output$mPlot <- renderPlot({
    mapParams <- mapPolys(sPDF, nameColumnToPlot=input$yearvar, mapRegion='world',
                          missingCountryCol='dark grey', numCats=10, 
                          colourPalette=c('green4','green1','greenyellow','yellow','yellow2','orange','coral','red','red3','red4'),
                          addLegend=TRUE,
                          oceanCol='light blue')
    mtext("[Grey Color: No Data Available]",side=1,line=-1)
  })
  
  output$plotlyWorldMapCases <- renderPlotly({
    return (BuildWorldMapCases(data, input$plotyear))
  })
})
