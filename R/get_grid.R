#'Carga grillas de distritos de Argentina
#'@description
#'Funcioó que descaga grillas (\emph{facet}) para acomodarlas como si fueran mapas de provincias y deparamentos
#' de Argentina.
#' 
#' 
#' @examples 
#' 
#' get_grid("TUCUMAN")
#'
#'@param distrito un character con el nombre del distrito que se quiere descargar. Disponibles grillas para Argentina
#' y para las 24 provincias. Se pueden chequear los parametros con \code{\link{show_arg_codes}}.
#'@export


  get_grid <- function(distrito = NULL) {

    # Check parameters

    assertthat::assert_that(!is.null(distrito),
                            msg = "debe ingresar un distrito valido. Chequear opciones con 'show_arg_grids()")
                            
    assertthat::assert_that(is.character(distrito), 
                            msg = "distrito debe ser del tipo 'character'. Chequear opciones con 'show_arg_grids()")

    assertthat::assert_that(distrito %in% c("ARGENTINA", "CABA", "CATAMARCA", "CHACO", "CHUBUT", "CORDOBA", "CORRIENTES",
                                            "ENTRE RIOS", "FORMOSA", "JUJUY", "LA PAMPA", "LA RIOJA", "MENDOZA", "MISIONES",
                                            "NEUQUEN","PBA", "RIO NEGRO", "SALTA", "SANTA CRUZ", "SANTA FE", "SANTIAGO DEL ESTERO",
                                            "SAN JUAN", "SAN LUIS", "TIERRA DEL FUEGO", "TUCUMAN"),
                            msg = "no es un distrito valido. Chequearlos con 'show_arg_grids()")


          # Cargo geo-grids


           grillas <- grillas_geofacet %>%
             dplyr::bind_rows(.id = "name_provincia") %>% 
             dplyr::group_by(name_provincia) %>% 
             dplyr::select(row, col, code, name, name_provincia) %>% 
             tidyr::nest()
             
           
           grillas %>%
             dplyr::filter(name_provincia == distrito) %>% 
             tidyr::unnest(cols = c(data)) %>% as.data.frame()

  }
