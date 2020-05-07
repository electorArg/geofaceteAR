#'Recodifica Codigos de Provincias para grilla de Argentina
#'@description
#'Funcion que permite recodificar codigo de provincia para utilizacion de grilla de Argentina y hacer mas sencilla
#' la vinculacion con distinto tipo de bases de datos con diferentes indicadores. El valor por defecto es \code{codprov}
#' que corresponde a la codificacion de los escrutinios provisorios. Se puede optar por la nomenclautra de 
#' indec \code{codprov_censo} o \code{ISO 3166-2}.  
#'@details Respecto los datos se puede consultar la documentación de 
#' \href{https://www.iso.org/obp/ui/#iso:code:3166:AR}{\code{ISO 3166-2} - International Organization for Standardization} y del
#' del \href{https://www.iso.org/obp/ui/#iso:code:3166:AR}{\emph{INDEC}}. \code{codprov} es la codificacion con la que se publciaron las bases de datos 
#' de INDRA, empresa encargada por muchos años de la tarea y utilizados en la libería \href{https://electorarg.github.io/polAr/}{polAr}.
#'@param type cual es el codgo que se quiere definir en la grilla. Las opciones son \code{'indra'}, \code{'indec'} o \code{'iso'}
#'@param data debe ser un 'data.frame' obtenido con \code{\link{get_grid}}. Las grillas grillas disponibles 
#' se pueden chequear con \code{\link{show_arg_grids}}.
#'@export


recode_prov <- function(data, 
                        type = NULL){

  # Check parameters

  assertthat::assert_that(is.data.frame(data), 
                          msg = glue::glue("{data} debe ser un 'data.frame' obtenido con la funcion get_grid()"))
  
  assertthat::assert_that(dim(data)[2] == 4, 
                          msg = glue::glue("{data} debe ser un 'data.frame' obtenido con la funcion get_grid()"))
  
  assertthat::assert_that(is.character(type), 
                          msg = "type debe ser del tipo 'character'")
  
  
  assertthat::assert_that(length(type) == 1, 
                          msg = glue::glue("{type} no es una opcion valida. Debe elegir una opcion entre 'indra', 'indec' o 'iso'"))
  
  assertthat::assert_that(type %in% c("indra", "indec", "iso"),
                          msg = glue::glue("{type} no es una opcion valida ('indra', 'indec', 'iso')"))
  
  
  
  full_codes <- full_geo_metadata %>% 
    dplyr::select(codprov, codprov_censo, codprov_iso) %>% 
    dplyr::distinct()
  
  if(type == "indec"){
    
    data %>% 
      dplyr::mutate(code = ifelse(code == full_codes$codprov_censo, 
                           full_codes$codprov_censo, 
                           full_codes$codprov_censo))
    
    
  } else if(type == "iso"){
    
    data %>% 
      dplyr::mutate(code = ifelse(code == full_codes$codprov_iso, 
                           full_codes$codprov_codprov_iso, 
                           full_codes$codprov_iso))
  } else{
    
    data
    
  }
}
