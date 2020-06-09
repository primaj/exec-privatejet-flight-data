library(rvest)
library(tidyverse)

source('config.R')
source('functions.R')

flight_data <- DATASET_URL %>% 
  scrape_data() %>% 
  prepare_data()


flight_data %>% 
  pivot_data() %>% 
  write_csv('cumulative_company_flight_data.csv')

  




