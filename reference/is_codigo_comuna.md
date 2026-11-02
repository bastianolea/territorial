# Evaluar si un dato corresponde a un código territorial válido de una comuna de Chile

Dado un vector de cualquier largo, retorna TRUE o FALSE para cada
elemento de acuerdo si se corresponde con los códigos únicos
territoriales de comunas de Chile, disponibles en
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md).

## Uso

``` r
is_codigo_comuna(codigo_comuna)
```

## Argumentos

- codigo_comuna:

  Códigos territoriales a evaluar, en formato numérico. Si vienen en
  formato caracter, se convierten.

## Valor

Retorna TRUE o FALSE si es o no es un código único territorial válido
(ver
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md))

## Detalles

Para más información sobre los códigos únicos territoriales, revisa la
viñeta
[`vignette("codigos_unicos_territoriales")`](https://bastianolea.github.io/territorial/articles/codigos_unicos_territoriales.md)

## Ver también

[`is_codigo_comuna_antiguo()`](https://bastianolea.github.io/territorial/reference/is_codigo_comuna_antiguo.md)
y
[`actualizar_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/actualizar_codigo_comuna.md)
para detectar y corregir códigos desactualizados, y
[`as_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/as_nombre_comuna.md)
para convertir códigos a nombres.

## Ejemplos

``` r
is_codigo_comuna(1101)
#> [1] TRUE
```
