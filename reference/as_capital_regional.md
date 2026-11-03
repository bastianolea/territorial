# Convertir regiones a capitales regionales

Entregando códigos regionales (como los que aparecen en
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md))
o nombres de regiones, retorna los nombres de las comunas que son
capitales regionales correspondientes. Retorna NA si no corresponde con
ninguna.

## Uso

``` r
as_capital_regional(codigos_regiones)
```

## Argumentos

- codigos_regiones:

  Códigos regionales en formato numérico, o nombres de regiones (como en
  [`regiones()`](https://bastianolea.github.io/territorial/reference/regiones.md))

## Valor

Vector con nombres de comunas capitales regionales

## Detalles

Esta función es útil para imputar datos cuando se cuenta con la región,
pero no se tiene información de las comunas, en cuyo caso se podría
imputar la capital regional de la región como comuna de reemplazo.

## Ver también

[`capitales_regionales()`](https://bastianolea.github.io/territorial/reference/capitales_regionales.md)
para obtener la tabla de capitales regionales,
[`is_capital_regional()`](https://bastianolea.github.io/territorial/reference/is_capital_regional.md)
para confirmar si las comunas son capitales, y
[`as_nombre_region()`](https://bastianolea.github.io/territorial/reference/as_nombre_region.md)
para convertir códigos regionales a nombres de regiones.

## Ejemplos

``` r

as_capital_regional(c(15, 4, 10, 99))
#> Warning: Algunos códigos regionales no pudieron convertirse a capitales regionales: 99
#> [1] "Arica"        "Coquimbo"     "Puerto Montt" NA            

as_capital_regional(c("Maule", "Ñuble"))
#> [1] "Talca"   "Chillán"
```
