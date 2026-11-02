# Convertir nombres de regiones a códigos regionales

Entregando nombres de región correctos (como los que aparecen en
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md)),
retorna los códigos de región correspondientes en formato numérico
(números del 1 al 16). Retorna NA si no corresponde con ninguna.

## Uso

``` r
as_codigo_region(nombres_regiones)
```

## Argumentos

- nombres_regiones:

  Nombres de región (como los que aparecen en
  [territorios](https://bastianolea.github.io/territorial/reference/territorios.md))
  en formato caracter.

## Valor

Vector numérico con códigos de región.

## Detalles

Para más información sobre los códigos únicos territoriales, revisa la
viñeta
[`vignette("codigos_unicos_territoriales")`](https://bastianolea.github.io/territorial/articles/codigos_unicos_territoriales.md)

## Ver también

[`as_nombre_region()`](https://bastianolea.github.io/territorial/reference/as_nombre_region.md)
para la conversión inversa, y
[`limpiar_regiones()`](https://bastianolea.github.io/territorial/reference/limpiar_regiones.md)
para corregir los nombres antes de convertirlos. Para comunas, usa
[`as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md).

## Ejemplos

``` r
as_codigo_region("Metropolitana de Santiago")
#> [1] 13
```
