library(rvest)
library(tidyverse)

source('config.R')
source('functions.R')

flight_data <- DATASET_URL %>% 
  scrape_data() %>% 
  prepare_data()
  
write_csv(flight_data, 'cumulative_company_flight_data.csv')

  




