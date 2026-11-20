

# Paquete `{territorial}` <a href="https://bastianolea.github.io/territorial/"><img src="man/figures/logo.png" align="right" height="180" alt="territorial website" /></a>

Herramientas para facilitar el trabajo con datos de comunas y regiones
de Chile en R.

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/bastianolea/territorial/graph/badge.svg)](https://app.codecov.io/gh/bastianolea/territorial)
[![R-universe
version](https://bastianolea.r-universe.dev/territorial/badges/version.png)](https://bastianolea.r-universe.dev/territorial)
<!-- badges: end -->

Los datos sobre temáticas sociales suelen venir en dudosa calidad, sobre
todo cuando se desagregan a nivel comunal: nombres mal escritos, en
mayúsculas, sin eñes, sin tildes, etc. Así que creé `{territorial}` para
facilitar este tipo de tareas!

El objetivo de este paquete es simplificar el análisis de datos
territoriales de Chile, facilitando tareas de limpieza y procesamiento
de datos que suelen ser necesarias al trabajar con datos de Chile a
nivel comunal y regional.

Por ejemplo:

- **Revisar** si los nombres de comunas y regiones vienen bien escritos
  (`validar_comunas()` y `validar_regiones()`)
- **Limpiar** automáticamente los nombres de las comunas con
  `limpiar_comunas()`, incluso si vienen con faltas de ortografía o mal
  escritas
- Agregar todos los datos territoriales faltantes a una tabla a partir
  de las comunas (`contextualizar()`)
- **Ordenar las regiones** del país de norte a sur
  (`ordenar_regiones()`)
- Convertir nombres de comunas a [códigos únicos
  territoriales](https://bastianolea.github.io/territorial/articles/codigos_unicos_territoriales.html)
  (`as_codigo_comuna()`) y convertir códigos únicos territoriales a
  nombres de comunas (`as_nombre_comuna()`)
- Redactar los nombres de las regiones (`redactar_region()`) para que,
  por ejemplo, “Maule” sea “Región *del* Maule”
- Clasificar las comunas de Chile en **urbanas, mixtas** y **rurales**
  con `agregar_clasificacion()`
- Clasificar las regiones de Chile en **macrozonas** con
  `agregar_macrozona()`
- [y
  más!](https://bastianolea.github.io/territorial/reference/index.html)

[Revisa la
viñeta](https://bastianolea.github.io/territorial/articles/territorial.html)
`vignette("territorial")` para una introducción al paquete!

## Instalación

Instala el paquete desde
[R-Universe](https://bastianolea.r-universe.dev/territorial):

``` r
install.packages("territorial", 
                 repos = c("https://bastianolea.r-universe.dev",
                           "https://cloud.r-project.org"))
```

También puedes instalar la versión de desarrollo desde
[GitHub](https://github.com/bastianolea/territorial):

``` r
# install.packages("pak")
pak::pak("bastianolea/territorial")
```

## Usando `{territorial}`

Como su nombre lo dice, `{territorial}` entrega herramientas para
trabajar con datos territoriales de Chile, entendidos como datos
tabulares cuyas observaciones correspondan a comunas o regiones del
país.

La premisa del paquete es que tenemos una tabla principal,
`territorial::territorios`, que contiene los nombres oficiales y los
códigos únicos territoriales de todas las regiones, provincias y comunas
de Chile.

``` r
library(territorial)
library(dplyr)

head(territorios)
```

    # A tibble: 6 × 6
      codigo_region nombre_region codigo_provincia nombre_provincia codigo_comuna
              <dbl> <chr>                    <dbl> <chr>                    <dbl>
    1             1 Tarapacá                    11 Iquique                   1101
    2             1 Tarapacá                    11 Iquique                   1107
    3             1 Tarapacá                    14 Tamarugal                 1401
    4             1 Tarapacá                    14 Tamarugal                 1402
    5             1 Tarapacá                    14 Tamarugal                 1403
    6             1 Tarapacá                    14 Tamarugal                 1404
    # ℹ 1 more variable: nombre_comuna <chr>

Usando esta tabla como fuente de verdad, podemos validar, corregir y
complementar datos territoriales.

También se plantea el estándar de llamar las columnas como `nombre_{x}`
y `codigo_{x}` (por ejemplo, `nombre_comuna` y `codigo_comuna`), para
mantener orden y compatibilidad entre tablas.

Además se incluyen funciones útiles como `comunas()`, que retorna un
vector con los nombres de comunas o `regiones()`, que hace lo mismo con
regiones, así como `obtener_comunas()` para obtener las comunas de una
región, `ubicar_comunas()` para saber en qué región está una comuna, [y
muchas
más!](https://bastianolea.github.io/territorial/reference/index.html).

### Limpiar comunas

Probemos `{territorial}` con una tabla con datos de ejemplo:

``` r
# crear una tabla con datos de ejemplo
datos <- dplyr::tibble(
  nombre_comuna = c("PIRQUE", "El Monte", "Maipu", "nunoa",
                    "La calera", "prohibidencia", "Penialolen",
                    "CERRILLOS", "San José De Maipo", "OHiggins"))

datos
```

    # A tibble: 10 × 1
       nombre_comuna    
       <chr>            
     1 PIRQUE           
     2 El Monte         
     3 Maipu            
     4 nunoa            
     5 La calera        
     6 prohibidencia    
     7 Penialolen       
     8 CERRILLOS        
     9 San José De Maipo
    10 OHiggins         

Algunas de estas comunas vienen en mayúsculas, con faltas de ortografía,
y mal escritas!

Podemos **revisar la calidad** de los nombres de las comunas con
`validar_comunas()`, para detectar posibles problemas:

``` r
datos |> 
  validar_comunas(nombre_comuna) # cuando la columna con nombres de comunas se llama `nombre_comuna`, no es necesario especificarla
```

    ! Resumen: 9 casos de comunas que no conciden con comunas correctamente escritas (ver `territorial::comunas()`): PIRQUE, Maipu, nunoa, La calera, prohibidencia, Penialolen, CERRILLOS, San José De Maipo y OHiggins

    ! Mayúsculas: 2 casos de comunas escritas en mayúsculas: PIRQUE y CERRILLOS

    ! Minúsculas: 2 casos de comunas escritas en minúsculas: nunoa y prohibidencia

    ! Mayúsculas: 1 caso de comunas con preposiciones ('de', 'del') escritas en mayúsculas: San José De Maipo

    ℹ Tildes: 1 caso de comunas que deberían tener tildes y no los tienen: Maipu

    ℹ Eñes: 1 caso de comunas escritas sin eñe: nunoa

    ℹ Problemas comunes: 1 caso de comunas popularmente mal escritas: OHiggins

    ✖ Validación de comunas: se encontraron 17 problemas con las comunas! Usa `territorial::limpiar_comunas()` para solucionarlos.

Ahora sabemos qué tipo de problemas vienen en los nombres de las comunas
de nuestra tabla de datos.

Luego podemos **limpiar automáticamente las comunas** con
`limpiar_comunas()`, y obtener una columna con las comunas correctamente
escritas:

``` r
datos |> 
  limpiar_comunas(nombre_comuna)
```

    ℹ Limpiando 10 nombres de comunas (10 son distintas)

    → Paso 1: confirmar comunas correctas

    ℹ De las 10 comunas distintas, 1 ya eran correctas: El Monte

    → Paso 2: coincidencias por limpieza de texto

    ℹ A partir de la limpieza de texto, se limpiaron 7 de 10 comunas: Pirque, El Monte, Maipú, Ñuñoa, Cerrillos, San José de Maipo y O'Higgins

    → Paso 3: casos especiales

    ℹ Se encontró 1 caso especial: Calera

    → Paso 4: coincidencias aproximadas de texto

    ℹ Se limpiaron 2 de 2 comunas por medio de coincidencias aproximadas de texto: Providencia y Peñalolén

    → Conclusión de limpieza de comunas

    ✔ De las 10 comunas distintas, se limpiaron 10 en total (100%)

    # A tibble: 10 × 1
       nombre_comuna    
       <chr>            
     1 Pirque           
     2 El Monte         
     3 Maipú            
     4 Ñuñoa            
     5 Calera           
     6 Providencia      
     7 Peñalolén        
     8 Cerrillos        
     9 San José de Maipo
    10 O'Higgins        

Esta función usa varias técnicas para limpiar automáticamente los
nombres de las comunas y municipios de Chile.

Si lo que necesitas es limpiar nombres de regiones, también existen
`validar_regiones()` y `limpiar_regiones()`! Revisa la viñeta de
primeros pasos con `vignette("territorial")` para ejemplos más completos
de todas las funcionalidades.

### Contextualizar datos territoriales

Si tienes una tabla que solamente tiene comunas, y necesitamos **agregar
las variables territoriales faltantes** como región, provincia, y los
[códigos únicos
territoriales](https://bastianolea.github.io/territorial/articles/codigos_unicos_territoriales.html)
de Chile (`vignette(codigos_unicos_territoriales)`), existe la función
`contextualizar()` para agregar automáticamente todas las columnas
territoriales que falten.

``` r
datos <- dplyr::tribble(
  ~nombre_comuna, ~personas,
  "Puente Alto",    14,
  "La Florida",     23,
  "La Granja",      156,
  "San Joaquín",    12)
```

``` r
datos |>
  contextualizar()
```

    ℹ No se especificó la variable: asumiendo columna `nombre_comuna`

    ℹ Columnas agregadas: codigo_region, nombre_region, codigo_provincia, nombre_provincia y codigo_comuna

    # A tibble: 4 × 7
      codigo_region nombre_region    codigo_provincia nombre_provincia codigo_comuna
              <dbl> <chr>                       <dbl> <chr>                    <dbl>
    1            13 Metropolitana d…              132 Cordillera               13201
    2            13 Metropolitana d…              131 Santiago                 13110
    3            13 Metropolitana d…              131 Santiago                 13111
    4            13 Metropolitana d…              131 Santiago                 13129
    # ℹ 2 more variables: nombre_comuna <chr>, personas <dbl>

La función detecta la existencia de una columna apropiada, y la usa para
agregar el resto de los datos. Así, un dataframe que solamente tiene
nombres de comuna o códigos únicos territoriales puede pasar a tener
todas las demás variables que describen territorialmente a esos datos.

Esto es muy útil para limpiar datos: solamente necesitas una tabla con
códigos únicos territoriales para aplicarle `contextualizar()` y obtener
la tabla completa!

Por ejemplo, la siguiente tabla:

``` r
datos <- dplyr::tribble(
     ~codigo_comuna, ~personas,
              13201,        14,
              13110,        23,
              13111,       156,
              13129,        12)
```

Ahora le aplicamos `contextualizar()` y obtenemos una tabla con todas
las variables que describen cada territorio de manera homogénea y
estandarizada:

``` r
datos |> 
  contextualizar()
```

    ℹ No se especificó la variable: asumiendo columna `codigo_comuna`

    ℹ Columnas agregadas: codigo_region, nombre_region, codigo_provincia, nombre_provincia y nombre_comuna

    # A tibble: 4 × 7
      codigo_region nombre_region    codigo_provincia nombre_provincia codigo_comuna
              <dbl> <chr>                       <dbl> <chr>                    <dbl>
    1            13 Metropolitana d…              132 Cordillera               13201
    2            13 Metropolitana d…              131 Santiago                 13110
    3            13 Metropolitana d…              131 Santiago                 13111
    4            13 Metropolitana d…              131 Santiago                 13129
    # ℹ 2 more variables: nombre_comuna <chr>, personas <dbl>

### Ordenar regiones de Chile

Cuando trabajamos datos de nivel regional, una necesidad común es
[ordenar las regiones en el orden
geográfico](https://bastianolea.rbind.io/blog/ordenar_regiones/); es
decir, de norte a sur. Para ello existe la función `ordenar_regiones()`.

Creemos una tabla de regiones desordenadas:

``` r
regiones <- territorios |> 
  select(ends_with("region")) |> 
  distinct() |> 
  slice_sample(n = 16) # desordenar

regiones
```

    # A tibble: 16 × 2
       codigo_region nombre_region                            
               <dbl> <chr>                                    
     1            16 Ñuble                                    
     2             1 Tarapacá                                 
     3             3 Atacama                                  
     4            11 Aysén del General Carlos Ibáñez del Campo
     5             6 Libertador General Bernardo O'Higgins    
     6            13 Metropolitana de Santiago                
     7             8 Biobío                                   
     8            10 Los Lagos                                
     9            14 Los Ríos                                 
    10            15 Arica y Parinacota                       
    11             2 Antofagasta                              
    12             7 Maule                                    
    13             4 Coquimbo                                 
    14            12 Magallanes y de la Antártica Chilena     
    15             5 Valparaíso                               
    16             9 La Araucanía                             

Las regiones están desordenadas! Queremos ordenarlas de norte a sur:

``` r
regiones |> 
  ordenar_regiones()
```

    # A tibble: 16 × 2
       codigo_region nombre_region                            
               <dbl> <fct>                                    
     1            15 Arica y Parinacota                       
     2             1 Tarapacá                                 
     3             2 Antofagasta                              
     4             3 Atacama                                  
     5             4 Coquimbo                                 
     6             5 Valparaíso                               
     7            13 Metropolitana de Santiago                
     8             6 Libertador General Bernardo O'Higgins    
     9             7 Maule                                    
    10            16 Ñuble                                    
    11             8 Biobío                                   
    12             9 La Araucanía                             
    13            14 Los Ríos                                 
    14            10 Los Lagos                                
    15            11 Aysén del General Carlos Ibáñez del Campo
    16            12 Magallanes y de la Antártica Chilena     

### Limpieza de datos

Gracias a la tabla de verdad (`territorial::territorios`) y la capacidad
de limpieza de `limpiar_comunas()` y `limpiar_regiones()`, el paquete
ofrece las siguientes funciones para **transformar** datos territoriales
desde nombres a códigos y viceversa:

- `as_codigo_comuna()`: convierte nombres de comunas a códigos comunales
- `as_nombre_comuna()`: convierte códigos comunales a nombres de comunas
- `as_codigo_region()`: convierte nombres de regiones a códigos
  regionales (del 1 al 16)
- `as_nombre_region()`: convierte códigos regionales a nombres de
  regiones
- `as_capital_regional()`: convierte códigos o nombres de regiones a los
  nombres de las comunas que son sus capitales regionales

Del mismo modo, existen funciones para **validar** que un texto o código
sea válido:

- `is_codigo_comuna()`: evalúa si un dato es un código único territorial
  válido de una comuna
- `is_nombre_comuna()`: evalúa si un texto es el nombre válido de una
  comuna
- `is_codigo_region()`: evalúa si un dato es un código de región válido
  (del 1 al 16)
- `is_nombre_region()`: evalúa si un texto es el nombre válido de una
  región
- `is_rural()`: evalúa si una comuna es rural (a diferencia de urbana o
  mixta, ver `agregar_clasificacion()`)
- `is_codigo_comuna_antiguo()`: para confirmar si se trata de códigos
  territoriales obsoletos (y corregirlos con
  `actualizar_codigo_comuna()`).

Todas retornan `TRUE` o `FALSE` para cada elemento del vector evaluado.
Para revisar la calidad de columnas completas de nombres, existen
también `validar_comunas()` y `validar_regiones()`, que advierten sobre
posibles problemas en los nombres.

### Más utilidades territoriales

Otras funciones sirven para agregar información territorial a tus datos,
o para adaptar nombres según el contexto:

- `redactar_region()`: redacta nombres de regiones incluyendo “Región
  de/del”; por ejemplo, “Maule” pasa a “Región del Maule”
- `acortar_regiones()`: acorta nombres extensos de regiones; por
  ejemplo, “Aysén del General Carlos Ibáñez del Campo” pasa a “Aysén”
- `abreviar_comunas()`: crea abreviaciones de 3 letras desde nombres de
  comunas, útil para mapas y gráficos con poco espacio
- `agregar_clasificacion()`: agrega la clasificación comunal PNDR
  (Rural, Mixta o Urbana) a un vector de comunas
- `agregar_macrozona()`: agrega la macrozona del país (norte, centro,
  sur) a partir de códigos de región
- `buscar_comuna()`: busca comunas por similitud de nombre en cualquier
  tabla con una columna de comunas, útil para detectar y solucionar
  problemas en fuentes externas
- `obtener_comunas()`: obtiene los nombres de las comunas de una o más
  regiones, a partir de códigos o nombres de región
- `ubicar_comunas()`: entrega la región o provincia (según el argumento
  `nivel`) donde se ubica cada comuna, a partir de códigos o nombres de
  comunas

------------------------------------------------------------------------

Estas son algunas de las funciones principales, pero existen muchas más
que facilitan el trabajo con datos comunales y regionales de Chile:
revisa la [viñeta de primeros
pasos](https://bastianolea.github.io/territorial/articles/territorial.html)
para ejemplos, [el índice del
paquete](https://bastianolea.github.io/territorial/reference/index.html),
o alguno de los [ejemplos con datos
reales](https://bastianolea.github.io/territorial/articles/ejemplo_rsh.html)
en la sección de artículos.

------------------------------------------------------------------------

Paquete desarrollado bajo el [programa de Campeones de
ROpenSci](https://ropensci.org/es/champions/), con el apoyo de mi
mentora [Andrea Gómez Vargas](https://github.com/SoyAndrea).

## Código de conducta

Ten en cuenta que este proyecto se publica con un [Código de Conducta
para
Colaboradores](https://bastianolea.github.io/territorial/CODE_OF_CONDUCT.html).
Al contribuir a este proyecto, aceptas cumplir con sus términos.
