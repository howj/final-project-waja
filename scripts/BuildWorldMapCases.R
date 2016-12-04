library(plotly)
library(dplyr)

data <- read.csv("data/overall_malaria.csv")

BuildWorldMapCases <- function(dataset, year) {
  
  # light grey boundaries
  l <- list(color = toRGB("grey"), width = 0.5)

  # specify map projection/options
  g <- list(
    showframe = FALSE,
    showcoastlines = FALSE,
    projection = list(type = 'Mercator')
  )
  
  p <- plot_geo(dataset) %>%
    add_trace(
      z = ~plotyear., color = ~plotyear, colors = 'Blues',
      text = ~COUNTRY, locations = ~CODE, marker = list(line = l)
    ) %>%
    colorbar(title = 'Cases') %>%
    layout(
      title = 'WHO Data for Malaria Deaths 2000-2014<br>Source:<a href="http://apps.who.int/gho/data/node.main.A1367?lang=en">WORLD HEALTH ORGANIZATION</a>',
      geo = g
    )
  p %<% return()
}