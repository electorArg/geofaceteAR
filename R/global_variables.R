#' \code{geofaceteAR} package
#'
#' Grillas como mapas para Argentina y sus provincias
#' See the README on
#' \href{https://github.com/electorArg/geofaceteAR/blob/master/README.md}{Github}
#'
#' @docType package
#' @name geofaceteAR
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines

if(getRversion() >= "2.15.1")  utils::globalVariables(c("distrito", 
                                                        "full_codes",
                                                        "full_geo_metadata", 
                                                        "codprov", 
                                                        "codprov_censo", 
                                                        "codprov_iso", 
                                                        "code", 
                                                        "name_prov", 
                                                        "name_iso", 
                                                        "coddepto", 
                                                        "coddepto_censo", 
                                                        "nomdepto_censo"))