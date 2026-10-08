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

## Ejemplos

``` r
is_codigo_comuna_antiguo(8408)
#> [1] TRUE
```
