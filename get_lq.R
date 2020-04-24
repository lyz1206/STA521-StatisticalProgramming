library(tidyverse)
library(purrr)

dir.create("data", showWarnings = F)
dir.create("data/lq", showWarnings = F)

baseURL = "http://www2.stat.duke.edu/%7Ecr173/lq/www.lq.com/bin/lq/"

# define a compound function to download quietly by trial and error
possibly.download.file = possibly(download.file, NA)

# download hotel-specific json files
walk(0:9999, function(x) {
  id = sprintf("%04d", x)
  url = paste0(baseURL,"hotel-summary.",id,".en.json" )
  possibly.download.file(url = url, paste0("data/lq/", id, ".json"))
})
