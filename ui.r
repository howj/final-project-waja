library(shiny)

mainPanel(
  tabsetPanel(id="tp",
              tabPanel("Map View", plotOutput("mPlot", height="560px", width="950px"))
  )
)