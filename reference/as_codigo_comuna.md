# Convertir nombres de comunas a códigos comunales

Entregando nombres de comuna correctos (como los que aparecen en
[`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md)
o en
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md)),
retorna los códigos de comuna correspondientes en formato numérico.
Retorna NA si no corresponde con ninguna.

## Uso

``` r
as_codigo_comuna(nombres_comunas)
```

## Argumentos

- nombres_comunas:

  Nombres de comuna (como los que aparecen en
  [`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md))

## Valor

Vector numérico con códigos de comuna
