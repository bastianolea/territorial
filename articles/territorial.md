# Introducción al paquete {territorial}

## Instalación

Puedes instalar este paquete de R desde GitHub usando [el paquete
`{pak}`](https://pak.r-lib.org):

``` r

# install.packages("pak")
pak::pak("bastianolea/territorial")
```

Los siguientes ejemplos te ayudarán a familiarizarte con algunas de las
funciones de [territorial](https://bastianolea.github.io/territorial).

## Datos comunales

Quizás lo más básico que podemos hacer a nivel comunal con
[territorial](https://bastianolea.github.io/territorial) es obtener un
vector con las comunas del país:

``` r

library(territorial)

sample(comunas(), 12)
```

     [1] "Santo Domingo" "Purén"         "Trehuaco"      "Quintero"
     [5] "Curepto"       "Arica"         "Huasco"        "Nogales"
     [9] "Vichuquén"     "Ñuñoa"         "Rancagua"      "San Ignacio"  

### Tabla de comunas, provincias y regiones de Chile

El paquete ofrece una tabla de datos que contiene todas las comunas del
país con sus nombres oficiales, sus [códigos únicos
territoriales](https://bastianolea.github.io/territorial/articles/codigos_unicos_territoriales.html),
y lo mismo para las provincias y regiones del país.

Para ver la tabla de comunas, provincias y regiones, ejecuta
[`territorial::territorios`](https://bastianolea.github.io/territorial/reference/territorios.md):

``` r

library(dplyr)

names(territorial::territorios)
```

    [1] "codigo_region"    "nombre_region"    "codigo_provincia" "nombre_provincia"
    [5] "codigo_comuna"    "nombre_comuna"   

``` r

territorios
```

    # A tibble: 346 × 6
       codigo_region nombre_region codigo_provincia nombre_provincia codigo_comuna
               <dbl> <chr>                    <dbl> <chr>                    <dbl>
     1             1 Tarapacá                    11 Iquique                   1101
     2             1 Tarapacá                    11 Iquique                   1107
     3             1 Tarapacá                    14 Tamarugal                 1401
     4             1 Tarapacá                    14 Tamarugal                 1402
     5             1 Tarapacá                    14 Tamarugal                 1403
     6             1 Tarapacá                    14 Tamarugal                 1404
     7             1 Tarapacá                    14 Tamarugal                 1405
     8             2 Antofagasta                 21 Antofagasta               2101
     9             2 Antofagasta                 21 Antofagasta               2102
    10             2 Antofagasta                 21 Antofagasta               2103
    # ℹ 336 more rows
    # ℹ 1 more variable: nombre_comuna <chr>

Esta tabla es la *fuente de verdad* de toda la información territorial
usada en el paquete, y corresponde a los datos oficiales de la
[Subsecretría de Desarrollo Regional y Administrativo, Ministerio del
Interior de
Chile](https://www.subdere.gov.cl/documentacion/c%C3%B3digos-%C3%BAnicos-territoriales-actualizados-al-06-de-septiembre-2018).

### Validación de calidad de nombres de comunas

Si tienes una tabla de datos con datos comunales, lo primero sería
revisar la calidad de sus datos. La función
[`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md)
indica qué posibles problemas existen con los nombres de las comunas.

Imaginemos una tabla de datos con *muy mala calidad* de nombres de
comunas. Usemos como ejemplo la siguiente tabla de datos:

``` r

library(dplyr)

datos <- tibble(
  nombre_comuna = c("PIRQUE", "El Monte", "Maipu", "santiago", "prohibidencia", "CERRILLOS", "San José De Maipo", "Puerto Saavedra", "OHiggins"),
  valores = c(4, 6, 2, 8, 6, 3, 5, 8, 10)
)
```

``` r

datos
```

    # A tibble: 9 × 2
      nombre_comuna     valores
      <chr>               <dbl>
    1 PIRQUE                  4
    2 El Monte                6
    3 Maipu                   2
    4 santiago                8
    5 prohibidencia           6
    6 CERRILLOS               3
    7 San José De Maipo       5
    8 Puerto Saavedra         8
    9 OHiggins               10

Para empezar a trabajar con estos datos, validamos su calidad primero:

``` r

datos |> 
  validar_comunas(nombre_comuna) # cuando la columna con nombres de comunas se llama `nombre_comuna`, no es necesario especificarla
```

    ! Resumen: 8 casos de comunas que no conciden con comunas correctamente escritas (ver `territorial::comunas()`): PIRQUE, Maipu, santiago, prohibidencia, CERRILLOS, San José De Maipo, Puerto Saavedra y OHiggins

    ! Mayúsculas: 2 casos de comunas escritas en mayúsculas: PIRQUE y CERRILLOS

    ! Minúsculas: 2 casos de comunas escritas en minúsculas: santiago y prohibidencia

    ! Mayúsculas: 1 caso de comunas con preposiciones ('de', 'del') escritas en mayúsculas: San José De Maipo

    ℹ Tildes: 1 caso de comunas que deberían tener tildes y no los tienen: Maipu

    ℹ Problemas comunes: 1 caso de comunas popularmente mal escritas: OHiggins

    ✖ Validación de comunas: se encontraron 15 problemas con las comunas! Usa `territorial::limpiar_comunas()` para solucionarlos.

### Limpieza de nombres de comunas de Chile

Luego de saber más o menos el tipo de problemas que tienen los nombres
de las comunas en esta tabla, podemos usar la función
[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
para corregir automáticamente los nombres de las comunas:

``` r

datos |> 
  limpiar_comunas()
```

    ℹ Limpiando 9 nombres de comunas (9 son distintas)

    → Paso 1: confirmar comunas correctas

    ℹ De las 9 comunas distintas, 1 ya eran correctas: El Monte

    → Paso 2: coincidencias por limpieza de texto

    ℹ A partir de la limpieza de texto, se limpiaron 7 de 9 comunas: Pirque, El Monte, Maipú, Santiago, Cerrillos, San José de Maipo y O'Higgins

    → Paso 3: casos especiales

    ℹ Se encontró 1 caso especial: Saavedra

    → Paso 4: coincidencias aproximadas de texto

    ℹ Se limpió la comuna por medio de coincidencia aproximada de texto: Providencia

    → Conclusión de limpieza de comunas

    ✔ De las 9 comunas distintas, se limpiaron 9 en total (100%)

    # A tibble: 9 × 2
      nombre_comuna     valores
      <chr>               <dbl>
    1 Pirque                  4
    2 El Monte                6
    3 Maipú                   2
    4 Santiago                8
    5 Providencia             6
    6 Cerrillos               3
    7 San José de Maipo       5
    8 Saavedra                8
    9 O'Higgins              10

Esta función realiza una limpieza de los nombres en tres pasos, que
puedes leer en detalle en su documentación:
[`?limpiar_comunas`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md).

En este caso, simplemente se aplica la función porque la tabla contiene
la columna `nombre_comuna`, pero si la columna con nombres se llama
distinto, puedes indicarla en la función.

También puedes limpiar las comunas creando una variable nueva usando la
función dentro de
[`mutate()`](https://dplyr.tidyverse.org/reference/mutate.html):

``` r

library(dplyr)

datos |> 
  mutate(nombre_corregido = limpiar_comunas(nombre_comuna))
```

    # A tibble: 9 × 3
      nombre_comuna     valores nombre_corregido
      <chr>               <dbl> <chr>
    1 PIRQUE                  4 Pirque
    2 El Monte                6 El Monte
    3 Maipu                   2 Maipú
    4 santiago                8 Santiago
    5 prohibidencia           6 Providencia
    6 CERRILLOS               3 Cerrillos
    7 San José De Maipo       5 San José de Maipo
    8 Puerto Saavedra         8 Saavedra
    9 OHiggins               10 O'Higgins        

En ambos casos, la función entrega mensajes relevantes sobre el proceso
de limpieza y el tipo de problemas resueltos.

Para evaluar el funcionamiento de la limpieza automática, usar el
argumento `procedimiento = TRUE` para ver el paso a paso en columnas:

``` r

datos |> 
  limpiar_comunas(procedimiento = TRUE) |> 
  invisible()
```

    ℹ Limpiando 9 nombres de comunas (9 son distintas)

    → Paso 1: confirmar comunas correctas

    ℹ De las 9 comunas distintas, 1 ya eran correctas: El Monte

    → Paso 2: coincidencias por limpieza de texto

    ℹ A partir de la limpieza de texto, se limpiaron 7 de 9 comunas: Pirque, El Monte, Maipú, Santiago, Cerrillos, San José de Maipo y O'Higgins

    → Paso 3: casos especiales

    ℹ Se encontró 1 caso especial: Saavedra

    → Paso 4: coincidencias aproximadas de texto

    ℹ Se limpió la comuna por medio de coincidencia aproximada de texto: Providencia

    → Conclusión de limpieza de comunas

    ✔ De las 9 comunas distintas, se limpiaron 9 en total (100%)

    ℹ Mostrando proceso:

    # A tibble: 9 × 6
      original          correctas limpieza         especiales coincidencia resultado
      <chr>             <chr>     <chr>            <chr>      <chr>        <chr>
    1 PIRQUE            <NA>      Pirque           <NA>       <NA>         Pirque
    2 El Monte          El Monte  El Monte         <NA>       <NA>         El Monte
    3 Maipu             <NA>      Maipú            <NA>       <NA>         Maipú
    4 santiago          <NA>      Santiago         <NA>       <NA>         Santiago
    5 prohibidencia     <NA>      <NA>             <NA>       Providencia  Providen…
    6 CERRILLOS         <NA>      Cerrillos        <NA>       <NA>         Cerrillos
    7 San José De Maipo <NA>      San José de Mai… <NA>       <NA>         San José…
    8 Puerto Saavedra   <NA>      <NA>             Saavedra   <NA>         Saavedra
    9 OHiggins          <NA>      O'Higgins        <NA>       <NA>         O'Higgins

#### Funciones para confirmar nombres de comunas

Si necesitamos más control, también podemos confirmar los nombres
manualmente consultando si las comunas son válidas:

``` r

comunas <- c("Providencia", "Vitacura", "Las Condes", "Lo Barnechea", "Ratas", NA)

is_nombre_comuna(comunas)
```

    [1]  TRUE  TRUE  TRUE  TRUE FALSE FALSE

Lo anterior sería equivalente a hacer
`comunas %in% territorial::comunas()`. Esto puede servir, por ejemplo,
para validar datos en una aplicación Shiny.

También se puede confirmar si los códigos únicos territoriales son
válidos:

``` r

comunas <- c(1101, 1107, NA, 99999)

is_codigo_comuna(comunas)
```

    [1]  TRUE  TRUE FALSE FALSE

### Revisar presencia de comunas en una tabla

Otro caso de validación de datos territoriales puede ser cuando nos
encontramos con una tabla que tiene muchas observaciones, y queremos
confirmar si tiene casos para todas las comunas del país, o bien, si hay
comunas que están faltantes entre sus datos.

Para el ejemplo, creemos una tabla de datos con muchas observaciones de
comunas:

``` r

library(dplyr)

n_comunas <- 324

base <- territorios |> 
  select(nombre_comuna, codigo_comuna) |> 
  slice_sample(n = n_comunas) |> 
  mutate(a = runif(n = n_comunas),
         b = runif(n = n_comunas),
         c = runif(n = n_comunas)) |> 
  tidyr::pivot_longer(cols = c(a, b, c)) |> 
  arrange(value)

base
```

    # A tibble: 972 × 4
       nombre_comuna  codigo_comuna name     value
       <chr>                  <dbl> <chr>    <dbl>
     1 San Miguel             13130 b     0.000573
     2 Curepto                 7103 a     0.000884
     3 Coinco                  6103 a     0.00136
     4 Viña del Mar            5109 a     0.00193
     5 Rauco                   7305 c     0.00454
     6 Tirúa                   8207 c     0.00641
     7 San Bernardo           13401 a     0.00689
     8 Cabo de Hornos         12201 b     0.00918
     9 Cobquecura             16202 c     0.00956
    10 Nogales                 5506 b     0.0101
    # ℹ 962 more rows

Esta tabla tiene 972 filas, ¿cómo confirmar si existen datos para todas
las comunas de Chile? Para eso está la función
[`contar_comunas()`](https://bastianolea.github.io/territorial/reference/contar_comunas.md):

``` r

base |> 
  contar_comunas()
```

    ℹ Cantidad de comunas únicas: 324

    ! La cantidad de comunas es anómala: hay 324, pero deberían ser 346. Revísalas con `territorial::validar_comunas()`

    → Las comunas faltantes son: El Tabo, Pichidegua, Quinta de Tilcoco, Requínoa, Chimbarongo, Maule, Coronel, Florida, San Pedro de la Paz, Curanilahue, Nacimiento, Pucón, Toltén, Purén, Calbuco, Futaleufú, Lo Barnechea, Curacaví, María Pinto, Paillaco, Coihueco y Ñiquén

La función
[`contar_comunas()`](https://bastianolea.github.io/territorial/reference/contar_comunas.md)
nos indica cuántas comunas únicas hay, y las que faltan. Esto es útil
porque muchas veces las bases de datos reales no tienen datos para todas
las comunas, sobre todo las más pequeñas y remotas.

Si dentro de esa tabla con comunas quieres confirmar si existe una en
específico, o saber cómo viene escrita, usa la utilidad
[`buscar_comuna()`](https://bastianolea.github.io/territorial/reference/buscar_comuna.md):

``` r

base |> 
  buscar_comuna("Alto")
```

    ! Se encontraron 30 resultados, mostrando sólo 6.

    ℹ Los resultados más cercanos al término `Alto` son: Alto del Carmen, Puente Alto, Alto Biobío y Alto Hospicio

    # A tibble: 6 × 5
      nombre_comuna   codigo_comuna name   value puntaje
      <chr>                   <dbl> <chr>  <dbl>   <dbl>
    1 Alto del Carmen          3302 b     0.0481       1
    2 Puente Alto             13201 c     0.0494       1
    3 Alto del Carmen          3302 a     0.0683       1
    4 Alto Biobío              8314 c     0.149        1
    5 Alto Hospicio            1107 c     0.154        1
    6 Alto Biobío              8314 a     0.191        1

### Crear nombres de comunas a partir de códigos únicos territoriales

Algo que suele pasar es tener datos comunales con las comunas mal
escritas, pero que vienen con códigos únicos territoriales. En este
caso, aparte de limpiarlas con
[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md),
podemos crear los nombres de comunas a partir de los códigos únicos
territoriales:

``` r

library(dplyr)

datos <- tribble(
  ~codigo_comuna,      ~municipio,
  13110,    "LA FLORIDA",
  16103, "CHILLAN VIEJO",
  10301,        "OSORNO",
  16302,      "COIHUECO",
  13132,      "VITACURA",
  13501,     "MELIPILLA",
  14204,     "RIO BUENO",
  11401,   "CHILE CHICO",
  16202,    "COBQUECURA",
  13116,     "LO ESPEJO"
)
```

``` r

datos
```

    # A tibble: 10 × 2
       codigo_comuna municipio
               <dbl> <chr>
     1         13110 LA FLORIDA
     2         16103 CHILLAN VIEJO
     3         10301 OSORNO
     4         16302 COIHUECO
     5         13132 VITACURA
     6         13501 MELIPILLA
     7         14204 RIO BUENO
     8         11401 CHILE CHICO
     9         16202 COBQUECURA
    10         13116 LO ESPEJO    

``` r

# crear nombres de comuna a partir de códigos comunales
datos |> 
  mutate(nombre_comuna = as_nombre_comuna(codigo_comuna))
```

    # A tibble: 10 × 3
       codigo_comuna municipio     nombre_comuna
               <dbl> <chr>         <chr>
     1         13110 LA FLORIDA    La Florida
     2         16103 CHILLAN VIEJO Chillán Viejo
     3         10301 OSORNO        Osorno
     4         16302 COIHUECO      Coihueco
     5         13132 VITACURA      Vitacura
     6         13501 MELIPILLA     Melipilla
     7         14204 RIO BUENO     Río Bueno
     8         11401 CHILE CHICO   Chile Chico
     9         16202 COBQUECURA    Cobquecura
    10         13116 LO ESPEJO     Lo Espejo    

### Obtener códigos únicos territoriales a partir de nombres de comunas

También podemos tener el caso inverso: una tabla con datos comunales que
vienen con nombres de comunas, pero sin códigos únicos territoriales.
Podemos crear los códigos únicos territoriales a partir de los nombres
de comunas:

``` r

library(dplyr)

datos <- tribble(
  ~nombre_comuna, ~valor,
  "Pirque",       1,
  "Cerrillos",    2,
  "Puente Alto",  1,
  "La Florida",   3,
  "Ñuñoa",        1,
  "Conchalí",     2
)
```

``` r

datos
```

    # A tibble: 6 × 2
      nombre_comuna valor
      <chr>         <dbl>
    1 Pirque            1
    2 Cerrillos         2
    3 Puente Alto       1
    4 La Florida        3
    5 Ñuñoa             1
    6 Conchalí          2

``` r

# agregar códigos comunales a partir de nombres de comunas
datos |> 
  mutate(codigo_comuna = as_codigo_comuna(nombre_comuna))
```

    # A tibble: 6 × 3
      nombre_comuna valor codigo_comuna
      <chr>         <dbl>         <dbl>
    1 Pirque            1         13202
    2 Cerrillos         2         13102
    3 Puente Alto       1         13201
    4 La Florida        3         13110
    5 Ñuñoa             1         13120
    6 Conchalí          2         13104

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

datos <- tribble(
  ~nombre_comuna, ~valor,
  "Cerrillos",    1,
  "Arica",        2,
  "Putre",        3)
```

``` r

datos
```

    # A tibble: 3 × 2
      nombre_comuna valor
      <chr>         <dbl>
    1 Cerrillos         1
    2 Arica             2
    3 Putre             3

``` r

datos |>
  contextualizar(nombre_comuna)
```

    ℹ Columnas agregadas: codigo_region, nombre_region, codigo_provincia, nombre_provincia y codigo_comuna

    # A tibble: 3 × 7
      codigo_region nombre_region    codigo_provincia nombre_provincia codigo_comuna
              <dbl> <chr>                       <dbl> <chr>                    <dbl>
    1            13 Metropolitana d…              131 Santiago                 13102
    2            15 Arica y Parinac…              151 Arica                    15101
    3            15 Arica y Parinac…              152 Parinacota               15201
    # ℹ 2 more variables: nombre_comuna <chr>, valor <dbl>

### Otras funciones para comunas

Si tienes una comuna y quieres obtener la región a la que pertenece, usa
[`ubicar_comunas()`](https://bastianolea.github.io/territorial/reference/ubicar_comunas.md):

``` r

comuna <- "Curacautín"

ubicar_comunas(comuna)
```

    [1] "La Araucanía"

Si tienes varias comunas y quieres crear un texto que las contenga, usa
[`redactar_comunas()`](https://bastianolea.github.io/territorial/reference/redactar_comunas.md):

``` r

comunas <- c("Lo Espejo", "La Granja", "La Pintana", "Puente Alto")

redactar_comunas(comunas)
```

    Lo Espejo, La Granja, La Pintana y Puente Alto

Si quieres saber si una comuna clasifica como urbana, mixta o rural de
acuerdo a la clasificación de la [Oficina de Estudios y Políticas
Agrarias
(Odepa)](https://bibliotecadigital.odepa.gob.cl/items/ce846880-f010-4868-a5d9-18c80f7ceabd),
usa
[`agregar_clasificacion()`](https://bastianolea.github.io/territorial/reference/agregar_clasificacion.md):

``` r

comunas <- c("Curanilahue", "Melipilla", "San Pedro")

agregar_clasificacion(
  as_codigo_comuna(comunas)
  )  
```

    [1] Mixta  Urbana Rural
    Levels: Rural Mixta Urbana

Estas funciones son particularmente útiles para cuando estés [creando
reportes](https://bastianolea.rbind.io/blog/quarto_reportes/) o
[aplicaciones web Shiny.](https://bastianolea.rbind.io/blog/shiny/)

## Datos regionales

Las siguientes son funciones de R centradas en las regiones de Chile.
Puedes obtener las regiones con la función
[`regiones()`](https://bastianolea.github.io/territorial/reference/regiones.md):

``` r

library(territorial)

regiones()
```

     [1] "Arica y Parinacota"
     [2] "Tarapacá"
     [3] "Antofagasta"
     [4] "Atacama"
     [5] "Coquimbo"
     [6] "Valparaíso"
     [7] "Metropolitana de Santiago"
     [8] "Libertador General Bernardo O'Higgins"
     [9] "Maule"
    [10] "Ñuble"
    [11] "Biobío"
    [12] "La Araucanía"
    [13] "Los Ríos"
    [14] "Los Lagos"
    [15] "Aysén del General Carlos Ibáñez del Campo"
    [16] "Magallanes y de la Antártica Chilena"     

Las regiones con sus códigos territoriales puedes sacarlas de la tabla
[`territorial::territorios`](https://bastianolea.github.io/territorial/reference/territorios.md):

``` r

library(dplyr)

regiones <- territorios |> 
  select(contains("region")) |> 
  distinct()

regiones
```

    # A tibble: 16 × 2
       codigo_region nombre_region
               <dbl> <chr>
     1             1 Tarapacá
     2             2 Antofagasta
     3             3 Atacama
     4             4 Coquimbo
     5             5 Valparaíso
     6             6 Libertador General Bernardo O'Higgins
     7             7 Maule
     8             8 Biobío
     9             9 La Araucanía
    10            10 Los Lagos
    11            11 Aysén del General Carlos Ibáñez del Campo
    12            12 Magallanes y de la Antártica Chilena
    13            13 Metropolitana de Santiago
    14            14 Los Ríos
    15            15 Arica y Parinacota
    16            16 Ñuble                                    

### Ordenar regiones de Chile

Cuando trabajamos datos de nivel regional, una necesidad común es
[ordenar las regiones en el orden
geográfico](https://bastianolea.rbind.io/blog/ordenar_regiones/); es
decir, de norte a sur. Para ello existe la función
[`ordenar_regiones()`](https://bastianolea.github.io/territorial/reference/ordenar_regiones.md):

``` r

regiones
```

    # A tibble: 16 × 2
       codigo_region nombre_region
               <dbl> <chr>
     1             1 Tarapacá
     2             2 Antofagasta
     3             3 Atacama
     4             4 Coquimbo
     5             5 Valparaíso
     6             6 Libertador General Bernardo O'Higgins
     7             7 Maule
     8             8 Biobío
     9             9 La Araucanía
    10            10 Los Lagos
    11            11 Aysén del General Carlos Ibáñez del Campo
    12            12 Magallanes y de la Antártica Chilena
    13            13 Metropolitana de Santiago
    14            14 Los Ríos
    15            15 Arica y Parinacota
    16            16 Ñuble                                    

Aquí tenemos las regiones en orden según su numeración, pero queremos
ordenarlas de norte a sur:

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

### Acortar nombres de regiones de Chile

Hay regiones de Chile con nombres extensos, y que en ciertos contextos
requieren de una versión más breve. Por ejemplo, no siempre es relevante
leer “Libertador General” o “General Carlos Ibáñez del Campo”. Para eso
podemos
[`acortar_regiones()`](https://bastianolea.github.io/territorial/reference/acortar_regiones.md):

``` r

regiones |> 
  ordenar_regiones() |> 
  mutate(nombre_region_corto = acortar_regiones(nombre_region))
```

    Warning: There was 1 warning in `mutate()`.
    ℹ In argument: `nombre_region_corto = acortar_regiones(nombre_region)`.
    Caused by warning:
    ! Los datos están en formato factor: se perderá el orden de los niveles al
    convertirlos a texto

    # A tibble: 16 × 3
       codigo_region nombre_region                             nombre_region_corto
               <dbl> <fct>                                     <chr>
     1            15 Arica y Parinacota                        Arica y Parinacota
     2             1 Tarapacá                                  Tarapacá
     3             2 Antofagasta                               Antofagasta
     4             3 Atacama                                   Atacama
     5             4 Coquimbo                                  Coquimbo
     6             5 Valparaíso                                Valparaíso
     7            13 Metropolitana de Santiago                 Metropolitana
     8             6 Libertador General Bernardo O'Higgins     O'Higgins
     9             7 Maule                                     Maule
    10            16 Ñuble                                     Ñuble
    11             8 Biobío                                    Biobío
    12             9 La Araucanía                              La Araucanía
    13            14 Los Ríos                                  Los Ríos
    14            10 Los Lagos                                 Los Lagos
    15            11 Aysén del General Carlos Ibáñez del Campo Aysén
    16            12 Magallanes y de la Antártica Chilena      Magallanes         

### Clasificar regiones de Chile en macrozonas

Algunos análisis requieren de agrupar las regiones de Chile en grupos,
usualmente derivados de su posición geográfica. Con la función
[`agregar_macrozona()`](https://bastianolea.github.io/territorial/reference/agregar_macrozona.md)
se pueden clasificar las regiones del país en varios tipos de macrozona
a partir de sus códigos regionales:

``` r

regiones |> 
  ordenar_regiones() |> 
  mutate(
    macrozona_1 = agregar_macrozona(codigo_region, tipo = 1),
    macrozona_2 = agregar_macrozona(codigo_region, tipo = 2),
    macrozona_3 = agregar_macrozona(codigo_region, tipo = 3),
    macrozona_4 = agregar_macrozona(codigo_region, tipo = 4)
  )
```

    # A tibble: 16 × 6
       codigo_region nombre_region   macrozona_1 macrozona_2 macrozona_3 macrozona_4
               <dbl> <fct>           <fct>       <fct>       <fct>       <fct>
     1            15 Arica y Parina… Norte       Norte       Norte       Norte Gran…
     2             1 Tarapacá        Norte       Norte       Norte       Norte Gran…
     3             2 Antofagasta     Norte       Norte       Norte       Norte Gran…
     4             3 Atacama         Norte       Norte       Norte       Norte Chico
     5             4 Coquimbo        Norte       Centro      Centro      Norte Chico
     6             5 Valparaíso      Centro      Centro      Centro      Norte Chico
     7            13 Metropolitana … Centro      Centro      Metropolit… Zona centr…
     8             6 Libertador Gen… Centro      Centro      Centro sur  Zona centr…
     9             7 Maule           Centro      Centro/sur  Centro sur  Zona centr…
    10            16 Ñuble           Sur         Centro/sur  Centro sur  Zona centr…
    11             8 Biobío          Sur         Centro/sur  Centro sur  Zona centr…
    12             9 La Araucanía    Sur         Centro/sur  Sur         Zona Sur
    13            14 Los Ríos        Sur         Sur         Sur         Zona Sur
    14            10 Los Lagos       Sur         Sur         Sur         Zona Sur
    15            11 Aysén del Gene… Austral     Sur         Austral     Zona Austr…
    16            12 Magallanes y d… Austral     Sur         Austral     Zona Austr…

Para más información, [ver la viñeta sobre
macrozonas.](https://bastianolea.github.io/territorial/articles/mapas_regionales_macrozonas.html)

### Validación de calidad de nombres de regiones

Otro problema que podemos tener son datos de regiones con los nombres
mal escritos. Para eso tenemos la función
[`validar_regiones()`](https://bastianolea.github.io/territorial/reference/validar_regiones.md),
que revisará los nombres de las regiones y reportará los problemas
existentes:

``` r

regiones <- tibble(nombre_region = c("los lagos", "nuble", "OHIGGINS", "Araucania"))

regiones
```

    # A tibble: 4 × 1
      nombre_region
      <chr>
    1 los lagos
    2 nuble
    3 OHIGGINS
    4 Araucania    

``` r

regiones |> 
  validar_regiones()
```

    ℹ No se especificó la variable: asumiendo columna `nombre_region`

    ! Mayúsculas: 1 caso de regiones escritas en mayúsculas

    ! Mayúsculas: 2 casos de regiones escritas en minúsculas

    ! Ortografía: 1 caso de la Región de Ñuble escrita sin eñe

    ! Ortografía: 1 caso de la Región de O'Higgins escrita sin su apóstrofo (')

    ! Ortografía: 1 caso de regiones escritas sin tilde

    ✖ Validación de regiones: se encontraron 6 problemas con las regiones!

### Limpieza de nombres de regiones de Chile

Al igual que con la función
[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md),
existe la función
[`limpiar_regiones()`](https://bastianolea.github.io/territorial/reference/limpiar_regiones.md),
que aplica varios pasos de limpieza automatizada de textos para obtener
nombres de regiones válidos.

Veamos un ejemplo con una tabla de datos donde las regiones vienen mal
escritas:

``` r

regiones <- tibble(nombre_region = c("NUBLE", "AISEN", "OHIGINS", "RM"))

regiones
```

    # A tibble: 4 × 1
      nombre_region
      <chr>
    1 NUBLE
    2 AISEN
    3 OHIGINS
    4 RM           

Usamos
[`limpiar_regiones()`](https://bastianolea.github.io/territorial/reference/limpiar_regiones.md)
para obtener versiones válidas de los nombres:

``` r

regiones |> 
  limpiar_regiones() # asume que la columna es `nombre_region`
```

    ℹ Limpiando 4 nombres de región (4 son distintos)

    → Paso 1: confirmar regiones correctas

    ℹ De las 4 regiones distintas, ninguna tiene nombres 100% correctos. Los siguientes pasos intentarán la limpieza

    → Paso 2: coincidencias por limpieza de texto

    ℹ A partir de la limpieza de texto, se limpiaron 1 de 4 regiones: Ñuble

    → Paso 3: casos especiales

    ℹ Se encontraron 2 casos especiales: Aysén del General Carlos Ibáñez del Campo y Metropolitana de Santiago

    → Paso 4: coincidencias aproximadas de texto

    ! Se encontraron 2 coincidencias para la región `ohigins`: ohiggins y libertador general bernardo ohiggins

    ℹ Se limpiaron 1 de 1 regiones por medio de coincidencias aproximadas de texto: Libertador General Bernardo O'Higgins

    → Conclusión de limpieza de regiones

    ✔ De las 4 regiones distintas, se limpiaron 4 en total (100%)

    # A tibble: 4 × 1
      nombre_region
      <chr>
    1 Ñuble
    2 Aysén del General Carlos Ibáñez del Campo
    3 Libertador General Bernardo O'Higgins
    4 Metropolitana de Santiago                

### Obtener comunas de una región

Para saber qué comunas forman parte de una región, usa
[`obtener_comunas()`](https://bastianolea.github.io/territorial/reference/obtener_comunas.md):

``` r

region <- regiones()[4]

region
```

    [1] "Atacama"

``` r

obtener_comunas(region)
```

    ℹ Comunas de la región: Copiapó, Caldera, Tierra Amarilla, Chañaral, Diego de Almagro, Vallenar, Alto del Carmen, Freirina y Huasco

    [1] "Copiapó"          "Caldera"          "Tierra Amarilla"  "Chañaral"
    [5] "Diego de Almagro" "Vallenar"         "Alto del Carmen"  "Freirina"
    [9] "Huasco"          

### Otras funciones para regiones

Si tienes nombres de región y estás creando reportes o aplicaciones que
usan las regiones dentro de párrafos, sabrás que hay regiones que se
anteceden por preposiciones distintas (*Región “del” Maule, Región “de”
O’Higgins*), e incluso sin preposiciones (no se escribe *Región “de”
Metropolitana*). Para eso existe la función
[`preposicion_region()`](https://bastianolea.github.io/territorial/reference/preposicion_region.md):

``` r

region <- c("Maule", "O'Higgins")

preposicion_region(region)
```

    [1] "del" "de" 

La mejor forma de obtener el nombre redactado de la región sería con,
obviamente,
[`redactar_region()`](https://bastianolea.github.io/territorial/reference/redactar_region.md):

``` r

redactar_region(region)
```

    [1] "Región del Maule"    "Región de O'Higgins"

## Datos de localidades

El paquete también contiene datos a nivel sub-comunal de Chile, como son
las localidades. Las localidades son asentamientos o áreas subcomunales
que no son entidades administrativas. Puedes consultarlas en la tabla
[`territorial::localidades`](https://bastianolea.github.io/territorial/reference/localidades.md):

``` r

localidades
```

    # A tibble: 29,256 × 6
       codigo_comuna localidad              tipo        subtipo habitantes viviendas
               <dbl> <chr>                  <chr>       <chr>        <dbl>     <dbl>
     1          1101 Indeterminada          Localidad … Indete…         30        12
     2          1101 Río Seco               Localidad … Caserío        131       117
     3          1101 Cholito                Localidad … Asenta…          2         2
     4          1101 Complejo Aduana El Loa Localidad … Parcel…          0         1
     5          1101 Caleta San Marcos      Localidad … Asenta…        259       153
     6          1101 Caleta Chipana         Localidad … Caserío         84        57
     7          1101 Ike Ike                Localidad … Asenta…         29        11
     8          1101 Indeterminada          Localidad … Indete…         11         7
     9          1101 Piedra Polo            Localidad … Asenta…          5         7
    10          1101 Altos de Río Seco      Localidad … Caserío         14        13
    # ℹ 29,246 more rows

Esta tabla de localidades proviene del estudio de *Identificación de
localidades en condición de aislamiento*, realizado por la Subsecretaría
de Desarrollo Regional y Administrativo y publicado el año 2021.

### Ubicar localidades del país en comunas

Con la función
[`ubicar_localidades()`](https://bastianolea.github.io/territorial/reference/ubicar_localidades.md),
podemos consultar nombres de localidades de Chile para ubicarlas
geográficamente en la comuna donde se emplazan:

``` r

ubicar_localidades(c("Chada", "La Dormida", "Mallarauco"))
```

    ℹ Buscando localidad 'Chada'

    ! Se encontraron 5 localidades coincidentes:

    # A tibble: 5 × 5
      nombre_region                         nombre_comuna localidad tipo     subtipo
      <chr>                                 <chr>         <chr>     <chr>    <chr>
    1 Metropolitana de Santiago             Paine         Chada     Localid… Parcel…
    2 La Araucanía                          Pitrufquén    Chada     Localid… Parcel…
    3 Metropolitana de Santiago             Paine         Chada     Localid… Fundo-…
    4 Libertador General Bernardo O'Higgins Codegua       Chada     Localid… Fundo-…
    5 Metropolitana de Santiago             Paine         Chada     Urbano   Pueblo 

    ℹ Retornando la primera localidad: Chada, ubicada en la comuna de Paine, Región Metropolitana de Santiago

    ℹ Buscando localidad 'La Dormida'

    ! Se encontró 1 localidad coincidente:

    # A tibble: 1 × 5
      nombre_region nombre_comuna localidad  tipo            subtipo
      <chr>         <chr>         <chr>      <chr>           <chr>
    1 Valparaíso    Olmué         La Dormida Localidad rural Parcela de agrado

    ℹ Localidad encontrada: La Dormida, ubicada en la comuna de Olmué, Región de Valparaíso

    ℹ Buscando localidad 'Mallarauco'

    ! Se encontró 1 localidad coincidente:

    # A tibble: 1 × 5
      nombre_region             nombre_comuna localidad  tipo            subtipo
      <chr>                     <chr>         <chr>      <chr>           <chr>
    1 Metropolitana de Santiago Peñaflor      Mallarauco Localidad rural Parcela de…

    ℹ Localidad encontrada: Mallarauco, ubicada en la comuna de Peñaflor, Región Metropolitana de Santiago

    [1] "Paine"    "Olmué"    "Peñaflor"

------------------------------------------------------------------------

Estas son algunas de las funciones principales, pero existen muchas más:
[revisa el índice de
funciones!](https://bastianolea.github.io/territorial/reference/index.html)
