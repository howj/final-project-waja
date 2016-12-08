# write a function that add a new column of "change.in.death" to the data frame 
mData <- read.csv("data/overall_malaria.csv")
getData <- function(data) {

  data <- mData %>%
  mutate(change.in.death = X2000.malaria.deaths-X2014.malaria.deaths)
  write.csv(data, file = "./data/malaria_data.csv")
   return(data)
}