# Agregar orden geográfico (norte a sur) a códigos de regiones

Función usada internamente para
[`ordenar_regiones()`](https://bastianolea.github.io/territorial/reference/ordenar_regiones.md).
Recibe un vector de números de región (entre 1 y 16) y retorna la
posición de norte a sur de dicha región, de modo que Arica sea 1 y
Magallanes sea 16.

## Uso

``` r
agregar_orden_region(codigo_region)
```

## Argumentos

- codigo_region:

  Vector de códigos únicos de región (entre 1 y 16)

## Valor

Vector con la posición de norte a sur de la región respectiva

## Ver también

[`ordenar_regiones()`](https://bastianolea.github.io/territorial/reference/ordenar_regiones.md)
para ordenar directamente una tabla de datos de norte a sur, y
[`agregar_macrozona()`](https://bastianolea.github.io/territorial/reference/agregar_macrozona.md)
para agrupar regiones en macrozonas.

## Ejemplos

``` r
agregar_orden_region(15) # Arica
#> [1] 1
```
