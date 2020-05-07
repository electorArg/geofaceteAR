#' Nombres de grillas disponibles para geofaeteAR
#'
#'@name names
#'@docType data
#'@author Juan Pablo Ruiz Nicolini 
#'@keywords data


## code to prepare `names` dataset goes here

# GET PROVINCE NAMES AND (ELECTORAL CODES)
provCode <- readr::read_csv("https://raw.githubusercontent.com/electorArg/PolAr_Data/master/geo/provCode.csv")

# GET ELECTORAL AND ADMISNITRATIVE CODES (PROVINCIAL AND DEPARTAMENTAL)
dine_indec <- readr::read_csv("https://raw.githubusercontent.com/electorArg/PolAr_Data/master/geo/dine_indec.csv") %>% 
  dplyr::mutate(codprov = stringr::str_pad(codprov, 2, "left", 0), 
         coddepto = stringr::str_pad(coddepto, 3, "left", 0), 
         codprov_censo = stringr::str_pad(codprov_censo, 2, "left", 0), 
         coddepto_censo = stringr::str_pad(coddepto_censo, 3, "left", 0))


# JOIN WITH PROVINCE NAMES         
data <- dine_indec %>% 
  dplyr::left_join(provCode)


### GET NAMES FOR GRIDS

names <- c("ARGENTINA", unique(data$name_prov)) %>% as.data.frame()
colnames(names) <- c("Distrito")

usethis::use_data("names")