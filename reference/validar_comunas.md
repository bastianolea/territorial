# Validación de calidad de nombres de comunas de Chile

Esta función recibe una columna con nombres de comunas de un dataframe
(idealmente `nombre_comuna`), o un vector con nombres de comunas, y
retorna una evaluación de posibles problemas con los nombres existentes.
Funciona tanto con un dataframe con una columna `nombre_comuna`, o un
vector que contenga los nombres de comunas a evaluar.

## Uso

``` r
validar_comunas(datos, variable = "nombre_comuna")
```

## Argumentos

- nombre_comuna:

  Columna de un dataframe con nombres de comunas, o vector con nombres
  de comunas

## Valor

Dataframe o vector intacto, con mensajes de diagnóstico si se encuentran
problemas de calidad

## Ejemplos

``` r
validar_comunas(c("colliguay", "la florida", "paine"))
#> ! mayúsculas: 3 casos de comunas escritas en minúsculas
#> ℹ resumen: 3 casos de comunas que no conciden con comunas correctamente escritas (ver `territorial::comunas()`)
#> [1] "colliguay"  "la florida" "paine"     

territorial::territorios |>
  validar_comunas()
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
