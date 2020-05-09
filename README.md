# Grillas como si fueran mapas de Argentina

<img src="https://github.com/electorArg/geofaceteAR/blob/master/hex/ggplot2.png?raw=true" width="200">

`{geofaceteAR}` nació como idea para la primera edición de [LatinR](https://github.com/LatinR/presentaciones-LatinR2018#geofaceting-argentina-slides--repositorio) que se llevó a cabo en Buenos Aires en el año 2018. Como describí en un viejo [post](https://tuqmano.github.io/2019/01/21/geofacetear/), el mismo podía ser pensado como una $extension^2$: del proyecto [`{geofacet}`](https://hafen.github.io/geofacet/) de Ryan Hafen y, en otro nivel, de las grillas o `facet` de `{ggplot2}`.

Con este paquete nos montamos sobre ese desarrollo y agregamos funciones de utilidad para trabajar con estas grillas/mapas de distritos de Argentina. 

---

### Qué es y qué hace `{geofacet}` ? 

_“Amplía `ggplot2` de una manera que facilita la creación de visualizaciones geográficamente facetadas en `R`. Para hacer `geofacet` se toman datos que representan diferentes entidades geográficas y se aplica un método de visualización para cada entidad. El conjunto resultante de visualizaciones conforma una cuadrícula que imita la topología geográfica original”._ ([Ryan Haffen](https://ryanhafen.com/blog/geofacet/) - traducción propia)



### INSTALACIÓN 

````
# install.packages('devtools') si no tiene instalado devtools

# Instalar {geofaceteAR} desde repositorio de github
devtools::install_github("https://github.com/electorArg/geofaceteAR")
```

### `{geofaceteAR}`

En esta versión el paquete incluye unas pocas funciones: 

* `show_arg_codes()`: Proveé un diccionario de identificadores geográficos y equivalencias 

* `show_arg_grids()`: Lista los `id` disponibles para descargar una grilla del distrito de interés. 

* `get_grid()`: obtiene la grilla de interés. 

* `recode_district()`: permite recodificar la variable `code` dentro de la grilla de interés según distintos diccionarios. 



### REFERNECIAS

- [abstract](https://www.researchgate.net/publication/327382314_Geofaceting_Argentina) y [presentación](https://www.researchgate.net/publication/327382101_Geofaceting_Argentina_LatinR_2018) en [LatinR](https://github.com/LatinR) 2018.

- [repositorio original](https://github.com/TuQmano/geofacet_ARG) con el _trabajo en progreso_, ejemplos y aplicaciones de uso para algunas grillas. 


