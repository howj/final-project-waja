library(shiny)

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
                   tabPanel("Interactive Map of Deaths",
                            #
                            titlePanel("1"),
                            
                            #
                            sidebarLayout(
                              # User can select what data to show
                              sidebarPanel(
                                selectInput('plotyear', label = 'Select a year',
                                            choices = list("123" = "GDP..BILLIONS."))
                                                           #"2014 deaths" = "X2014.malaria.deaths",
                                                           #"2013 deaths" = "X2013.malaria.deaths", 
                                                           #"2012 deaths" = "X2012.malaria.deaths",
                                                           #"2011 deaths" = "X2011.malaria.deaths",
                                                           #"2010 deaths" = "X2010.malaria.deaths",
                                                           #"2009 deaths" = "X2009.malaria.deaths",
                                                           #"2008 deaths" = "X2008.malaria.deaths",
                                                           #"2007 deaths" = "X2007.malaria.deaths",
                                                           #"2006 deaths" = "X2006.malaria.deaths",
                                                           #"2005 deaths" = "X2005.malaria.deaths",
                                                           #"2004 deaths" = "X2004.malaria.deaths",
                                                           #"2003 deaths" = "X2003.malaria.deaths",
                                                           #"2002 deaths" = "X2002.malaria.deaths",
                                                           #"2001 deaths" = "X2001.malaria.deaths",
                                                           #"2000 deaths" = "X2000.malaria.deaths"))
                              ),
                            
                              # mainPanel
                              mainPanel(
                                plotOutput('map')
                              )
                            )
                   )
))