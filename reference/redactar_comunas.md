# Redactar una secuencia de comunas en una oración

Para un vector de nombres de comuna, retorna un texto con las comunas
redactadas y separadas por comas. Por defecto, sólo redacta un texto de
10 comunas y al final pone "y x comunas más".

## Uso

``` r
redactar_comunas(nombre_comuna, largo = 10)
```

## Argumentos

- nombre_comuna:

  Nombres de comunas

- largo:

  Por defecto, si son demasiadas comunas, trunca el largo a `x` comunas.
  Cambiar a 0 para que muestre todas las comunas.

## Valor

Texto con comunas separadas por comas

## Ejemplos

``` r
redactar_comunas(c("Paine", "Isla de Maipo", "Pirque"))
#> Paine, Isla de Maipo y Pirque
```
