
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Paquete `{territorial}`

Herramientas para trabajar con comunas de Chile en R.

Este paquete busca facilitar tareas de limpieza que suelen ser
necesarias al trabajar con datos de Chile a nivel comunal, por ejemplo
limpiar los nombres de las comunas y regiones, agregar códigos comunales
y regionales, ordenar las regiones del país, entre otras.

La razón de este paquete surge de mi propia experiencia analizando datos
sociales: los datos territoriales de Chile vienen siempre con dudosa
calidad en las variables que especifican las comunas: nombres mal
escritos, en mayúsculas, sin eñes, etc.

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

## Tabla de comunas, provincias y regiones de Chile

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
otras fuentes de datos comunales.

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

is_nombre_comuna(comunas)
#> [1]  TRUE  TRUE  TRUE  TRUE FALSE FALSE
```

Lo anterior sería equivalente a hacer
`comunas %in% territorial::comunas()`.

También se puede confirmar si los códigos únicos territoriales son
válidos:

``` r
comunas <- c(1101, 1107, NA, 99999)

is_codigo_comuna(comunas)
#> [1]  TRUE  TRUE FALSE FALSE
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
  mutate(nombre_comuna = as_nombre_comuna(codigo_comuna))
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
  mutate(codigo_comuna = as_codigo_comuna(nombre_comuna))
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

Si tenemos datos de nivel comunal pero les faltan variables
territoriales, podemos *contextualizar* los datos comunales al
agregarles todas las variables que les faltan con la función
`contextualizar()`:

``` r
head(datos)
#> # A tibble: 3 × 2
#>   nombre_comuna valor
#>   <chr>         <dbl>
#> 1 Cerrillos         1
#> 2 Arica             2
#> 3 Putre             3

datos |>
  contextualizar(variable = "nombre_comuna")
#> ℹ columnas agregadas: codigo_region, nombre_region, codigo_provincia, nombre_provincia y codigo_comuna
#> # A tibble: 3 × 7
#>   codigo_region nombre_region             codigo_provincia nombre_provincia codigo_comuna nombre_comuna valor
#>           <dbl> <chr>                                <dbl> <chr>                    <dbl> <chr>         <dbl>
#> 1            13 Metropolitana de Santiago              131 Santiago                 13102 Cerrillos         1
#> 2            15 Arica y Parinacota                     151 Arica                    15101 Arica             2
#> 3            15 Arica y Parinacota                     152 Parinacota               15201 Putre             3
```

### Ejemplos de datos regionales

Cuando trabajamos datos de nivel regional, una necesidad común es
[ordenar las regiones en el orden
geográfico](https://bastianolea.rbind.io/blog/ordenar_regiones/); es
decir, de norte a sur. Para ello existe la función `ordenar_regiones()`:

``` r
regiones
#> # A tibble: 16 × 2
#>    codigo_region nombre_region                            
#>            <dbl> <chr>                                    
#>  1             1 Tarapacá                                 
#>  2             2 Antofagasta                              
#>  3             3 Atacama                                  
#>  4             4 Coquimbo                                 
#>  5             5 Valparaíso                               
#>  6             6 Libertador General Bernardo O'Higgins    
#>  7             7 Maule                                    
#>  8             8 Biobío                                   
#>  9             9 La Araucanía                             
#> 10            10 Los Lagos                                
#> 11            11 Aysén del General Carlos Ibáñez del Campo
#> 12            12 Magallanes y de la Antártica Chilena     
#> 13            13 Metropolitana de Santiago                
#> 14            14 Los Ríos                                 
#> 15            15 Arica y Parinacota                       
#> 16            16 Ñuble

regiones |> 
  ordenar_regiones()
#> # A tibble: 16 × 2
#>    codigo_region nombre_region                            
#>            <dbl> <fct>                                    
#>  1            15 Arica y Parinacota                       
#>  2             1 Tarapacá                                 
#>  3             2 Antofagasta                              
#>  4             3 Atacama                                  
#>  5             4 Coquimbo                                 
#>  6             5 Valparaíso                               
#>  7            13 Metropolitana de Santiago                
#>  8             6 Libertador General Bernardo O'Higgins    
#>  9             7 Maule                                    
#> 10            16 Ñuble                                    
#> 11             8 Biobío                                   
#> 12             9 La Araucanía                             
#> 13            14 Los Ríos                                 
#> 14            10 Los Lagos                                
#> 15            11 Aysén del General Carlos Ibáñez del Campo
#> 16            12 Magallanes y de la Antártica Chilena
```
