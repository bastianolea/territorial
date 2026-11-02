# Evaluar si un código único territorial comunal es antiguo o desactualizado

Evaluar si un código único territorial comunal es antiguo o
desactualizado

## Uso

``` r
is_codigo_comuna_antiguo(codigo_comuna)
```

## Argumentos

- codigo_comuna:

  Códigos comunales en formato numérico

## Valor

Retorna TRUE o FALSE si es o no es un código único territorial antiguo
(ver
[cut_historicos](https://bastianolea.github.io/territorial/reference/cut_historicos.md))

## Ver también

[`actualizar_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/actualizar_codigo_comuna.md)
para convertir códigos antiguos a los vigentes, e
[`is_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/is_codigo_comuna.md)
para verificar si un código es válido.

## Ejemplos

``` r
is_codigo_comuna_antiguo(8408)
#> [1] TRUE
```
