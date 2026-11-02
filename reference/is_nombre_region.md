# Evaluar si un texto corresponde a un nombre de región de Chile válido

Dado un vector de cualquier largo, retorna TRUE o FALSE para cada
elemento de acuerdo si se corresponde con los nombres de regiones de
Chile, disponibles en
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md).

## Uso

``` r
is_nombre_region(nombre_region)
```

## Argumentos

- nombre_region:

  Elemento/s a evaluar

## Valor

TRUE o FALSE si es o no es un código único territorial válido

## Ver también

[`validar_regiones()`](https://bastianolea.github.io/territorial/reference/validar_regiones.md)
para un diagnóstico detallado de los problemas, y
[`limpiar_regiones()`](https://bastianolea.github.io/territorial/reference/limpiar_regiones.md)
para corregirlos. Para comunas, usa
[`is_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/is_nombre_comuna.md).

## Ejemplos

``` r
is_nombre_region("Maule")
#> [1] TRUE
```
