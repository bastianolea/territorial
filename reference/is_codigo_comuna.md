# Evaluar si un texto corresponde a un código territorial válido de una comuna de Chile

Dado un vector de cualquier largo, retorna TRUE o FALSE para cada
elemento de acuerdo si se corresponde con los códigos únicos
territoriales de comunas de Chile, disponibles en la función
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md).

## Uso

``` r
is_codigo_comuna(x)
```

## Argumentos

- x:

  Elemento/s a evaluar

## Valor

TRUE o FALSE si es o no es una comuna válida

## Ejemplos

``` r
is_codigo_comuna(1101)
#> [1] TRUE
```
