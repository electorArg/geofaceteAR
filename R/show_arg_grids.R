#' Diccionario de grillas (\emph{facets}) disponibles
#'
#'@description
#' Funcion que devuelve un data.frame con los nombre de distrito disponibles (parametro necesarios para llamar la grilla de interes)
#'
#'@param viewer Por default es \code{TRUE}. Cuando \code{FALSE} imprime en consola.
#'
#'@import geofacet
#'
#'@export


show_arg_grids <- function(viewer = TRUE){


  names <- data.frame(Distrito = c("ARGENTINA", "CABA", "CATAMARCA", "CHACO", "CHUBUT", "CORDOBA", "CORRIENTES",
    "ENTRE RIOS", "FORMOSA", "JUJUY", "LA PAMPA", "LA RIOJA", "MENDOZA", "MISIONES",
    "NEUQUEN","PBA", "RIO NEGRO", "SALTA", "SANTA CRUZ", "SANTA FE", "SANTIAGO DEL ESTERO",
    "SAN JUAN", "SAN LUIS", "TIERRA DEL FUEGO", "TUCUMAN"))



  if(viewer == TRUE){

    names %>%
      gt::gt()

         }else{

           names

                           }
  }





