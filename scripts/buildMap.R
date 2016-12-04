# BuildMap file: function that returns a plotly map
library(plotly)
library(stringr)

# BuildMap function: fill this in with a function that returns a map:
# Derived from: https://plot.ly/r/choropleth-maps/

BuildMap <- function(data, map.var) {
  # light grey boundaries
  l <- list(color = toRGB("grey"), width = 0.5)
  
  # specify map projection/options
  g <- list(
    showframe = FALSE,
    showcoastlines = FALSE,
    projection = list(type = 'Mercator')
  )
  
  # Make equation for map color / text
  var.equation <- paste0('~', map.var)
  
  # Plot
  p <- plot_geo(data) %>%
    add_trace(
      z = eval(parse(text = var.equation)), text = ~Country, locations = ~CODE,
      color = eval(parse(text = var.equation)), colors = 'Purples'
    ) %>%
    colorbar(title = "Number of Cases (M = millions, k = thousands)") %>%
    layout(
      title = str_to_title(map.var),
      geo = g
    )
  return(p)
}