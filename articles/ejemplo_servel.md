# Ejemplo: datos electorales

En este ejemplo usaremos el paquete de R
[territorial](https://bastianolea.github.io/territorial) para llevar a
cabo una limpieza de datos territoriales correspondientes a afiliaciones
a partidos políticos por sexo y edad. Los datos fueron obtenidos por una
solicitud de transparencia (Concejo por la Transparencia) al Servicio
Electoral (Servel) de Chile en el año 2025.

Estos datos son públicos y oficiales, y fueron obtenidos como parte del
desarrollo del [Índice de Brechas de
Género](https://www.descentralizachile.cl/ibg/) de Subdere.

Puedes [descargar aquí los
datos](https://github.com/bastianolea/territorial/raw/main/data-raw/ejemplo_servel_partidos.xlsx)
para seguir el ejemplo.

------------------------------------------------------------------------

Primero cargamos los datos:

``` r

library(readxl)
library(here)
#> here() starts at /home/runner/work/territorial/territorial

servel <- read_xlsx(
  here("data-raw/ejemplo_servel_partidos.xlsx"),
  skip = 1)

servel
#> # A tibble: 12,091 × 19
#>    `,`        REGION COMUNA SEXO  `0-19` `20-24` `25-29` `30-34` `35-39` `40-44`
#>    <chr>      <chr>  <chr>  <chr>  <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
#>  1 RENOVACIO… DE AN… ANTOF… M          0      10      17      39      36      45
#>  2 RENOVACIO… DE AN… ANTOF… V          1       5      19      31      43      39
#>  3 RENOVACIO… DE AN… CALAMA M          0       2      12      13      11      11
#>  4 RENOVACIO… DE AN… CALAMA V          0       0      16      13      11      16
#>  5 RENOVACIO… DE AN… MARIA… M          0       2       0       3       1       2
#>  6 RENOVACIO… DE AN… MARIA… V          0       1       2       1       0       0
#>  7 RENOVACIO… DE AN… MEJIL… M          0       0       0       0       0       0
#>  8 RENOVACIO… DE AN… MEJIL… V          0       0       1       0       2       1
#>  9 RENOVACIO… DE AN… OLLAG… M          0       0       1       0       0       0
#> 10 RENOVACIO… DE AN… OLLAG… V          0       1       0       0       0       0
#> # ℹ 12,081 more rows
#> # ℹ 9 more variables: `45-49` <dbl>, `50-54` <dbl>, `55-59` <dbl>,
#> #   `60-64` <dbl>, `65-69` <dbl>, `70-74` <dbl>, `75-79` <dbl>, `80+` <dbl>,
#> #   TOTAL <dbl>
```

Realizamos una transformación de los datos para que pasen a desde
columnas hacia filas:

``` r

library(tidyr)

servel <- servel |> 
  pivot_longer(
    cols = where(is.numeric),
    names_to = "edad", 
    values_to = "afiliados")

servel
#> # A tibble: 181,365 × 6
#>    `,`                 REGION         COMUNA      SEXO  edad  afiliados
#>    <chr>               <chr>          <chr>       <chr> <chr>     <dbl>
#>  1 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     0-19          0
#>  2 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     20-24        10
#>  3 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     25-29        17
#>  4 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     30-34        39
#>  5 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     35-39        36
#>  6 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     40-44        45
#>  7 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     45-49        39
#>  8 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     50-54        37
#>  9 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     55-59        43
#> 10 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     60-64        22
#> # ℹ 181,355 more rows
```

Ahora realizamos una limpieza de los nombres de las columnas:

``` r

library(dplyr)
library(janitor)

servel <- servel |> 
  clean_names() |> 
  rename(partido = 1)

servel
#> # A tibble: 181,365 × 6
#>    partido             region         comuna      sexo  edad  afiliados
#>    <chr>               <chr>          <chr>       <chr> <chr>     <dbl>
#>  1 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     0-19          0
#>  2 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     20-24        10
#>  3 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     25-29        17
#>  4 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     30-34        39
#>  5 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     35-39        36
#>  6 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     40-44        45
#>  7 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     45-49        39
#>  8 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     50-54        37
#>  9 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     55-59        43
#> 10 RENOVACION NACIONAL DE ANTOFAGASTA ANTOFAGASTA M     60-64        22
#> # ℹ 181,355 more rows
```

Finalmente, para siplificar el ejemplo, sumamos la cantidad de
afiliados/as a partidos políticos por región, comuna y sexo.

``` r

servel <- servel |> 
  summarize(
    afiliados = sum(afiliados),
    .by = c(region, comuna, partido, sexo)
    )
```

Ahora cargamos el paquete
[territorial](https://bastianolea.github.io/territorial), y la primera
acción será validar las comunas presentes en los datos, para percatarnos
de cualquier problema:

``` r

library(territorial)

servel |> 
  validar_comunas(comuna)
#> ℹ Resumen: 12091 casos de comunas que no conciden con comunas correctamente escritas (ver `territorial::comunas()`): ANTOFAGASTA, CALAMA, MARIA ELENA, MEJILLONES, OLLAGUE, SAN PEDRO DE ATACAMA, SIERRA GORDA, TALTAL, TOCOPILLA, ARICA y 337 comunas más
#> ! Mayúsculas: 12091 casos de comunas escritas en mayúsculas: ANTOFAGASTA, CALAMA, MARIA ELENA, MEJILLONES, OLLAGUE, SAN PEDRO DE ATACAMA, SIERRA GORDA, TALTAL, TOCOPILLA, ARICA y 337 comunas más
#> ℹ Tildes: 2335 casos de comunas que deberían tener tildes y no los tienen: MARIA ELENA, COPIAPO, AYSEN, RIO IBAÑEZ, COMBARBALA, RIO HURTADO, CURACAUTIN, PITRUFQUEN, PUCON, PUREN y 60 comunas más
#> ℹ Eñes: 29 casos de comunas que deberían tener diéresis (¨) y no tienen: OLLAGUE
#> ℹ Escrituras alternativas: 31 casos de comunas escritas de una forma no recomendada, aunque válida: PAIGUANO
```

Vemos que hay miles de comunas escritas en mayúsculas, más de 2 mil
comunas sin tildes, 29 casos de comunas sin eñes, y formas incorrectas
de escribir comunas.

Para arreglar las comunas mal escritas, usaremos la función
[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
sobre la columna original, para crear una columna de nombres limpios:

``` r

servel_limpio <- servel |> 
  mutate(nombre_comuna = limpiar_comunas(comuna, mostrar_proceso = FALSE))
#> ℹ Limpiando 12091 nombres de comunas (347 son distintas)
#> 
#> ── Paso 1: confirmar comunas correctas
#> ℹ De las 347 comunas distintas, ninguna tiene nombres 100% correctos. Los siguientes pasos intentarán la limpieza
#> 
#> ── Paso 2: coincidencias por limpieza de texto
#> ℹ A partir de la limpieza de texto, se limpiaron 343 de 347 comunas: Antofagasta, Calama, María Elena, Mejillones, Ollagüe, San Pedro de Atacama, Sierra Gorda, Taltal, Tocopilla, Arica y 333 comunas más
#> 
#> ── Paso 3: casos especiales
#> ℹ Se encontró 1 caso especial: Cabo de Hornos
#> 
#> ── Paso 4: coincidencias aproximadas de texto
#> ! alerta, se encontraron más de una coincidencia para la comuna `marchigue`: marchihue y la higuera
#> ! alerta, no se encontró ninguna coincidencia para la comuna `fuera del pais`
#> ℹ Se limpiaron 2 de 3 comunas por medio de coincidencias aproximadas de texto: Paihuano y Marchihue
#> 
#> ── Conclusión de limpieza de comunas
#> ✔ De las 347 comunas distintas, se limpiaron 346 en total (99.7%)
#> 
```

La función nos informa que, de las 347 comunas distintas presentes en la
tabla de datos, se limpiaron 346 en total (99.7%).

Algunos casos que vemos en el registro son:

- Paihuano y Marchihue fueron limpiadas a pesar de estar escritas
  distinto
- Cabo de Hornos fue limpiada por tratarse de un caso especial, que
  generalmente viene muy mal escrito (le ponen “Ex-Navarino” o similares
  al final, dificultando limpieza automatizada
- La comuna “Fuera del país” no fue convertida, por la obviedad de no
  tratarse de una comuna

Ahora vemos cómo quedaron los datos:

``` r

servel_limpio
#> # A tibble: 12,091 × 6
#>    region         comuna      partido             sexo  afiliados nombre_comuna
#>    <chr>          <chr>       <chr>               <chr>     <dbl> <chr>        
#>  1 DE ANTOFAGASTA ANTOFAGASTA RENOVACION NACIONAL M           748 Antofagasta  
#>  2 DE ANTOFAGASTA ANTOFAGASTA RENOVACION NACIONAL V           676 Antofagasta  
#>  3 DE ANTOFAGASTA CALAMA      RENOVACION NACIONAL M           294 Calama       
#>  4 DE ANTOFAGASTA CALAMA      RENOVACION NACIONAL V           288 Calama       
#>  5 DE ANTOFAGASTA MARIA ELENA RENOVACION NACIONAL M            38 María Elena  
#>  6 DE ANTOFAGASTA MARIA ELENA RENOVACION NACIONAL V            24 María Elena  
#>  7 DE ANTOFAGASTA MEJILLONES  RENOVACION NACIONAL M            10 Mejillones   
#>  8 DE ANTOFAGASTA MEJILLONES  RENOVACION NACIONAL V            20 Mejillones   
#>  9 DE ANTOFAGASTA OLLAGUE     RENOVACION NACIONAL M             8 Ollagüe      
#> 10 DE ANTOFAGASTA OLLAGUE     RENOVACION NACIONAL V            12 Ollagüe      
#> # ℹ 12,081 more rows
```

Queda limpiar las regiones. Primero las validamos con
[`validar_regiones()`](https://bastianolea.github.io/territorial/reference/validar_regiones.md):

``` r

servel_limpio |> 
  validar_regiones(region)
#> ! mayúsculas: 12091 casos de regiones escritas en mayúsculas
#> ! ortografía: 3205 casos de regiones escritas sin tilde
#> # A tibble: 12,091 × 6
#>    region         comuna      partido             sexo  afiliados nombre_comuna
#>    <chr>          <chr>       <chr>               <chr>     <dbl> <chr>        
#>  1 DE ANTOFAGASTA ANTOFAGASTA RENOVACION NACIONAL M           748 Antofagasta  
#>  2 DE ANTOFAGASTA ANTOFAGASTA RENOVACION NACIONAL V           676 Antofagasta  
#>  3 DE ANTOFAGASTA CALAMA      RENOVACION NACIONAL M           294 Calama       
#>  4 DE ANTOFAGASTA CALAMA      RENOVACION NACIONAL V           288 Calama       
#>  5 DE ANTOFAGASTA MARIA ELENA RENOVACION NACIONAL M            38 María Elena  
#>  6 DE ANTOFAGASTA MARIA ELENA RENOVACION NACIONAL V            24 María Elena  
#>  7 DE ANTOFAGASTA MEJILLONES  RENOVACION NACIONAL M            10 Mejillones   
#>  8 DE ANTOFAGASTA MEJILLONES  RENOVACION NACIONAL V            20 Mejillones   
#>  9 DE ANTOFAGASTA OLLAGUE     RENOVACION NACIONAL M             8 Ollagüe      
#> 10 DE ANTOFAGASTA OLLAGUE     RENOVACION NACIONAL V            12 Ollagüe      
#> # ℹ 12,081 more rows
```

Nuevamente encontramos un caos de nombres de regiones. Pero, como ya
obtuvimos las comunas limpias, podemos usar la función
[`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md)
para basarnos en las comunas limpias para agregar columnas que
contextualicen dichas comunas en sus respectivas provincias y regiones:

``` r

servel_limpio <- servel_limpio |> 
  contextualizar(nombre_comuna) |> # agregar columnas territoriales nuevas
  select(-region, -comuna) # remover columnas originales
#> ℹ columnas agregadas: codigo_region, nombre_region, codigo_provincia, nombre_provincia y codigo_comuna
```

``` r

servel_limpio
#> # A tibble: 12,091 × 9
#>    codigo_region nombre_region codigo_provincia nombre_provincia codigo_comuna
#>            <dbl> <chr>                    <dbl> <chr>                    <dbl>
#>  1             2 Antofagasta                 21 Antofagasta               2101
#>  2             2 Antofagasta                 21 Antofagasta               2101
#>  3             2 Antofagasta                 22 El Loa                    2201
#>  4             2 Antofagasta                 22 El Loa                    2201
#>  5             2 Antofagasta                 23 Tocopilla                 2302
#>  6             2 Antofagasta                 23 Tocopilla                 2302
#>  7             2 Antofagasta                 21 Antofagasta               2102
#>  8             2 Antofagasta                 21 Antofagasta               2102
#>  9             2 Antofagasta                 22 El Loa                    2202
#> 10             2 Antofagasta                 22 El Loa                    2202
#> # ℹ 12,081 more rows
#> # ℹ 4 more variables: nombre_comuna <chr>, partido <chr>, sexo <chr>,
#> #   afiliados <dbl>

glimpse(servel_limpio)
#> Rows: 12,091
#> Columns: 9
#> $ codigo_region    <dbl> 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,…
#> $ nombre_region    <chr> "Antofagasta", "Antofagasta", "Antofagasta", "Antofag…
#> $ codigo_provincia <dbl> 21, 21, 22, 22, 23, 23, 21, 21, 22, 22, 22, 22, 21, 2…
#> $ nombre_provincia <chr> "Antofagasta", "Antofagasta", "El Loa", "El Loa", "To…
#> $ codigo_comuna    <dbl> 2101, 2101, 2201, 2201, 2302, 2302, 2102, 2102, 2202,…
#> $ nombre_comuna    <chr> "Antofagasta", "Antofagasta", "Calama", "Calama", "Ma…
#> $ partido          <chr> "RENOVACION NACIONAL", "RENOVACION NACIONAL", "RENOVA…
#> $ sexo             <chr> "M", "V", "M", "V", "M", "V", "M", "V", "M", "V", "M"…
#> $ afiliados        <dbl> 748, 676, 294, 288, 38, 24, 10, 20, 8, 12, 8, 6, 14, …
```

Terminamos con datos territoriales limpios!
