library(shiny)
library(dplyr)

mainPanel(
  tabsetPanel(id="tp",
              tabPanel("Map View", plotOutput("mPlot", height="560px", width="950px"))
  )
)

shinyUI(navbarPage("Interactive Map of Malaria Deaths by Country",
                   tabPanel("World Map and Malaria Deaths, built with rworldmap",
                            #
                            titlePanel("Summary of data by country"),
                            
                            #
                            sidebarLayout(
                              # User can select what data to show
                              sidebarPanel(
                                selectInput('yearvar', label = 'Select a year',
                                            choices = list("2014 deaths" = "X2014.malaria.deaths",
                                                           "2013 deaths" = "X2013.malaria.deaths", 
                                                           "2012 deaths" = "X2012.malaria.deaths",
                                                           "2011 deaths" = "X2011.malaria.deaths",
                                                           "2010 deaths" = "X2010.malaria.deaths",
                                                           "2009 deaths" = "X2009.malaria.deaths",
                                                           "2008 deaths" = "X2008.malaria.deaths",
                                                           "2007 deaths" = "X2007.malaria.deaths",
                                                           "2006 deaths" = "X2006.malaria.deaths",
                                                           "2005 deaths" = "X2005.malaria.deaths",
                                                           "2004 deaths" = "X2004.malaria.deaths",
                                                           "2003 deaths" = "X2003.malaria.deaths",
                                                           "2002 deaths" = "X2002.malaria.deaths",
                                                           "2001 deaths" = "X2001.malaria.deaths",
                                                           "2000 deaths" = "X2000.malaria.deaths"))
                                #sliderInput("yearvar", "Integer:", 
                                #           min=2000, max=2014, value=1
                              ),
                              
                              # mainPanel
                              mainPanel(
                                plotOutput("mPlot", height="560px", width="950px")
                              )
                            )
                   ),
                   tabPanel("Interactive Map of Cases",
                            #
                            titlePanel("Malaria Cases per Country"),
                            
                            #
                            sidebarLayout(
                              # User can select what data to show
                              sidebarPanel(
                                selectInput('cases', label = 'Select a year',
                                            choices = list("2014 cases" = "X2014.malaria.cases",
                                                           "2013 cases" = "X2013.malaria.cases", 
                                                           "2012 cases" = "X2012.malaria.cases",
                                                           "2011 cases" = "X2011.malaria.cases",
                                                           "2010 cases" = "X2010.malaria.cases",
                                                           "2009 cases" = "X2009.malaria.cases",
                                                           "2008 cases" = "X2008.malaria.cases",
                                                           "2007 cases" = "X2007.malaria.cases",
                                                           "2006 cases" = "X2006.malaria.cases",
                                                           "2005 cases" = "X2005.malaria.cases",
                                                           "2004 cases" = "X2004.malaria.cases",
                                                           "2003 cases" = "X2003.malaria.cases",
                                                           "2002 cases" = "X2002.malaria.cases",
                                                           "2001 cases" = "X2001.malaria.cases",
                                                           "2000 cases" = "X2000.malaria.cases"))
                              ),
                              
                              # mainPanel
                              mainPanel(
                                plotlyOutput('mCases')
                              )
                            )
                   )
))