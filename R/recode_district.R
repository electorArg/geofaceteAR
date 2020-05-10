#'Recodifica códigos de provincias o departamentos de Argentina
#'@description
#'Función que permite recodificar código de provincia para utilizacion de grilla de Argentina y de departamentos para los 24 distritos
#'  subnacionales y hacer mas sencillala vinculacion con distinto tipo de bases de datos con diferentes indicadores. 
#'  
#'@return  El valor por defecto es \code{codprov} y \code{coddepto} para provincia y departamentos, respectivamente. Estos corresponden 
#' a la codificacion de los escrutinios provisorios de elecciones nacionales. Se puede optar por la nomenclautra de indec \code{*_censo} para
#' ambos niveles o \code{ISO 3166-2}, para el nivel provincial. 
#'
#'@details Respecto los datos se puede consultar la documentación de 
#' \href{https://www.iso.org/obp/ui/#iso:code:3166:AR}{\code{ISO 3166-2} - International Organization for Standardization} y del
#' del \href{https://www.iso.org/obp/ui/#iso:code:3166:AR}{\emph{INDEC}}. \code{codprov} es la codificacion con la que se publciaron las bases de datos 
#' de INDRA, empresa encargada por muchos años de la tarea y utilizados en la libería \href{https://electorarg.github.io/polAr/}{polAr}. 
#'
#'@param type cual es el código qye se quiere definir en la grilla. Las opciones son \code{'indra'}, \code{'indec'} o \code{'iso'}
#'
#'@param data debe ser un 'data.frame' obtenido con \code{\link{get_grid}}. Las grillas grillas disponibles 
#' se pueden chequear con \code{\link{show_arg_codes}}.
#'
#' 
#' 
#' @examples 
#' 
#' 
#' 
#' get_grid("ARGENTINA") %>% 
#'    recode_district(type = "iso") 
#' 
#' 
#'@export


recode_district <- function(data, 
                        type = NULL){

  # Check parameters

  assertthat::assert_that(is.data.frame(data), 
                          msg = glue::glue("{data} debe ser un 'data.frame' obtenido con la funcion get_grid()"))
  
  assertthat::assert_that(dim(data)[2] == 5, 
                          msg = glue::glue("{data} debe ser un 'data.frame' obtenido con la funcion get_grid()"))
  
  assertthat::assert_that(is.character(type), 
                          msg = "type debe ser del tipo 'character'")
  
  

  
  if("CABA" %in% data$name){
    
    assertthat::assert_that(is.character(type), 
                            msg = "type debe ser del tipo 'character'")
    
    
    assertthat::assert_that(length(type) == 1, 
                            msg = glue::glue("{type} no es una opcion valida para recodificar grillas de provincias. 
                                             Debe elegir una opcion entre 'indra', 'indec' o 'iso'"))
    
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
         }else{
           
           assertthat::assert_that(is.character(type), 
                                   msg = "type debe ser del tipo 'character'")
           
           
           assertthat::assert_that(length(type) == 1, 
                                   msg = glue::glue("{type} no es una opcion valida para recodificar grillas de departamentos. 
                                                    Debe elegir una opcion entre 'indra'o 'indec'"))
           
           assertthat::assert_that(type %in% c("indra", "indec"),
                                   msg = glue::glue("{type} no es una opcion valida para recodificar grillas de departamentos. 
                                                    Debe elegir una opcion entre 'indra'o 'indec'"))
           
           
           #### hack para filtrar grilla de deprtamento que se quiere recodear
           
           # Me traigo todos los id de depto de tdas las provincias y genero un id unico
           full_codes <- full_geo_metadata %>% 
             dplyr::select(coddepto, nomdepto_censo,coddepto_censo, name_prov) %>% 
             dplyr::mutate(nomdepto_censo = stringr::str_to_upper(nomdepto_censo), 
                           id = paste0(coddepto, stringr::str_remove_all(nomdepto_censo, " "), name_prov))
           

           # agrego a la base de grillas el mismo codigo de id de la metadata
           grillas_depto_id <- grillas_geofacet  %>% 
             dplyr::bind_rows(.id = "name_prov") %>% 
             tibble::as_tibble()%>% 
             dplyr::slice(25:dim(.)[1]) %>% 
             dplyr::mutate(code = stringr::str_pad(code, 3, "left", 0), 
                           id = paste0(code, stringr::str_remove_all(name, " "), name_prov)) 
           
            # Creo filtro para seleccionar grilla correcta
           filtro_provincia <- data %>%
                  dplyr::left_join(grillas_depto_id) %>% 
                  dplyr::left_join(full_codes)
           
           filtro_id <- filtro_provincia %>%
             dplyr::pull(id)
           
           # filtro la grilla de interes
           data <- grillas_depto_id %>% 
             dplyr::filter(id %in% filtro_id) %>% 
             dplyr::select(name, code, row, col)
           
           #######################################################################
           
           if(type == "indec"){
             
             data %>% 
               dplyr::mutate(code = dplyr::case_when(
                 code == filtro_provincia$coddepto ~ filtro_provincia$coddepto_censo
               )) 
             
             
           } else{
             
             data
             
           }
    
    
  }
}