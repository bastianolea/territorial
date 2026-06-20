# Artículos (de/del) de cada región de Chile

Esta función entrega el artículo usado para cada región de Chile; por
ejemplo, Valparaíso es la "Región *de* Valparaíso", pero Maule es la
"Región *del* Maule".

## Uso

``` r
articulo_region(nombre_region)
```

## Argumentos

- nombre_region:

  Nombres de región, como aparecen en
  [`regiones()`](https://bastianolea.github.io/territorial/reference/regiones.md)

## Valor

Vector de artículos para cada nombre de región. Retorna NA si no se
detecta la región.

## Ejemplos

``` r
articulo_region("Ñuble")
#> [1] "de"
```
