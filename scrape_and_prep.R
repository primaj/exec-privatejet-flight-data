library(rvest)
library(tidyverse)


url <- "https://www.quiverquant.com/sources/corporateflights"

flight_data_html <- url %>%
  read_html()

flight_data <- flight_data_html %>% 
  html_node('table') %>% 
  html_table() %>% 
  as_tibble() %>% 
  rename(
    company = 'Company',
    departure_time = 'Departure time',
    departure_city = 'Departure city',
    arrival_city = 'Arrival city'
  ) %>%
  mutate(
    epoch = as.numeric(substr(departure_time, 1, 10)),
    departure_time = as.Date(as.POSIXct(epoch, origin="1970-01-01"))
  )
