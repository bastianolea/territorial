# Convertir códigos comunales a nombres de comunas

Entregando códigos comunales (como los que aparecen en
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md)),
retorna los nombres de comuna correspondientes. Retorna NA si no
corresponde con ninguna.

## Uso

``` r
as_nombre_comuna(codigos_comunas)
```

## Argumentos

- codigos_comunas:

  Códigos comunales en formato numérico

## Valor

Vector con nombres de comuna

## Ejemplos

``` r
as_nombre_comuna(1101)
#> [1] "Iquique"

as_nombre_comuna(c(1401, 1403, 9999, 1404))
#> Warning: Algunos códigos comunales no pudieron convertirse a nombres de comunas: 9999
#> [1] "Pozo Almonte" "Colchane"     NA             "Huara"       
```
