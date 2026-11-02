# Insertar caracteres al azar para ensuciar texto

Insertar caracteres al azar para ensuciar texto

## Uso

``` r
insertar_texto(texto, porcentaje = 0.1, caracteres = c(letters, LETTERS))
```

## Argumentos

- texto:

  Vector de texto

- porcentaje:

  Porcentaje de caracteres a insertar

- caracteres:

  Vector de caracteres para insertar

## Valor

Vector de texto con caracteres insertados al azar

## Ver también

[`eliminar_texto()`](https://bastianolea.github.io/territorial/reference/eliminar_texto.md)
y
[`reemplazar_texto()`](https://bastianolea.github.io/territorial/reference/reemplazar_texto.md)
para otras formas de ensuciar texto, útiles para probar
[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md).

## Ejemplos

``` r
insertar_texto(c("mapache", "lindo"), porcentaje = 0.3)
#> [1] "lmfapache" "lindHo"   
```
