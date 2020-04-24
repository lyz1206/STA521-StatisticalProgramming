library(tidyverse)
library(purrr)
library(rvest)

# function adapted from lecture script
get_restaurant = function(url) {
  page = read_html(url)
  
  location = html_nodes(page, "#schema-location span.coordinates>meta") %>% html_attr("content")
  
  data_frame(
    name      = html_nodes(page, "#location-name")         %>% html_text(),
    street    = html_nodes(page, ".c-address-street-1")    %>% html_text(),
    city      = html_nodes(page, ".c-address-city")        %>% html_text() %>% str_replace_all(",$",""),
    state     = html_nodes(page, ".c-address-state")       %>% html_text(),
    zipcode   = html_nodes(page, ".c-address-postal-code") %>% html_text(),
    phone     = html_nodes(page, "#telephone")             %>% html_text(),
    latitude  = location[1] %>% as.numeric(),
    longitude = location[2] %>% as.numeric()
    
  )
}

# a full address line is formed
my_html = list.files(path = "data/dennys/", full.name = TRUE)
dennys = map_dfr(my_html, get_restaurant) %>%
  mutate(address = paste(street, city, state, zipcode)) %>%
  select(-street, -city, -state, - zipcode)

saveRDS(dennys, file = "data/dennys.rds")
