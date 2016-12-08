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
source('./scripts/getData.R')
source('./scripts/buildScatter.R')
mdata <- getData(data)

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
  
  # Generates a scatter plot of change in malaria deaths/country built with plotly
  output$mChange <- renderPlotly({
    return(BuildScatter(mdata, input$search))
  })
  
  output$mTable <- renderTable({
    africa.countries <- data %>% filter(Region %in% c("Africa"))
    asia.countries <- data %>% filter(Region %in% c("Asia"))
    europe.countries <- data %>% filter(Region %in% c("Europe"))
    n.amer.countries <- data %>% filter(Region %in% c("North America"))
    s.amer.countries <- data %>% filter(Region %in% c("South America"))
    austrailia.countries <- data %>% filter(Region %in% c("Australia"))
    selectInput <- reactive({
      switch(input$regions, 
             "Africa"= africa.countries,
             "Asia"= asia.countries,
             "Europe" = europe.countries,
             "North America" = n.amer.countries,
             "South America" = s.amer.countries,
             "Austrailia" = austrailia.countries)
    })
    data <- selectInput()
    if (input$type == "cases") {
      data <- data %>% select(1, 4:18)
    } else {
      data <- data %>% select(1, 19:33)
    }
  })
})
