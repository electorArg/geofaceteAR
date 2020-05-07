#'Carga grillas de distritos de Argentina
#'@description
#'Funcion que descaga grillas (\emph{facet}) para acomodarlas como si fueran mapas de provincias y deparamentos
#' de Argentina.
#'
#'@param distrito un character con el nombre del distrito que se quiere descargar. Disponibles grillas para Argentina
#' y para cada provincia. Se pueden chequear los parametros con \code{\link{show_arg_grids}}.
#'@export


  get_grid <- function(distrito = NULL) {



    # Check for internet coection
    attempt::stop_if_not(.x = curl::has_internet(),  # from eph package
                         msg = "No se detecto acceso a internet. Por favor chequea tu conexion.")

    # Check parameters


    assertthat::assert_that(is.character(distrito), msg = "distrito debe ser del tipo 'character'")

    assertthat::assert_that(distrito %in% c("ARGENTINA", "CABA", "CATAMARCA", "CHACO", "CHUBUT", "CORDOBA", "CORRIENTES",
                                            "ENTRE RIOS", "FORMOSA", "JUJUY", "LA PAMPA", "LA RIOJA", "MENDOZA", "MISIONES",
                                            "NEUQUEN","PBA", "RIO NEGRO", "SALTA", "SANTA CRUZ", "SANTA FE", "SANTIAGO DEL ESTERO",
                                            "SAN JUAN", "SAN LUIS", "TIERRA DEL FUEGO", "TUCUMAN"),
                            msg = "no es un distrito valido. Chequearlos con 'show_grids()")


          # Cargo geo-grids


          geofacet <-  readRDS(gzcon(url("https://github.com/electorArg/PolAr_Data/blob/master/geo/grillas_geofacet.rds?raw=true")))


           geofacet %>%
             purrr::pluck(paste0(distrito))


  }
