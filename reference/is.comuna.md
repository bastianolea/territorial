# Evaluar si un texto corresponde al nombre válido de una comuna de Chile

Dado un vector de cualquier largo, retorna TRUE o FALSE para cada
elemento de acuerdo si se corresponde con los nombres de comunas
oficiales, disponibles en la función
[`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md).

## Usage

``` r
is.comuna(x)
```

## Arguments

- x:

  Elemento/s a evaluar

## Value

TRUE o FALSE si es o no es una comuna válida

## Examples

``` r
is.comuna("Panguipulli")
#> [1] TRUE
```
