library(tidyverse)
library(rvest)
library(purrr)

dir.create("data/dennys", showWarnings = F)

# manually read top level of the hierarchy
baseURL = "http://www2.stat.duke.edu/~cr173/dennys/locations.dennys.com/"
stateList = read_html(baseURL)
states = html_nodes(stateList, ".c-directory-list-content-item-link") %>% 
  html_attr("href") 

# return those elements of the character vector at "num" level in the html hierarchy
# for this html tree level 0 is state, 1 is city, and 2 is restaurant
places = function(chars, num) {
  chars[str_count(chars, "/") == num]
}

# return suburls listed at the "tag" of each suburl "place"
sweepOver = function(place, tag, state = FALSE) {
  lapply(place, function(item) {
    if(state) stateName = str_match(item, "(..).*")[2]
    placeList = read_html(paste0(baseURL, item)) %>%
      html_nodes( tag) %>% 
      html_attr("href")
    if(state) return(paste0(stateName, "/", placeList)) else return(placeList)
  }) %>% unlist()
}

# expand the place lists hierarchically
stateLevels = places(states, 0)
allCities = sweepOver(stateLevels, tag = ".c-directory-list-content-item-link")
cityLevels = places(allCities, 1) %>% c(places(states, 1))
allItems = sweepOver(cityLevels, tag = ".c-location-grid-item-title a", state = TRUE)
restaurants = c(states, allCities, allItems) %>% places(2)

# download webpages
walk(restaurants, function(rest) {
  name = str_match(rest, "\\d{6}")[1]
  url = paste0(baseURL,rest)
  download.file(url = url, paste0("data/dennys/", name, ".html"))
})

