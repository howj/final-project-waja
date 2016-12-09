# library the packages needed
library(shiny)
library(dplyr)
library(rworldxtra)
library(plotly)

# Read in data
data <- read.csv("data/overall_malaria.csv")
data.with.zeros <- read.csv("data/overall_malaria_zeros.csv")
# mutate the dataset to contain deaths and cases per 1000 people in the country
data.with.pop <- mutate(data, malaria.deaths.per.1000 = (X2014.malaria.deaths * (1000/X2014.pop)), 
               malaria.cases.per.1000 = (X2014.malaria.cases * (1000/X2014.pop)))

source('./scripts/buildMap.R')
source('./scripts/getData.R')
source('./scripts/buildScatter.R')
source('./scripts/buildBar.R')
mdata <- getData(data)

# Summarise data per region
summary.region <- group_by(data.with.zeros, Region) %>% 
  summarise(mean.deaths = mean(X2014.malaria.deaths), mean.cases = mean(X2014.malaria.cases))

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
    australia.countries <- data %>% filter(Region %in% c("Australia"))
    selectInput <- reactive({
      switch(input$regions, 
             "Africa"= africa.countries,
             "Asia"= asia.countries,
             "Europe" = europe.countries,
             "North America" = n.amer.countries,
             "South America" = s.amer.countries,
             "Australia" = australia.countries)
    })
    data <- selectInput()
    if (input$type == "cases") {
      data <- data %>% select(1, 4:18)
    } else {
      data <- data %>% select(1, 19:33)
    }
  })
  
  # Make a bar graph for death/cases average per regoin
  output$bar <- renderPlotly({
    return(BuildBar(summary.region, input$regionvar))
  })
  
  # Make a map for malaria deaths/cases per 1000 people in each country
  output$mPer1000<- renderPlotly({
    return (BuildMap(data.with.pop, input$mPer1000var))
  })
})
