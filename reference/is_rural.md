# Evaluar si una comuna es rural

Dado un vector de cualquier largo, retorna TRUE o FALSE para cada
elemento de acuerdo si la comuna está clasificada como "Rural" en la
tabla
[clasificacion](https://bastianolea.github.io/territorial/reference/clasificacion.md)
(clasificación comunal de la Política Nacional de Desarrollo Rural,
PNDR, según el Censo 2024).

## Uso

``` r
is_rural(codigo_comuna)
```

## Argumentos

- codigo_comuna:

  Códigos de comuna en formato numérico, o nombres de comuna (como los
  que aparecen en
  [`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md))
  en formato caracter.

## Valor

Vector lógico del mismo largo que `codigo_comuna`: TRUE si la comuna es
rural, FALSE si es mixta o urbana, y NA si la comuna no se encuentra en
la tabla de clasificación.

## Ver también

[clasificacion](https://bastianolea.github.io/territorial/reference/clasificacion.md)
para ver la tabla de clasificación comunal,
[`agregar_clasificacion()`](https://bastianolea.github.io/territorial/reference/agregar_clasificacion.md)
para agregar la clasificación a una tabla, y
[`as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md)
para convertir nombres de comunas a códigos.

## Ejemplos

``` r
is_rural(1401)
#> [1] TRUE

is_rural(c("Santiago", "Camiña", "Casablanca"))
#> [1] FALSE  TRUE FALSE
```
