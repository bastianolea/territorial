# Agregar clasificación comunal PNDR a comunas

Para un vector de comunas, entrega la clasificación comunal PNDR
correspondiente (Rural, Mixta o Urbana), tal como aparecen en
[clasificacion](https://bastianolea.github.io/territorial/reference/clasificacion.md).

## Uso

``` r
agregar_clasificacion(codigo_comuna, ordenar = TRUE)
```

## Argumentos

- codigo_comuna:

  Vector de códigos de comuna, idealmente `codigo_comuna`

- ordenar:

  Entregar resultados como un factor ordenado (Rural, Mixta, Urbana), o
  como textos sin orden. Por defecto entrega factor.

## Valor

Factor con clasificación comunal (Rural, Mixta o Urbana)

## Ver también

[clasificacion](https://bastianolea.github.io/territorial/reference/clasificacion.md)
para la tabla completa de clasificación comunal, y
[`agregar_macrozona()`](https://bastianolea.github.io/territorial/reference/agregar_macrozona.md)
para agrupar regiones en macrozonas. Si no tienes códigos comunales, usa
[`as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md)
o
[`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md).

## Ejemplos

``` r
agregar_clasificacion(8107)
#> [1] Mixta
#> Levels: Rural Mixta Urbana
```
