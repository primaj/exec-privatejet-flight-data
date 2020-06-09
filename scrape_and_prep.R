library(rvest)
library(tidyverse)

source('config.R')
source('functions.R')

flight_data <- scrape_data(DATASET_URL)

