# Validación de calidad de nombres de regiones de Chile

Esta función recibe la columna con nombres de regiones de un dataframe
(idealmente `nombre_region`), y retorna una evaluación de posibles
problemas con los nombres existentes. Funciona tanto con un dataframe
con una columna `nombre_region`, o un vector que contenga los nombres de
regiones a evaluar. La función solamente retorna avisos cuando existan
problemas, por lo que si todos los datos son correctos, solo devolverá
los datos tal cual.

## Uso

``` r
validar_regiones(datos, variable = NULL)
```

## Argumentos

- datos:

  Dataframe con una columna de nombre de regiones, o vector de nombres
  de regiones

- variable:

  Columna del dataframe con los nombres de regiones (se pasa sin
  comillas, p.ej. `region`)

## Valor

Dataframe o vector intacto, con mensajes de diagnóstico si se encuentran
problemas de calidad

## Ejemplos

``` r
validar_regiones(c("los lagos", "nuble", "OHIGGINS"))
#> ! mayúsculas: 1 caso de regiones escritas en mayúsculas
#> ! mayúsculas: 2 casos de regiones escritas en minúsculas
#> ! ortografía: 1 caso de la Región de Ñuble escrita sin eñe
#> ! ortografía: 1 caso de la Región de O'Higgins escrita sin su apóstrofo (')
#> [1] "los lagos" "nuble"     "OHIGGINS" 

territorial::territorios |>
  validar_regiones(nombre_region)
#> # A tibble: 346 × 6
#>    codigo_region nombre_region codigo_provincia nombre_provincia codigo_comuna
#>            <dbl> <chr>                    <dbl> <chr>                    <dbl>
#>  1             1 Tarapacá                    11 Iquique                   1101
#>  2             1 Tarapacá                    11 Iquique                   1107
#>  3             1 Tarapacá                    14 Tamarugal                 1401
#>  4             1 Tarapacá                    14 Tamarugal                 1402
#>  5             1 Tarapacá                    14 Tamarugal                 1403
#>  6             1 Tarapacá                    14 Tamarugal                 1404
#>  7             1 Tarapacá                    14 Tamarugal                 1405
#>  8             2 Antofagasta                 21 Antofagasta               2101
#>  9             2 Antofagasta                 21 Antofagasta               2102
#> 10             2 Antofagasta                 21 Antofagasta               2103
#> # ℹ 336 more rows
#> # ℹ 1 more variable: nombre_comuna <chr>
```
