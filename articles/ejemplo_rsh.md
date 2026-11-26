# Ejemplo: Registro Social de Hogares

Usando la plataforma [Analista Digital de Información Social
(ADIS)](https://adis.gob.cl/#/) del Ministerio de Desarrollo Social y
Familia, podemos acceder a datos del Registro Social de Hogares (RSH) a
nivel regional y comunal.

Para descargar una tabla de N° total de **personas con dependencia
moderada o severa** por comuna, accedemos a la sección [Estadísticas
socioeconómicas \> Consultas frecuentes de
ADIS](https://adis.gob.cl/#/estadisticas-socioeconomicas/frecuentes),
elegimos el indicador, seleccionamos en *Territorio y desagregación*
“Nacional por Comunas”, y presionamos *Descargar*. También puedes
[descargar aquí los
datos](https://github.com/bastianolea/territorial/raw/main/data-raw/ejemplo_rsh.xlsx)
para seguir el ejemplo.

``` r

library(dplyr)
library(readxl)
library(here)
```

``` r

registro <- read_xlsx(
  here("data-raw/ejemplo_rsh.xlsx"),
  skip = 2) |> 
  select(
    nombre_comuna = 1,
    discapacidad = 2,
    total = 3
  )

registro
```

    # A tibble: 346 × 3
       nombre_comuna discapacidad  total
       <chr>                <dbl>  <dbl>
     1 Iquique               2437 169606
     2 Alto Hospicio         1614 132584
     3 Pozo Almonte           221  18357
     4 Camiña                  NA   1653
     5 Colchane                14   1538
     6 Huara                   29   3466
     7 Pica                   194   7679
     8 Antofagasta           3980 331442
     9 Mejillones             130  15703
    10 Sierra Gorda            15   1972
    # ℹ 336 more rows

Lo primero que vemos en los datos es que existe una fila de totales que
hay que filtrar, y opcionalmente podríamos omitir las filas sin valor en
el conteo de personas.

``` r

registro_1 <- registro |> 
  filter_out(nombre_comuna == "Total") #|> 
  #filter_out(is.na(discapacidad))
```

Como los datos son comunales, conviene [validarlos primero usando
`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.html)
del paquete [territorial](https://bastianolea.github.io/territorial),
que realiza una revisión de los nombres de comunas.

``` r

library(territorial)

registro_1 |> 
  validar_comunas()
```

    ! Resumen: 4 casos de comunas que no conciden con comunas correctamente escritas (ver `territorial::comunas()`): La Calera, Llay Llay, Alto Bío Bío y Treguaco

    ℹ Problemas comunes: 1 caso de comunas popularmente mal escritas: Llay Llay

    ℹ Escrituras alternativas: 1 caso de comunas escritas de una forma no recomendada, aunque válida: Treguaco

    ✖ Validación de comunas: se encontraron 6 problemas con las comunas! Usa `territorial::limpiar_comunas()` para solucionarlos.

Vemos que existen algunos problemas, así que aplicamos una limpieza
automatizada de los nombres con la [función `limpiar_comunas()` de
`{territorial}`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.html).

``` r

registro_2 <- registro_1 |> 
  limpiar_comunas()
```

    ℹ Limpiando 345 nombres de comunas (345 son distintas)

    → Paso 1: confirmar comunas correctas

    ℹ De las 345 comunas distintas, 341 ya eran correctas: Iquique, Alto Hospicio, Pozo Almonte, Camiña, Colchane, Huara, Pica, Antofagasta, Mejillones, Sierra Gorda y 331 comunas más

    → Paso 2: coincidencias por limpieza de texto

    ℹ No se limpiaron comunas por medio de limpieza de texto

    → Paso 3: casos especiales

    ℹ Se encontraron 2 casos especiales: Calera y Cabo de Hornos

    → Paso 4: coincidencias aproximadas de texto

    ℹ Se limpiaron 3 de 3 comunas por medio de coincidencias aproximadas de texto: Llaillay, Alto Biobío y Trehuaco

    → Conclusión de limpieza de comunas

    ✔ De las 345 comunas distintas, se limpiaron 345 en total (100%)

Ahora que los nombres de comunas fueron validados y limpiados, podemos
[agregar variables territoriales faltantes con
`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.html),
principalmente las columnas de región y los [códigos únicos
territoriales](https://bastianolea.github.io/territorial/articles/codigos_unicos_territoriales.html)
para un manejo más preciso de los datos.

``` r

registro_3 <- registro_2 |> 
  contextualizar() |> 
  select(-starts_with("provincia"))
```

    ℹ No se especificó la variable: asumiendo columna `nombre_comuna`

    ℹ Columnas agregadas: codigo_region, nombre_region, codigo_provincia, nombre_provincia y codigo_comuna

``` r

registro_3 |> 
  head() |> 
  glimpse()
```

    Rows: 6
    Columns: 8
    $ codigo_region    <dbl> 1, 1, 1, 1, 1, 1
    $ nombre_region    <chr> "Tarapacá", "Tarapacá", "Tarapacá", "Tarapacá", "Tara…
    $ codigo_provincia <dbl> 11, 11, 14, 14, 14, 14
    $ nombre_provincia <chr> "Iquique", "Iquique", "Tamarugal", "Tamarugal", "Tama…
    $ codigo_comuna    <dbl> 1101, 1107, 1401, 1402, 1403, 1404
    $ nombre_comuna    <chr> "Iquique", "Alto Hospicio", "Pozo Almonte", "Camiña",…
    $ discapacidad     <dbl> 2437, 1614, 221, NA, 14, 29
    $ total            <dbl> 169606, 132584, 18357, 1653, 1538, 3466

Ahora los datos están en buen estado para seguir trabajando con ellos.
Por ejemplo, podríamos usar [la función `agregar_poblacion()` de
`{poblador}`](https://bastianolea.github.io/poblador/reference/agregar_poblacion.html)
para agregar automáticamente una columna con la población del año 2026
que se corresponda con los datos que estamos trabajando.

## Sumar valores por clasificación comunal

Con los datos ya contextualizados, podemos sumar los valores de personas
con discapacidad y el total de personas por clasificación comunal
(urbana, rural o mixta) usando la función
[`agregar_clasificacion()`](https://bastianolea.github.io/territorial/reference/agregar_clasificacion.md):

``` r

registro_4a <- registro_3 |> 
  agregar_clasificacion()

registro_4a |> 
  select(ends_with("comuna"), clasificacion)
```

    # A tibble: 345 × 3
       codigo_comuna nombre_comuna clasificacion
               <dbl> <chr>         <fct>
     1          1101 Iquique       Urbana
     2          1107 Alto Hospicio Urbana
     3          1401 Pozo Almonte  Rural
     4          1402 Camiña        Rural
     5          1403 Colchane      Rural
     6          1404 Huara         Rural
     7          1405 Pica          Rural
     8          2101 Antofagasta   Urbana
     9          2102 Mejillones    Rural
    10          2103 Sierra Gorda  Rural
    # ℹ 335 more rows

La función opera automáticamente dado que detecta la existencia de los
códigos comunales.

Con esta nueva variable, podemos, por ejemplo, sumar los casos por
clasificación:

``` r

registro_4a |> 
  summarize(discapacidad = sum(discapacidad, na.rm = TRUE),
            total = sum(total, na.rm = TRUE),
            .by = clasificacion) |> 
  mutate(porcentaje = (discapacidad/total)*100)
```

    # A tibble: 3 × 4
      clasificacion discapacidad    total porcentaje
      <fct>                <dbl>    <dbl>      <dbl>
    1 Urbana              219291 12247805       1.79
    2 Rural                37130  2463722       1.51
    3 Mixta                40049  2384233       1.68

## Sumar valores por macrozona

Dado que los datos cuentan con los códigos regionales gracias a
[`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md),
podemos agregar automáticamente una columna con la macrozona a la que
pertenece cada región (y por consiguiente, cada comuna) usando la
función
[`agregar_macrozona()`](https://bastianolea.github.io/territorial/reference/agregar_macrozona.md):

``` r

registro_4b <- registro_3 |> 
  agregar_macrozona()

registro_4b |> 
  select(ends_with("region"), macrozona)
```

    # A tibble: 345 × 3
       codigo_region nombre_region macrozona
               <dbl> <chr>         <fct>
     1             1 Tarapacá      Norte
     2             1 Tarapacá      Norte
     3             1 Tarapacá      Norte
     4             1 Tarapacá      Norte
     5             1 Tarapacá      Norte
     6             1 Tarapacá      Norte
     7             1 Tarapacá      Norte
     8             2 Antofagasta   Norte
     9             2 Antofagasta   Norte
    10             2 Antofagasta   Norte
    # ℹ 335 more rows

Con esta nueva variable, podemos sumar los datos por grupo de macrozona,
de manera similar a como lo hicimos con la clasificación comunal:

``` r

registro_4b |> 
  summarize(discapacidad = sum(discapacidad, na.rm = TRUE),
            total = sum(total, na.rm = TRUE),
            .by = macrozona) |> 
  mutate(porcentaje = (discapacidad/total)*100)
```

    # A tibble: 4 × 4
      macrozona discapacidad    total porcentaje
      <fct>            <dbl>    <dbl>      <dbl>
    1 Norte            33902  2220166       1.53
    2 Centro          175357 10240942       1.71
    3 Sur              83505  4368892       1.91
    4 Austral           3706   265760       1.39
