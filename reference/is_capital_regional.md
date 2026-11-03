# Evaluar si una comuna corresponde a una capital regional

Dado un vector de cualquier largo, retorna TRUE o FALSE para cada
elemento de acuerdo si la comuna corresponde a una de las 16 capitales
regionales de Chile, disponibles en
[`capitales_regionales()`](https://bastianolea.github.io/territorial/reference/capitales_regionales.md).

## Uso

``` r
is_capital_regional(codigo_comuna)
```

## Argumentos

- codigo_comuna:

  Códigos de comuna en formato numérico, o nombres de comuna (como los
  que aparecen en
  [`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md))
  en formato caracter.

## Valor

Vector lógico del mismo largo que `codigo_comuna`: TRUE o FALSE si es o
no es una capital regional.

## Detalles

Acepta tanto códigos de comuna en formato numérico como nombres de
comuna en formato caracter.

## Ver también

[`capitales_regionales()`](https://bastianolea.github.io/territorial/reference/capitales_regionales.md)
para ver la tabla de capitales regionales,
[`as_capital_regional()`](https://bastianolea.github.io/territorial/reference/as_capital_regional.md)
para convertir regiones a comunas capitales,
[`as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md)
para convertir nombres de comunas a códigos, y
[`is_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/is_codigo_comuna.md)
para validar códigos de comunas.

## Ejemplos

``` r
is_capital_regional(13101)
#> [1] TRUE

is_capital_regional(c("Santiago", "Puente Alto", "Valparaíso"))
#> [1]  TRUE FALSE  TRUE
```
