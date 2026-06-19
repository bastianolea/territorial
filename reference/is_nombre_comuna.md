# Evaluar si un texto corresponde al nombre válido de una comuna de Chile

Dado un vector de cualquier largo, retorna TRUE o FALSE para cada
elemento de acuerdo si se corresponde con los nombres de comunas
oficiales, disponibles en la función
[`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md).

## Uso

``` r
is_nombre_comuna(x)
```

## Argumentos

- x:

  Elemento/s a evaluar

## Valor

TRUE o FALSE si es o no es una comuna válida

## Ejemplos

``` r
is_nombre_comuna("Panguipulli")
#> [1] TRUE
```
