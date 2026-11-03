# Agregar clasificación comunal PNDR a comunas

Para un vector de comunas, entrega la clasificación comunal PNDR
correspondiente (Rural, Mixta o Urbana), tal como aparecen en
[clasificacion](https://bastianolea.github.io/territorial/reference/clasificacion.md).

## Uso

``` r
agregar_clasificacion(codigo_comuna, ordenar = TRUE)
```

## Argumentos

- codigo_comuna:

  Vector de códigos de comuna, idealmente `codigo_comuna`. También puede
  ser un data frame con la columna `codigo_comuna`, en cuyo caso se
  retorna el data frame con la columna nueva `clasificacion`.

- ordenar:

  Entregar resultados como un factor ordenado (Rural, Mixta, Urbana), o
  como textos sin orden. Por defecto entrega factor.

## Valor

Factor con clasificación comunal (Rural, Mixta o Urbana). Si la entrada
es un data frame, retorna el data frame con la columna `clasificacion`
agregada.

## Ver también

[clasificacion](https://bastianolea.github.io/territorial/reference/clasificacion.md)
para la tabla completa de clasificación comunal, y
[`agregar_macrozona()`](https://bastianolea.github.io/territorial/reference/agregar_macrozona.md)
para agrupar regiones en macrozonas. Si no tienes códigos comunales, usa
[`as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md)
o
[`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md).

## Ejemplos

``` r
agregar_clasificacion(8107)
#> [1] Mixta
#> Levels: Rural Mixta Urbana

# con un data frame, usa la columna `codigo_comuna`
territorios |>
  agregar_clasificacion()
#> # A tibble: 346 × 7
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
#> # ℹ 2 more variables: nombre_comuna <chr>, clasificacion <fct>
```
