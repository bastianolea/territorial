# Agregar clasificación comunal PNDR a comunas

Para un vector de comunas, entrega la clasificación comunal PNDR
correspondiente (Rural, Mixta o Urbana), tal como aparecen en
[clasificacion](https://bastianolea.github.io/territorial/reference/clasificacion.md).

## Uso

``` r
agregar_clasificacion(codigo_comuna)
```

## Argumentos

- codigo_comuna:

  Vector de códigos de comuna, idealmente `codigo_comuna`

## Valor

Vector con clasificación comunal (Rural, Mixta o Urbana)

## Ejemplos

``` r
agregar_clasificacion(8107)
#> [1] "Mixta"
```
