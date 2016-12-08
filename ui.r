library(shiny)
library(dplyr)
library(plotly)
mdata <- read.csv("./data/malaria_data.csv", stringsAsFactors = FALSE)
# Panel for the rworldmap map
shinyUI(navbarPage("Interactive Map of Malaria Deaths and Cases by Country",
                   tabPanel("Summary",
                        p(strong("Malaria"),"is the", code("number one"), "infectious disease that kills the most people worldwide every year. Although rates of 
                            infection have decreased over the years from increased prevention and control measures,", code("nearly half"), "the world is still at risk of 
                            malaria. Due to the significance of this infectious disease, we will be working with datasets of reported", span("deaths and cases", style = "color:blue"), "from malaria by 
                            country. The dataset is collected from the", em("World Health Organization (WHO) website"), "and we accessed it through", em("Global Health Observatory"), 
                            "data repository in the WHO website. This data contains number of reported deaths and cases from years", strong("2000"), "to", strong("2014"), "in", code("109"), 
                            "countries all across the region. This project will explore", span("the prevalence of malaria by country, the spread of malaria over time in the regions, and understand the risk factors 
                            associated with a high prevalence rate in a country.", style = "color:blue"), "Someone who is planning to", strong("travel to a certain country"), "would be interested in this information so 
                            he or she can learn the malaria prevalence in the country and therefore plan accordingly. Furthermore, anyone who would simply like to know the", strong("risks and 
                            impact of malaria"), "in that specific country would find this useful.")    
                   ),
                   tabPanel("Interactive Map of Deaths",
                            
                            titlePanel("Malaria Deaths per Country"),

                            sidebarLayout(
                              # User can select what data to show, which year of cases to show
                              sidebarPanel(
                                selectInput('deaths', label = 'Select a year',
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
                              ),
                              
                              # mainPanel
                              mainPanel(
                                plotlyOutput('mDeaths'),
                                br(),
                                br(),
                                p("This map shows the malaria deaths per each country in a specific year from 2000-2014
                                  . Hover over a country to show exact number of deaths and more info.")
                              )
                            )
                   ),
                   # Panel for the interactive plotly world map of cases per country
                   tabPanel("Interactive Map of Cases",
                            
                            titlePanel("Malaria Cases per Country"),
                            
                            
                            sidebarLayout(
                              # User can select what data to show, which year of cases to show
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
                                plotlyOutput('mCases'),
                                br(),
                                br(),
                                p("This map shows the malaria cases per each country in a specific year from 2000-2014
                                  . Hover over a country to show exact number of cases and other info.")
                              )
                            )
                   ),
                   # Panel for the interactive plotly scatter plot of change in deaths per country
                   tabPanel("Scatter Plot of Change in Deaths",
                            
                            titlePanel("Change in Malaria Deaths Between 2014 and 2000"),
                            
                            sidebarLayout(
                              # User can select what data to show by typing in the name of the country
                              sidebarPanel(
                                  textInput('search', label = "Enter a country name", value = '')

                              ),
                              
                              # mainPanel
                              mainPanel(
                                plotlyOutput('mChange'),
                                br(),
                                br(),
                                p("The chart shows the change in malaria deaths per country from 2000 to 2014.
                                  The size of the circle shows the magnitude of the decrease in deaths over the 14-year period.
                                  Hover over the dot to show the deaths in 2000 followed by the deaths in 2014. For some countries,
                                  the dot will not show up because the WHO data was incomplete (Example: Somalia).")
                              )
                            )
                   ),
                   tabPanel("Dataset of Cases and Deaths by Regions",
                            
                            sidebarLayout(
                              # User can select which region data to show
                              sidebarPanel(
                                selectInput("regions", label = 'Select region',
                                            choices = list("Africa", 
                                                           "Asia",
                                                           "Europe",
                                                           "North America",
                                                           "South America",
                                                           "Australia")),
                                radioButtons("type", label = 'Select the report of:', c("deaths", "cases")),
                                helpText("You can select the region and the type of report to see the dataset of the countries in the selected region")
                                ),
                              # mainPanel
                              mainPanel(
                                tableOutput('mTable')
                              )
                            )
                   ),
                   # tabPanel for bar plot 
                   tabPanel("Bar Graph of Mean Cases/Deaths per Region in 2014",
                            #
                            titlePanel("Mean Cases/Deaths per Region in 2014"),
                            
                            #
                            sidebarLayout(
                              # User can select what data to show
                              sidebarPanel(
                                selectInput('regionvar', label = 'Select an input...',
                                            choices = list("Mean Deaths" = "mean.deaths",
                                                           "Mean Cases" = "mean.cases"))
                              ),
                              
                              # mainPanel
                              mainPanel(
                                plotlyOutput('bar'),
                                br(),
                                br(),
                                p("This chart shows the mean deaths/cases per region of the world in 2014. See the detailed region tab
                                  for more info. Hover over a bar to see the exact means. The WHO does not have data for Malaria cases/deaths
                                  for Europe, however.")
                              )
                            )
                   )
                   
))
