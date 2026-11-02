# Eliminar puntuación, símbolos y números de textos

Eliminar puntuación, símbolos y números de textos

## Uso

``` r
limpiar_texto(texto)
```

## Argumentos

- texto:

  Vector de texto

## Valor

Vector de texto sin puntuación, símbolos y números, en minúsculas y sin
acentos

## Ver también

[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
y
[`limpiar_regiones()`](https://bastianolea.github.io/territorial/reference/limpiar_regiones.md),
que usan este tipo de limpieza para corregir nombres de comunas y
regiones.

## Ejemplos

``` r
limpiar_texto("Ñuñoa")
#> [1] "nunoa"
```
