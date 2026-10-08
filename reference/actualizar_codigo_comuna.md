# Actualizar códigos únicos territoriales comunales antiguos o desactualizados

Función que recibe códigos únicos territoriales desactualizados
(confirmar con
[`is_codigo_comuna_antiguo()`](https://bastianolea.github.io/territorial/reference/is_codigo_comuna_antiguo.md)),
y retorna las versiones actualizadas al 2017 (posterior a la creación de
la región de Ñuble).

## Uso

``` r
actualizar_codigo_comuna(codigo_comuna)
```

## Argumentos

- codigo_comuna:

  Códigos comunales en formato numérico

## Valor

Códigos comunales actualizados correspondientes a los desactualizados
entregados. Si los códigos entregados no son antiguos, se mantienen sin
cambios.

## Ejemplos

``` r
actualizar_codigo_comuna(8408)
#> [1] 16204
```
