# Introducción al paquete

## Instalación

Por ahora puedes instalar este paquete desde GitHub:

``` r

# install.packages("pak")
pak::pak("bastianolea/territorial")
```

``` r

library(territorial)
```

Los siguientes ejemplos muestran algunos usos de
[territorial](https://bastianolea.github.io/territorial).

## Ejemplos de datos comunales

### Tabla de comunas, provincias y regiones de Chile

El paquete ofrece una tabla de datos que contiene todas las comunas del
país con sus nombres oficiales, sus códigos únicos territoriales, y lo
mismo para las provincias y regiones del país.

``` r

library(territorial)
library(dplyr)

head(territorial::territorios)
#> # A tibble: 6 × 6
#>   codigo_region nombre_region codigo_provincia nombre_provincia codigo_comuna
#>           <dbl> <chr>                    <dbl> <chr>                    <dbl>
#> 1             1 Tarapacá                    11 Iquique                   1101
#> 2             1 Tarapacá                    11 Iquique                   1107
#> 3             1 Tarapacá                    14 Tamarugal                 1401
#> 4             1 Tarapacá                    14 Tamarugal                 1402
#> 5             1 Tarapacá                    14 Tamarugal                 1403
#> 6             1 Tarapacá                    14 Tamarugal                 1404
#> # ℹ 1 more variable: nombre_comuna <chr>
```

Esta tabla es la fuente de toda la información territorial usada en el
paquete, y corresponde a los datos oficiales de la [Subsecretría de
Desarrollo Regional y Administrativo, Ministerio del Interior de
Chile](https://www.subdere.gov.cl/documentacion/c%C3%B3digos-%C3%BAnicos-territoriales-actualizados-al-06-de-septiembre-2018).

### Validación de calidad de nombres de comunas

Si tienes una tabla de datos con datos comunales, lo primero sería
revisar la calidad de sus datos. La función
[`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md)
indica qué posibles problemas existen con los nombres de las comunas.

Imaginemos una tabla de datos con muy mala calidad de nombres de
comunas:

``` r

datos
#> # A tibble: 8 × 2
#>   nombre_comuna     valores
#>   <chr>               <dbl>
#> 1 PIRQUE                  4
#> 2 El Monte                6
#> 3 Maipu                   2
#> 4 santiago                8
#> 5 prohibidencia           6
#> 6 CERRILLOS               3
#> 7 San José De Maipo       5
#> 8 OHiggins                8
```

Para empezar a trabajar con estos datos, validamos su calidad primero:

``` r

datos |> 
  validar_comunas(nombre_comuna)
#> ℹ Resumen: 7 casos de comunas que no conciden con comunas correctamente escritas (ver `territorial::comunas()`): PIRQUE, Maipu, santiago, prohibidencia, CERRILLOS, San José De Maipo y OHiggins
#> ! Mayúsculas: 2 casos de comunas escritas en mayúsculas: PIRQUE y CERRILLOS
#> ! Minúsculas: 2 casos de comunas escritas en minúsculas: santiago y prohibidencia
#> ! Mayúsculas: 1 caso de comunas con preposiciones ('de', 'del') escritas en mayúsculas: San José De Maipo
#> ℹ Tildes: 1 caso de comunas que deberían tener tildes y no los tienen: Maipu
#> ℹ Problemas comunes: 1 caso de comunas popularmente mal escritas: OHiggins
```

### Limpieza de nombres de comunas de Chile

Luego de saber más o menos el tipo de problemas que tienen los nombres
de las comunas en esta tabla, podemos usar la función
[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
para corregir automáticamente los nombres de las comunas:

``` r

datos |> 
  mutate(nombre_corregido = limpiar_comunas(nombre_comuna))
#> ℹ Limpiando 8 nombres de comunas (8 son distintas)
#> 
#> ── Paso 1: confirmar comunas correctas
#> ℹ De las 8 comunas distintas, 1 ya eran correctas: El Monte
#> 
#> ── Paso 2: coincidencias por limpieza de texto
#> ℹ A partir de la limpieza de texto, se limpiaron 7 de 8 comunas: Pirque, El Monte, Maipú, Santiago, Cerrillos, San José de Maipo y O'Higgins
#> 
#> ── Paso 3: casos especiales
#> ℹ Se encontraron 0 casos especiales:
#> 
#> ── Paso 4: coincidencias aproximadas de texto
#> ℹ Se limpiaron 1 de 1 comunas por medio de coincidencias aproximadas de texto: Providencia
#> 
#> ── Conclusión de limpieza de comunas
#> ✔ De las 8 comunas distintas, se limpiaron 8 en total (100%)
#> 
#> # A tibble: 8 × 3
#>   nombre_comuna     valores nombre_corregido 
#>   <chr>               <dbl> <chr>            
#> 1 PIRQUE                  4 Pirque           
#> 2 El Monte                6 El Monte         
#> 3 Maipu                   2 Maipú            
#> 4 santiago                8 Santiago         
#> 5 prohibidencia           6 Providencia      
#> 6 CERRILLOS               3 Cerrillos        
#> 7 San José De Maipo       5 San José de Maipo
#> 8 OHiggins                8 O'Higgins
```

Esta función realiza una limpieza de los nombres en tres pasos, que
puedes leer en detalle en su documentación:
[`?limpiar_comunas`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md).

#### Funciones para confirmar nombres de comunas

Si necesitamos más control, también podemos confirmar los nombres
manualmente consultando si las comunas son válidas:

``` r

comunas <- c("Providencia", "Vitacura", "Las Condes", "Lo Barnechea", "Ratas", NA)

is_nombre_comuna(comunas)
#> [1]  TRUE  TRUE  TRUE  TRUE FALSE FALSE
```

Lo anterior sería equivalente a hacer
`comunas %in% territorial::comunas()`. Esto puede servir, por ejemplo,
para validar datos en una aplicación Shiny.

También se puede confirmar si los códigos únicos territoriales son
válidos:

``` r

comunas <- c(1101, 1107, NA, 99999)

is_codigo_comuna(comunas)
#> [1]  TRUE  TRUE FALSE FALSE
```

### Crear nombres de comunas a partir de códigos únicos territoriales

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

### Obtener códigos únicos territoriales a partir de nombres de comunas

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

Naturalmente, lo anterior requiere que los nombres de las comunas estén
bien escritos, así que habría que haber confirmado con
[`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md)
y/o haber limpiado con
[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md).

### Agregar variables territoriales faltantes

Si tenemos datos de nivel comunal pero les faltan variables
territoriales, podemos *contextualizar* los datos comunales al
agregarles todas las variables que les faltan con la función
[`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md):

``` r

head(datos)
#> # A tibble: 3 × 2
#>   nombre_comuna valor
#>   <chr>         <dbl>
#> 1 Cerrillos         1
#> 2 Arica             2
#> 3 Putre             3

datos |>
  contextualizar(nombre_comuna)
#> ℹ columnas agregadas: codigo_region, nombre_region, codigo_provincia, nombre_provincia y codigo_comuna
#> # A tibble: 3 × 7
#>   codigo_region nombre_region    codigo_provincia nombre_provincia codigo_comuna
#>           <dbl> <chr>                       <dbl> <chr>                    <dbl>
#> 1            13 Metropolitana d…              131 Santiago                 13102
#> 2            15 Arica y Parinac…              151 Arica                    15101
#> 3            15 Arica y Parinac…              152 Parinacota               15201
#> # ℹ 2 more variables: nombre_comuna <chr>, valor <dbl>
```

## Ejemplos de datos regionales

### Ordenar regiones de Chile

Cuando trabajamos datos de nivel regional, una necesidad común es
[ordenar las regiones en el orden
geográfico](https://bastianolea.rbind.io/blog/ordenar_regiones/); es
decir, de norte a sur. Para ello existe la función
[`ordenar_regiones()`](https://bastianolea.github.io/territorial/reference/ordenar_regiones.md):

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

### Validación de calidad de nombres de regiones

Otro problema que podemos tener son datos de regiones con los nombres
mal escritos. Para eso tenemos la función
[`validar_regiones()`](https://bastianolea.github.io/territorial/reference/validar_regiones.md),
que revisará los nombres de las regiones y reportará los problemas
existentes:

``` r

validar_regiones(c("los lagos", "nuble", "OHIGGINS"))
#> ! mayúsculas: 1 caso de regiones escritas en mayúsculas
#> ! mayúsculas: 2 casos de regiones escritas en minúsculas
#> ! ortografía: 1 caso de la Región de Ñuble escrita sin eñe
#> ! ortografía: 1 caso de la Región de O'Higgins escrita sin su apóstrofo (')
```

### Uso de regiones para la redacción de textos

Un típico problema es que tenemos las regiones y necesitamos incluirlas
en un texto, pero si anteponemos “Región de” no siempre queda bien: por
ejemplo, no se dice “Región de Metropolitana”, ni tampoco se dice
“Región de Maule”, sino que cada región tiene su preposición apropiada.
Para esto usamos la función
[`redactar_region()`](https://bastianolea.github.io/territorial/reference/redactar_region.md),
que a su vez usa
[`preposicion_region()`](https://bastianolea.github.io/territorial/reference/preposicion_region.md)
para identificar la preposición correcta:

``` r

redactar_region("Metropolitana")
#> [1] "Región Metropolitana"
redactar_region("Maule")
#> [1] "Región del Maule"
```

------------------------------------------------------------------------

Estas son algunas de las funciones principales, pero existen muchas más
que facilitan el trabajo con datos territoriales de Chile: [revisa el
índice!](https://bastianolea.github.io/territorial/articles/reference/)
