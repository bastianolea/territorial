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

  Por defecto, si son demasiadas comunas, trunca el largo a 10 comunas e
  indica "y `x` comunas más". Cambiar al número máximo de comunas, o 0
  para que muestre todas las comunas.

## Valor

Texto con comunas separadas por comas

## Ver también

[`abreviar_comunas()`](https://bastianolea.github.io/territorial/reference/abreviar_comunas.md)
para siglas de comunas, y
[`redactar_region()`](https://bastianolea.github.io/territorial/reference/redactar_region.md)
para redactar nombres de regiones.

## Ejemplos

``` r
redactar_comunas(c("Paine", "Isla de Maipo", "Pirque"))
#> Paine, Isla de Maipo y Pirque
```
