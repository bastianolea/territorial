
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Paquete `{territorial}`

Herramientas para trabajar con comunas de Chile.

Este paquete busca facilitar tareas de limpieza que suelen ser
necesarias al trabajar con datos de Chile a nivel territorial, por
ejemplo limpiar los nombres de las comunas y regiones, agregar códigos
comunales y regionales, ordenar las regiones del país, entre otras.

Paquete desarrollado bajo el [programa de Campeones de
ROpenSci](https://ropensci.org/es/champions/), con el apoyo de mi
mentora [Andrea Gómez Vargas](https://github.com/SoyAndrea)

## Instalación

Por ahora puedes instalar este paquete desde GitHub:

``` r
# install.packages("pak")
pak::pkg_install("bastianolea/territorial")
```

``` r
# install.packages("devtools")
devtools::install_github("bastianolea/territorial")
```

## Ejemplos

El paquete ofrece una tabla de datos que contiene todas las comunas del
país con sus nombres oficiales, sus códigos únicos territoriales, y lo
mismo para las provincias y regiones del país.

``` r
library(territorial)
library(dplyr)

head(territorial::territorios)
#> # A tibble: 6 × 6
#>   codigo_region nombre_region codigo_provincia nombre_provincia codigo_comuna nombre_comuna
#>           <dbl> <chr>                    <dbl> <chr>                    <dbl> <chr>        
#> 1             1 Tarapacá                    11 Iquique                   1101 Iquique      
#> 2             1 Tarapacá                    11 Iquique                   1107 Alto Hospicio
#> 3             1 Tarapacá                    14 Tamarugal                 1401 Pozo Almonte 
#> 4             1 Tarapacá                    14 Tamarugal                 1402 Camiña       
#> 5             1 Tarapacá                    14 Tamarugal                 1403 Colchane     
#> 6             1 Tarapacá                    14 Tamarugal                 1404 Huara
```

Esta tabla puede servir para hacer `left_join()` y así complementar
otras fuentes de datos territoriales.

Estos datos corresponden al [Ministerio del Interior de
Chile](https://www.subdere.gov.cl/documentacion/códigos-únicos-territoriales-actualizados-al-06-de-septiembre-2018),
publicados en el Diario Oficial el 21 de septiembre de 2018, con leves
modificaciones.

### Ejemplos de datos comunales

Si tienes una tabla de datos con datos comunales, lo primero sería
revisar la calidad de sus datos:

``` r
# library(territorial)

# head(datos)
# 
# revisar_comunas(datos)
```

También podemos hacerlo manualmente consultando si las comunas son
válidas:

``` r
comunas <- c("Providencia", "Vitacura", "Las Condes", "Lo Barnechea", "Ratas", NA)

is.comuna(comunas)
#> [1]  TRUE  TRUE  TRUE  TRUE FALSE FALSE
```

Algo que suele pasar es recibir datos comunales con las comunas mal
escritas, pero que vienen con códigos únicos territoriales. En este caso
podemos crear las comunas bien escritas a partir de los códigos únicos
territoriales:

``` r
head(datos)
#> # A tibble: 6 × 2
#>   codigo_comuna municipio    
#>           <dbl> <chr>        
#> 1         13110 LA FLORIDA   
#> 2         16103 CHILLAN VIEJO
#> 3         10301 OSORNO       
#> 4         16302 COIHUECO     
#> 5         13132 VITACURA     
#> 6         13501 MELIPILLA

# crear nombres de comuna a partir de códigos comunales
datos |> 
  mutate(nombre_comuna = as.nombre_comuna(codigo_comuna))
#> # A tibble: 10 × 3
#>    codigo_comuna municipio     nombre_comuna
#>            <dbl> <chr>         <chr>        
#>  1         13110 LA FLORIDA    La Florida   
#>  2         16103 CHILLAN VIEJO Chillán Viejo
#>  3         10301 OSORNO        Osorno       
#>  4         16302 COIHUECO      Coihueco     
#>  5         13132 VITACURA      Vitacura     
#>  6         13501 MELIPILLA     Melipilla    
#>  7         14204 RIO BUENO     Río Bueno    
#>  8         11401 CHILE CHICO   Chile Chico  
#>  9         16202 COBQUECURA    Cobquecura   
#> 10         13116 LO ESPEJO     Lo Espejo
```

También podemos tener el caso inverso: una tabla con datos comunales que
vienen con nombres de comunas, pero sin códigos únicos territoriales.
Podemos crear los códigos únicos territoriales a partir de los nombres
de comunas:

``` r
head(datos)
#> # A tibble: 6 × 2
#>   nombre_comuna valor
#>   <chr>         <dbl>
#> 1 Pirque            1
#> 2 Cerrillos         2
#> 3 Puente Alto       1
#> 4 La Florida        3
#> 5 Ñuñoa             1
#> 6 Conchalí          2

# agregar códigos comunales a partir de nombres de comunas
datos |> 
  mutate(codigo_comuna = as.codigo_comuna(nombre_comuna))
#> # A tibble: 6 × 3
#>   nombre_comuna valor codigo_comuna
#>   <chr>         <dbl>         <dbl>
#> 1 Pirque            1         13202
#> 2 Cerrillos         2         13102
#> 3 Puente Alto       1         13201
#> 4 La Florida        3         13110
#> 5 Ñuñoa             1         13120
#> 6 Conchalí          2         13104
```

Pero lo anterior requiere que los nombres de las comunas estén bien
escritos! Para esto existe la función `limpiar_nombres_comunas()`:

``` r
# limpiar_nombres_comunas()
```

### Ejemplos de datos regionales

Cuando trabajamos datos de nivel regional, una necesidad común es
ordenarlos en el orden geográfico; es decir, de norte a sur. Para ello
existe la función `ordenar_regiones()`:

``` r
# ordenar_regiones()
```
