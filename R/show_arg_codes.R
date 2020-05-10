#' Diccionario de codigos identificadores de distritos 
#'
#'@description
#' Funcion que devuelve un data.frame con codigos y equivalencias de identificacion de unidades geograficas
#'@param viewer Por default es \code{TRUE}. Cuando \code{FALSE} imprime en consola.
#'@param nivel  Opcion para ver diccionario a nivel de \code{"provincias"} o de \code{"departamentos"}.
#'@import geofacet
#'
#'@examples 
#'
#' show_arg_codes(viewer = FALSE)
#' 
#' @details  La opción \code{viewer = TRUE} muestra un tabulado formateado en el _Viewer_ de _RStudio_. 
#'
#'@export



show_arg_codes <- function(viewer = TRUE, 
                           nivel  =  "provincias"){
  
  # Check parameters
  
  
  assertthat::assert_that(is.character(nivel), 
                          msg = "nivel debe ser del tipo 'character'. Opciones 'provincias' (default) o 'departamentos'")
  
  assertthat::assert_that(nivel %in% c("provincias", "departamentos"), 
                          msg = " 'provincias' o 'departamentos' son las unicas opciones validas")
  
  
  
 seleccion <-  if(nivel == "provincias"){

  full_geo_metadata %>% 
    dplyr::select(id = name_prov, codprov, codprov_censo, codprov_iso, name_iso) %>% 
    dplyr::distinct()

  } else {

 full_geo_metadata %>% 
    dplyr::select(id = name_prov, codprov, coddepto,
                codprov_censo, coddepto_censo, nomdepto_censo)
  

      }
  
  
  
  if(viewer == FALSE){
    
    
    seleccion
    
  } else {
    
    
    selection <- dplyr::case_when(nivel == "provincias" ~ "Provincial",
                                  nivel == "departamentos" ~ "Departamental") 
    
    seleccion %>%
      gt::gt()%>% 
      gt::cols_label(id = gt::md(("ID grilla"))) %>% 
      gt::tab_spanner(columns = dplyr::matches("censo"), label = "INDEC") %>% 
      gt::tab_spanner(columns = dplyr::matches("iso"), label = "ISO") %>% 
      gt::tab_spanner(columns = dplyr::matches("prov$|depto$"), label = "INDRA") %>%
      gt::tab_header(
        title = gt::md("**Diccionario de equivalencias para identificadores geogrficos**"),
        subtitle = gt::md(glue::glue(("**Argentina - Nivel {selection}**")))) %>% 
      gt::tab_source_note(
        source_note = gt::md("**Fuente:** geofaceteAR  - *https://electorarg.github.io/geofaceteAR*"))
    
    
    
  }
  
  
  
  }
