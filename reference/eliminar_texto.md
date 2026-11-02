# Eliminar caracteres al azar para ensuciar texto

Eliminar caracteres al azar para ensuciar texto

## Uso

``` r
eliminar_texto(texto, porcentaje = 0.1)
```

## Argumentos

- texto:

  Vector de texto

- porcentaje:

  Porcentaje de caracteres a eliminar

## Valor

Vector de texto con caracteres eliminados al azar

## Ver también

[`insertar_texto()`](https://bastianolea.github.io/territorial/reference/insertar_texto.md)
y
[`reemplazar_texto()`](https://bastianolea.github.io/territorial/reference/reemplazar_texto.md)
para otras formas de ensuciar texto, útiles para probar
[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md).

## Ejemplos

``` r
eliminar_texto(c("mapache", "lindo"), porcentaje = 0.3)
#> [1] "mpche" "lndo" 
```
