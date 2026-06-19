# Convertir nombres de comunas a códigos comunales

Entregando nombres de comuna correctos (como los que aparecen en
[`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md)
o en
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md)),
retorna los códigos de comuna correspondientes en formato numérico.
Retorna NA si no corresponde con ninguna.

## Usage

``` r
as.codigo_comuna(nombres_comunas)
```

## Arguments

- nombres_comunas:

  Nombres de comuna (como los que aparecen en
  [`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md))

## Value

Vector numérico con códigos de comuna
