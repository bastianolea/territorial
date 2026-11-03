# Evaluar si un dato corresponde a un código de región de Chile válido

Dado un vector de cualquier largo, retorna TRUE o FALSE para cada
elemento de acuerdo si se corresponde con los códigos de región de Chile
(números del 1 al 16), disponibles en
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md).

## Uso

``` r
is_codigo_region(codigo_region)
```

## Argumentos

- codigo_region:

  Códigos de región a evaluar, en formato numérico.

## Valor

Vector lógico del mismo largo que `codigo_region`: TRUE o FALSE si es o
no es un código de región válido.

## Detalles

Para más información sobre los códigos únicos territoriales, revisa la
viñeta
[`vignette("codigos_unicos_territoriales")`](https://bastianolea.github.io/territorial/articles/codigos_unicos_territoriales.md)

## Ver también

[`as_codigo_region()`](https://bastianolea.github.io/territorial/reference/as_codigo_region.md)
para convertir nombres de regiones a códigos,
[`is_nombre_region()`](https://bastianolea.github.io/territorial/reference/is_nombre_region.md)
para validar nombres de regiones, y
[`is_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/is_codigo_comuna.md)
para códigos de comunas.

## Ejemplos

``` r
is_codigo_region(7)
#> [1] TRUE

is_codigo_region(c(1, 13, 16, 17, NA))
#> [1]  TRUE  TRUE  TRUE FALSE FALSE
```
