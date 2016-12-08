# library the PLOTLY package and the STRINGR package
library(plotly)
library(stringr)

# Build Scatter function 
BuildScatter <- function(data,  search = '', xvar = 'X2000.malaria.deaths', yvar = 'X2014.malaria.deaths') {
  
  # Get x and y max
  xmax <- max(data[,xvar]) * 1.5
  ymax <- max(data[,yvar]) * 1.5
  x.equation <- paste0('~', xvar)
  y.equation <- paste0('~', yvar)
  
  # Filter down to species, then graph
  data <- data %>% 
    filter(grepl(search, Country))
  
  plot_ly(data=data, x = eval(parse(text = x.equation)), 
          y = eval(parse(text = y.equation)), 
          mode='markers', 
          marker = list(
            opacity = .4, 
            size = ~change.in.death
          )) %>% 
    layout(xaxis = list(range = c(0, xmax), title = xvar), 
           yaxis = list(range = c(0, ymax), title = yvar)
    ) %>% 
    return()
}