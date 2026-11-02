# Evaluar si un texto corresponde al nombre válido de una comuna de Chile

Dado un vector de cualquier largo, retorna TRUE o FALSE para cada
elemento de acuerdo si se corresponde con los nombres de comunas
oficiales, disponibles en la función
[`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md).

## Uso

``` r
is_nombre_comuna(nombre_comuna, intentar = FALSE)
```

## Argumentos

- nombre_comuna:

  Elemento/s a evaluar

- intentar:

  Si la comuna no es válida, tratar de interpretarla con
  [`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)

## Valor

TRUE o FALSE si es o no es una comuna válida

## Ver también

[`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md)
para un diagnóstico detallado de los problemas, y
[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
para corregirlos. Para regiones, usa
[`is_nombre_region()`](https://bastianolea.github.io/territorial/reference/is_nombre_region.md).

## Ejemplos

``` r
is_nombre_comuna("Panguipulli")
#> [1] TRUE
```
