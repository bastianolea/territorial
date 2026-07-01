# Ejemplo: préstamos en bibliotecas

En este ejemplo se limpian datos territoriales sobre préstamo de
material bibliográfico en bibliotecas públicas de Chile, a nivel comunal
y por género de las personas solicitantes de material. Los datos
corresponden al año 2025, y fueron obtenidos desde el Servicio Nacional
del Patrimonio Cultural por medio de una solicitud de transparencia
realizada el año 2025.

Estos datos son públicos y oficiales, y fueron obtenidos como parte del
desarrollo del [Índice de Brechas de
Género](https://www.descentralizachile.cl/ibg/) de Subdere.

Puedes [descargar aquí los
datos](https://github.com/bastianolea/territorial/raw/main/data-raw/ejemplo_bibliotecas.xlsx)
para seguir el ejemplo.

------------------------------------------------------------------------

Primero cargamos los datos originales:

``` r

library(readxl)
library(here)
#> here() starts at /home/runner/work/territorial/territorial

biblio <- read_xlsx(
  here("data-raw/ejemplo_bibliotecas.xlsx"),
  sheet = 2,
  skip = 3)

biblio
#> # A tibble: 1,345 × 9
#>    `Región / Comuna / Sexo` `0 No corresponde*` `1 Primera infancia (0 - 4)`
#>    <chr>                                  <dbl>                        <dbl>
#>  1 Arica y Parinacota                      5184                          768
#>  2 Arica                                   5003                          768
#>  3 Mujer                                    461                          366
#>  4 Hombre                                    11                          398
#>  5 Sin información                         4431                            4
#>  6 No binario**                             100                            0
#>  7 Camarones                                181                            0
#>  8 Mujer                                      0                            0
#>  9 Hombre                                     5                            0
#> 10 Sin información                          176                            0
#> # ℹ 1,335 more rows
#> # ℹ 6 more variables: `2 Niños (5 - 11)` <dbl>,
#> #   `3 Adolescentes (12 - 17)` <dbl>, `4 Jóvenes (18 - 29 )` <dbl>,
#> #   `5 Adultos (30 a 59)` <dbl>, `6 Personas mayores (60+)` <dbl>,
#> #   `Total general` <dbl>
```

Notamos que en una sola columna se codifican las regiones, las comunas y
el sexo de las personas, una pésima práctica de gestión de los datos,
pero que lamentablemente resulta común, y que las cifras que
corresponden a libros prestados están disgregadas en varias columnas que
codifican una misma variable, la edad.

Empezamos la limpieza omitiendo la variable de edad para quedarnos con
la columna que codifica los tres grupos, y la cantidad total de
préstamos:

``` r

library(dplyr)
library(janitor)

biblio <- biblio |> 
  clean_names() |> 
  select(grupo = region_comuna_sexo, 
         prestamos = total_general)

biblio
#> # A tibble: 1,345 × 2
#>    grupo              prestamos
#>    <chr>                  <dbl>
#>  1 Arica y Parinacota     27407
#>  2 Arica                  26887
#>  3 Mujer                  10507
#>  4 Hombre                 11332
#>  5 Sin información         4948
#>  6 No binario**             100
#>  7 Camarones                397
#>  8 Mujer                    129
#>  9 Hombre                    92
#> 10 Sin información          176
#> # ℹ 1,335 more rows
```

Luego intentamos codificar los valores de la columna miscelánea para
detectar cuando las filas contengan valores por género:

``` r

biblio <- biblio |> 
  mutate(tipo = case_when(
    grupo %in% c("Mujer", "Hombre", "Sin información", 
                 "No binario", "No binario**") ~ "genero",
    .default = "otro")
  ) |> 
  filter(grupo != "Total general")

biblio
#> # A tibble: 1,344 × 3
#>    grupo              prestamos tipo  
#>    <chr>                  <dbl> <chr> 
#>  1 Arica y Parinacota     27407 otro  
#>  2 Arica                  26887 otro  
#>  3 Mujer                  10507 genero
#>  4 Hombre                 11332 genero
#>  5 Sin información         4948 genero
#>  6 No binario**             100 genero
#>  7 Camarones                397 otro  
#>  8 Mujer                    129 genero
#>  9 Hombre                    92 genero
#> 10 Sin información          176 genero
#> # ℹ 1,334 more rows
```

Dado que detectamos en la columna `tipo` las observaciones que contienen
datos de género, podemos asumir que todas las demás filas corresponden a
unidades territoriales: ya sean comunas o regiones.

``` r

biblio <- biblio |> 
  mutate(unidad = case_when(tipo == "otro" ~ grupo))

biblio
#> # A tibble: 1,344 × 4
#>    grupo              prestamos tipo   unidad            
#>    <chr>                  <dbl> <chr>  <chr>             
#>  1 Arica y Parinacota     27407 otro   Arica y Parinacota
#>  2 Arica                  26887 otro   Arica             
#>  3 Mujer                  10507 genero <NA>              
#>  4 Hombre                 11332 genero <NA>              
#>  5 Sin información         4948 genero <NA>              
#>  6 No binario**             100 genero <NA>              
#>  7 Camarones                397 otro   Camarones         
#>  8 Mujer                    129 genero <NA>              
#>  9 Hombre                    92 genero <NA>              
#> 10 Sin información          176 genero <NA>              
#> # ℹ 1,334 more rows
```

Como las filas de esta tabla desordenada vienen ordenadas, podemos
identificar que los géneros que detectamos en cada fila corresponden a
la comuna que tienen inmediatamente encima, así que extendemos el valor
de las unidades territoriales hacia abajo con
[`tidyr::fill()`](https://tidyr.tidyverse.org/reference/fill.html):

``` r

library(tidyr)

biblio <- biblio |> 
  fill(unidad, .direction = "down")

biblio
#> # A tibble: 1,344 × 4
#>    grupo              prestamos tipo   unidad            
#>    <chr>                  <dbl> <chr>  <chr>             
#>  1 Arica y Parinacota     27407 otro   Arica y Parinacota
#>  2 Arica                  26887 otro   Arica             
#>  3 Mujer                  10507 genero Arica             
#>  4 Hombre                 11332 genero Arica             
#>  5 Sin información         4948 genero Arica             
#>  6 No binario**             100 genero Arica             
#>  7 Camarones                397 otro   Camarones         
#>  8 Mujer                    129 genero Camarones         
#>  9 Hombre                    92 genero Camarones         
#> 10 Sin información          176 genero Camarones         
#> # ℹ 1,334 more rows
```

Ahora recodificamos rápidamente los géneros para reducir sus
posibilidades, y excluimos todos los demás valores que nos resultan
irrelevantes por el momento:

``` r

library(stringr)

biblio <- biblio |> 
  filter(tipo == "genero") |> 
  mutate(genero = case_when(
    grupo == "Mujer" ~ "Femenino",
    grupo == "Hombre" ~ "Masculino",
    str_detect(grupo, "No bin") ~ "No binario")) |> 
  filter_out(is.na(genero))

biblio
#> # A tibble: 714 × 5
#>    grupo        prestamos tipo   unidad        genero    
#>    <chr>            <dbl> <chr>  <chr>         <chr>     
#>  1 Mujer            10507 genero Arica         Femenino  
#>  2 Hombre           11332 genero Arica         Masculino 
#>  3 No binario**       100 genero Arica         No binario
#>  4 Mujer              129 genero Camarones     Femenino  
#>  5 Hombre              92 genero Camarones     Masculino 
#>  6 Mujer                3 genero General Lagos Femenino  
#>  7 Hombre               1 genero General Lagos Masculino 
#>  8 Mujer               75 genero Putre         Femenino  
#>  9 Hombre              44 genero Putre         Masculino 
#> 10 Mujer             2975 genero Alto Hospicio Femenino  
#> # ℹ 704 more rows
```

Como solamente las comunas tenían datos de género, al excluir los
géneros no identificados también estamos excluyendo los totales
regionales, que entorpecían la estructura de los datos sin aportar
información (dado que son meramente la suma de los valores comunales).

Finalmente, pivotamos los valores hacia lo ancho, para terminar con una
columna por género, y una fila por comuna.

``` r

biblio_ancho <- biblio |> 
  select(-tipo, -grupo) |> 
  pivot_wider(names_from = genero, values_from = prestamos, values_fill = 0)

biblio_ancho
#> # A tibble: 325 × 4
#>    unidad        Femenino Masculino `No binario`
#>    <chr>            <dbl>     <dbl>        <dbl>
#>  1 Arica            10507     11332          100
#>  2 Camarones          129        92            0
#>  3 General Lagos        3         1            0
#>  4 Putre               75        44            0
#>  5 Alto Hospicio     2975      1321            0
#>  6 Huara              100        39            0
#>  7 Iquique            410       336            0
#>  8 Pica               148        82           18
#>  9 Pozo Almonte        25        40            0
#> 10 Antofagasta      16749      8420           53
#> # ℹ 315 more rows
```

Ahora cargamos el paquete
[territorial](https://bastianolea.github.io/territorial) para evaluar la
calidad de los nombres de las comunas en esta base de datos:

``` r

library(territorial)

biblio_ancho |> 
  validar_comunas(unidad)
#> ! Resumen: 8 casos de comunas que no conciden con comunas correctamente escritas (ver `territorial::comunas()`): La Calera, Treguaco, Alto BioBío, Los Ángeles, Padre las Casas, Aisén, Coihaique y O’Higgins
#> ℹ Escrituras alternativas: 2 casos de comunas escritas de una forma no recomendada, aunque válida: Treguaco y Aisén
#> ✖ Validación de comunas: se encontraron 10 problemas con las comunas! Usa `territorial::limpiar_comunas()` para solucionarlos.
```

Como vemos en el reporte, nos encontramos con varias comunas con
problemas de escritura: entre ellas La Calera (debería ser *Calera)*,
Alto BioBío (*Alto Biobío*), Aisén y Coihaique con redacciones
alternativas y O’Higgins con un apóstrofo incorrecto.

Para corregir estos problemas y limpiar los datos de nivel comunal
usamos
[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
sobre la columna que contiene las unidades territoriales:

``` r

biblio_limpio <- biblio_ancho |> 
  mutate(nombre_comuna = limpiar_comunas(unidad)) |> 
  relocate(nombre_comuna) |> 
  select(-unidad)
#> ℹ Limpiando 325 nombres de comunas (325 son distintas)
#> 
#> ── Paso 1: confirmar comunas correctas
#> ℹ De las 325 comunas distintas, 317 ya eran correctas: Arica, Camarones, General Lagos, Putre, Alto Hospicio, Huara, Iquique, Pica, Pozo Almonte, Antofagasta y 307 comunas más
#> 
#> ── Paso 2: coincidencias por limpieza de texto
#> ℹ A partir de la limpieza de texto, se limpiaron 321 de 325 comunas: Arica, Camarones, General Lagos, Putre, Alto Hospicio, Huara, Iquique, Pica, Pozo Almonte, Antofagasta y 311 comunas más
#> 
#> ── Paso 3: casos especiales
#> ℹ Se encontraron 3 casos especiales: Calera, Aysén y Coyhaique
#> 
#> ── Paso 4: coincidencias aproximadas de texto
#> ℹ Se limpiaron 1 de 1 comunas por medio de coincidencias aproximadas de texto: Trehuaco
#> 
#> ── Conclusión de limpieza de comunas
#> ✔ De las 325 comunas distintas, se limpiaron 325 en total (100%)
#> 

biblio_limpio
#> # A tibble: 325 × 4
#>    nombre_comuna Femenino Masculino `No binario`
#>    <chr>            <dbl>     <dbl>        <dbl>
#>  1 Arica            10507     11332          100
#>  2 Camarones          129        92            0
#>  3 General Lagos        3         1            0
#>  4 Putre               75        44            0
#>  5 Alto Hospicio     2975      1321            0
#>  6 Huara              100        39            0
#>  7 Iquique            410       336            0
#>  8 Pica               148        82           18
#>  9 Pozo Almonte        25        40            0
#> 10 Antofagasta      16749      8420           53
#> # ℹ 315 more rows
```

La función indica los detalles de los problemas corregidos, e indica
que, si bien habían 317 comunas de 325 correctamente escritas, se
limpiaron el 100% de las comunas; es decir, cada comuna encontró una
coincicencia con una comuna bien escrita, por medio de alguno de los
pasos de limpieza.

Ahora que tenemos las comunas correctas, podemos usar
[`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md)
para agregar todas las demás columnas territoriales (códigos únicos
territoriales, regiones, provincias), o si solamente necesitamos las
regiones, usamos
[`ubicar_comunas()`](https://bastianolea.github.io/territorial/reference/ubicar_comunas.md)
para obtener la región de cada comuna:

``` r

biblio_limpio <- biblio_limpio |> 
  mutate(nombre_region = ubicar_comunas(nombre_comuna)) |> 
  relocate(nombre_region, .after = nombre_comuna)

biblio_limpio
#> # A tibble: 325 × 5
#>    nombre_comuna nombre_region      Femenino Masculino `No binario`
#>    <chr>         <chr>                 <dbl>     <dbl>        <dbl>
#>  1 Arica         Arica y Parinacota    10507     11332          100
#>  2 Camarones     Arica y Parinacota      129        92            0
#>  3 General Lagos Arica y Parinacota        3         1            0
#>  4 Putre         Arica y Parinacota       75        44            0
#>  5 Alto Hospicio Tarapacá               2975      1321            0
#>  6 Huara         Tarapacá                100        39            0
#>  7 Iquique       Tarapacá                410       336            0
#>  8 Pica          Tarapacá                148        82           18
#>  9 Pozo Almonte  Tarapacá                 25        40            0
#> 10 Antofagasta   Antofagasta           16749      8420           53
#> # ℹ 315 more rows
```

Terminamos un dataset con datos limpios! Podemos confirmarlo porque
[`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md)
no retorna ninguna alerta:

``` r

biblio_limpio |> 
  validar_comunas(nombre_comuna)
#> ✔ Todas las comunas están correctas!
```

O podemos confirmar filtrando los datos que no son nombres de comuna
correctos:

``` r

biblio_limpio |> 
  filter(!is_nombre_comuna(nombre_comuna))
#> # A tibble: 0 × 5
#> # ℹ 5 variables: nombre_comuna <chr>, nombre_region <chr>, Femenino <dbl>,
#> #   Masculino <dbl>, No binario <dbl>
```
