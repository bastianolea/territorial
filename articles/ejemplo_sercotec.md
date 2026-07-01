# Ejemplo: beneficiarios Sercotec

En este ejemplo se limpian datos territoriales sobre personas
beneficiarias de programas de apoyo al emprendimiento de Sercotec
(Servicio de Cooperación Técnica) en Chile, a nivel comunal y por sexo.
Los datos corresponden al año 2024, y fueron obtenidos mediante
solicitud de transparencia el año 2025.

Estos datos son públicos y oficiales, y fueron obtenidos como parte del
desarrollo del [Índice de Brechas de
Género](https://www.descentralizachile.cl/ibg/) de Subdere.

Puedes [descargar aquí los
datos](https://github.com/bastianolea/territorial/raw/main/data-raw/ejemplo_sercotec_beneficiarios.xlsx)
para seguir el ejemplo.

------------------------------------------------------------------------

Primero cargamos los datos originales:

``` r

library(readxl)
library(here)
library(janitor)
library(dplyr)

sercotec <- read_xlsx(
  here("data-raw/ejemplo_sercotec_beneficiarios.xlsx")) |> 
  clean_names() |> 
  rename(año = 1)

sercotec
#> # A tibble: 91,258 × 9
#>      año direccion_regional instrumento programa tipo_beneficiario sexo_contacto
#>    <dbl> <chr>              <chr>       <chr>    <chr>             <chr>        
#>  1  2024 Región de Tarapacá Digitaliza… Digital… Rut Extendido     Femenino     
#>  2  2024 Región de Tarapacá Digitaliza… Digital… Rut Extendido     Femenino     
#>  3  2024 Región de Tarapacá Digitaliza… Digital… Rut Extendido     Femenino     
#>  4  2024 Región de Tarapacá Digitaliza… Digital… Empresa Jurídica  Femenino     
#>  5  2024 Región de Tarapacá Digitaliza… Digital… Rut Extendido     Femenino     
#>  6  2024 Región de Tarapacá Digitaliza… Digital… Rut Extendido     Femenino     
#>  7  2024 Región de Tarapacá Digitaliza… Digital… Empresa Jurídica  Femenino     
#>  8  2024 Región de Tarapacá Digitaliza… Digital… Rut Extendido     Masculino    
#>  9  2024 Región de Tarapacá Digitaliza… Digital… Empresa Jurídica  Masculino    
#> 10  2024 Región de Tarapacá Digitaliza… Digital… Rut Extendido     Masculino    
#> # ℹ 91,248 more rows
#> # ℹ 3 more variables: comuna_beneficiario <chr>,
#> #   actividad_economica_postulacion <chr>,
#> #   actividad_economica_postulante_beneficiario <chr>
```

Los datos contienen una fila por cada persona beneficiaria, con columnas
que identifican el programa, el sexo y la comuna, entre otras.

Filtramos los datos para quedarnos solamente con el año 2024, y sólo con
los casos que tienen sexo y comuna informados:

``` r

sercotec <- sercotec |> 
  filter(!is.na(sexo_contacto),
         !is.na(comuna_beneficiario)) |> 
  filter(año == 2024)
```

Revisamos las categorías de sexo disponibles:

``` r

sercotec |> 
  count(sexo_contacto)
#> # A tibble: 4 × 2
#>   sexo_contacto     n
#>   <chr>         <int>
#> 1 Femenino      57641
#> 2 Masculino     31134
#> 3 No Binario       91
#> 4 No Informa     2392
```

Finalmente agrupamos por comuna y sexo para obtener el conteo de
personas beneficiarias:

``` r

sercotec <- sercotec |>
  group_by(comuna_beneficiario, sexo_contacto) |> 
  count() |> 
  ungroup()

sercotec
#> # A tibble: 958 × 3
#>    comuna_beneficiario sexo_contacto     n
#>    <chr>               <chr>         <int>
#>  1 Aisén               Femenino        440
#>  2 Aisén               Masculino       214
#>  3 Aisén               No Informa        4
#>  4 Algarrobo           Femenino        102
#>  5 Algarrobo           Masculino        40
#>  6 Algarrobo           No Informa        2
#>  7 Alhué               Femenino         41
#>  8 Alhué               Masculino        12
#>  9 Alto Biobío         Femenino         11
#> 10 Alto Biobío         Masculino         9
#> # ℹ 948 more rows
```

Ahora cargamos el paquete
[territorial](https://bastianolea.github.io/territorial) para evaluar la
calidad de los nombres de las comunas usados en esta base de datos:

``` r

library(territorial)

sercotec |> 
  validar_comunas(comuna_beneficiario)
#> ! Resumen: 24 casos de comunas que no conciden con comunas correctamente escritas (ver `territorial::comunas()`): Aisén, Los Alamos, Los Ángeles, No Informada, OHiggins, Otro lugar, Puerto Saavedra, Ránquil y Treguaco
#> ℹ Tildes: 3 casos de comunas que deberían tener tildes y no los tienen: Los Alamos
#> ℹ Problemas comunes: 2 casos de comunas popularmente mal escritas: OHiggins
#> ℹ Escrituras alternativas: 5 casos de comunas escritas de una forma no recomendada, aunque válida: Aisén y Treguaco
#> ✖ Validación de comunas: se encontraron 34 problemas con las comunas! Usa `territorial::limpiar_comunas()` para solucionarlos.
```

La validación detecta varios problemas: *Los Alamos* le falta el tilde
(muchas personas siguen pensando que las letras mayúsculas no llevan
tilde, un vestigio de la antigua imprenta), *OHiggins* tiene su
apóstrofo omitido, mientras que *Aisén* y *Treguaco* están escritas de
forma no recomendada. También hay valores como *No Informada* y *Otro
lugar* que no corresponden a comunas reales.

Para corregir estos problemas usamos
[`territorial::limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
sobre la columna que contiene los nombres comunales:

``` r

sercotec_limpio <- sercotec |> 
  mutate(nombre_comuna = limpiar_comunas(comuna_beneficiario))
#> ℹ Limpiando 958 nombres de comunas (346 son distintas)
#> 
#> ── Paso 1: confirmar comunas correctas
#> ℹ De las 346 comunas distintas, 337 ya eran correctas: Algarrobo, Alhué, Alto Biobío, Alto Hospicio, Alto del Carmen, Ancud, Andacollo, Angol, Antofagasta, Antuco y 327 comunas más
#> 
#> ── Paso 2: coincidencias por limpieza de texto
#> ℹ A partir de la limpieza de texto, se limpiaron 341 de 346 comunas: Algarrobo, Alhué, Alto Biobío, Alto Hospicio, Alto del Carmen, Ancud, Andacollo, Angol, Antofagasta, Antuco y 331 comunas más
#> 
#> ── Paso 3: casos especiales
#> ℹ Se encontraron 3 casos especiales: Aysén, Cabo de Hornos y Saavedra
#> 
#> ── Paso 4: coincidencias aproximadas de texto
#> ! alerta, no se encontró ninguna coincidencia para la comuna `no informada`
#> ! alerta, no se encontró ninguna coincidencia para la comuna `otro lugar`
#> ℹ Se limpiaron 1 de 3 comunas por medio de coincidencias aproximadas de texto: Trehuaco
#> 
#> ── Conclusión de limpieza de comunas
#> ✔ De las 346 comunas distintas, se limpiaron 344 en total (99.4%)
#> 
```

La función limpia automáticamente los tildes faltantes, las escrituras
alternativas (como *Aisén* por *Aysén* y *Treguaco* por *Trehuaco*), y
los casos especiales como *Puerto Saavedra* (que se estandariza como
*Saavedra*) y *Cabo de Hornos* (que se le suele añadir el texto “Ex
Navarino” o similar). También detecta que *No Informada* y *Otro lugar*
no son comunas reales, dejándolas como `NA`.

Filtramos las filas sin comuna identificada, eliminamos la columna de
nombres de comunas originales, y verificamos el resultado:

``` r

sercotec_limpio <- sercotec_limpio |> 
  filter(!is.na(nombre_comuna)) |> 
  select(-comuna_beneficiario)

sercotec_limpio
#> # A tibble: 951 × 3
#>    sexo_contacto     n nombre_comuna
#>    <chr>         <int> <chr>        
#>  1 Femenino        440 Aysén        
#>  2 Masculino       214 Aysén        
#>  3 No Informa        4 Aysén        
#>  4 Femenino        102 Algarrobo    
#>  5 Masculino        40 Algarrobo    
#>  6 No Informa        2 Algarrobo    
#>  7 Femenino         41 Alhué        
#>  8 Masculino        12 Alhué        
#>  9 Femenino         11 Alto Biobío  
#> 10 Masculino         9 Alto Biobío  
#> # ℹ 941 more rows
```

Opcionalmente, confirmamos que los datos están limpios:

``` r

sercotec_limpio |> 
  validar_comunas(nombre_comuna)
#> ✔ Todas las comunas están correctas!
```

Finalmente, podemos usar
[`ubicar_comunas()`](https://bastianolea.github.io/territorial/reference/ubicar_comunas.md)
para agregar la región correspondiente a cada comuna, y
[`as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md)
para transformar el nombre de la comuna en código único territorial (ver
[`vignette("codigos_unicos_territoriales")`](https://bastianolea.github.io/territorial/articles/codigos_unicos_territoriales.md)):

``` r

sercotec_limpio <- sercotec_limpio |> 
  mutate(nombre_region = ubicar_comunas(nombre_comuna)) |> 
  mutate(codigo_comuna = as_codigo_comuna(nombre_comuna)) |> 
  relocate(codigo_comuna, nombre_region, .after = nombre_comuna)

sercotec_limpio
#> # A tibble: 951 × 5
#>    sexo_contacto     n nombre_comuna codigo_comuna nombre_region                
#>    <chr>         <int> <chr>                 <dbl> <chr>                        
#>  1 Femenino        440 Aysén                 11201 Aysén del General Carlos Ibá…
#>  2 Masculino       214 Aysén                 11201 Aysén del General Carlos Ibá…
#>  3 No Informa        4 Aysén                 11201 Aysén del General Carlos Ibá…
#>  4 Femenino        102 Algarrobo              5602 Valparaíso                   
#>  5 Masculino        40 Algarrobo              5602 Valparaíso                   
#>  6 No Informa        2 Algarrobo              5602 Valparaíso                   
#>  7 Femenino         41 Alhué                 13502 Metropolitana de Santiago    
#>  8 Masculino        12 Alhué                 13502 Metropolitana de Santiago    
#>  9 Femenino         11 Alto Biobío            8314 Biobío                       
#> 10 Masculino         9 Alto Biobío            8314 Biobío                       
#> # ℹ 941 more rows
```

O bien, usamos
[`territorial::contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md)
para agregar todas las columnas de identificación territorial a partir
del nombre de comuna:

``` r

sercotec_limpio |> 
  contextualizar(nombre_comuna)
#> ! más de una variable territorial detectada en los datos! descartando todas excepto `nombre_comuna`.
#> ℹ columnas agregadas: codigo_region, nombre_region, codigo_provincia, nombre_provincia y codigo_comuna
#> # A tibble: 951 × 8
#>    codigo_region nombre_region   codigo_provincia nombre_provincia codigo_comuna
#>            <dbl> <chr>                      <dbl> <chr>                    <dbl>
#>  1            11 Aysén del Gene…              112 Aysén                    11201
#>  2            11 Aysén del Gene…              112 Aysén                    11201
#>  3            11 Aysén del Gene…              112 Aysén                    11201
#>  4             5 Valparaíso                    56 San Antonio               5602
#>  5             5 Valparaíso                    56 San Antonio               5602
#>  6             5 Valparaíso                    56 San Antonio               5602
#>  7            13 Metropolitana …              135 Melipilla                13502
#>  8            13 Metropolitana …              135 Melipilla                13502
#>  9             8 Biobío                        83 Biobío                    8314
#> 10             8 Biobío                        83 Biobío                    8314
#> # ℹ 941 more rows
#> # ℹ 3 more variables: nombre_comuna <chr>, sexo_contacto <chr>, n <int>
```

Con esto tenemos un dataset limpio y territorializado, listo para
análisis posteriores.
