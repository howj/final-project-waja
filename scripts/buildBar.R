# buildBar: file that returns a plotly bar
library(plotly)
library(stringr)

# buildBar

BuildBar <- function(region.data, regionvar) {
  plot_ly(
    x = region.data$Region,
    y = region.data[[regionvar]],
    name = "Averages of deaths/cases per country",
    type = "bar"
  ) %>%
    return()
}