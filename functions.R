scrape_data <- function(url){
  
  on.exit(message('Scrape complete!\n'))
  
  url %>%
    read_html() %>% 
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
  
  
}

prepare_data <- function(data){
  
  on.exit(message('Data prep. complete!\n'))
  data %>% 
    group_by(company, departure_time) %>% 
    summarise(daily_count = n()) %>% 
    ungroup() %>% 
    pivot_wider(
      id_cols = company,
      values_from = daily_count,
      names_from = departure_time
    ) %>% 
    pivot_longer(
      cols = -company,
      names_to = 'departure_time', 
      values_to = 'daily_count'
    ) %>% 
    mutate_all(~replace_na(.x, 0)) %>% 
    group_by(company) %>% 
    arrange(departure_time) %>% 
    mutate(daily_cum_total = cumsum(daily_count))
  
  
  
}