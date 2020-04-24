library(tidyverse)
library(jsonlite)
library(purrr)

# collect the filepaths for the filed get_lq downloaded
ids = list.files(path = "data/lq/", pattern = ".json")

# build tidy dataframe with selected information
la_quinta = map_dfr(ids, function(id) {
  hotlist = fromJSON(paste0("data/lq/", id))
  tibble(name        = hotlist[["conciseName"]], 
         country     = hotlist[[c("address", "countryDisplay")]],
         address     = paste(hotlist[[c("address", "street")]],
                             hotlist[[c("address", "city")]],
                             hotlist[[c("address", "stateProvinceDisplay")]],
                             hotlist[[c("address", "postalCode")]]),
         # some hotels in mexico do not have listed phone numbers
         phone       = ifelse(is.null(hotlist[[c("primaryPhoneNumber")]]), NA_character_, 
                               paste0(hotlist[[c("primaryPhoneNumber", "countryCode")]],
                                      hotlist[[c("primaryPhoneNumber", "areaCode")]],
                                      hotlist[[c("primaryPhoneNumber", "number")]])),
         latitude    = hotlist[["latitude"]] %>% as.numeric(),
         longitude   = hotlist[["longitude"]] %>% as.numeric(),
         wifi        = any(hotlist[[c("categorizedFeatures", "Amenities & Services", "id")]]
                           %in% "FREE_WIRELESS_INTERNET"),
         outdoorPool = any(hotlist[[c("categorizedFeatures", "Amenities & Services", "id")]]
                           %in% "OUTDOOR_POOL"),
         indoorPool  = any(hotlist[[c("categorizedFeatures", "Amenities & Services", "id")]]
                           %in% "INDOOR_POOL")
         )
}) %>% filter(country == "United States" | country == "Canada" | country == "Mexico")
# only those data for the specified countries are pulled

saveRDS(la_quinta, file = "data/lq.rds")
