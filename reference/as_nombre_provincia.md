# Convertir códigos de provincia a nombres de provincias

Entregando códigos de provincia (como los que aparecen en
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md)),
retorna los nombres de provincias correspondientes. Retorna NA si no
corresponde con ninguna.

## Uso

``` r
as_nombre_provincia(codigo_provincia)
```

## Argumentos

- codigo_provincia:

  Códigos provinciales en formato numérico

## Valor

Vector con nombres de provincia

## Ver también

[`as_codigo_provincia()`](https://bastianolea.github.io/territorial/reference/as_codigo_provincia.md)
para la conversión inversa.

## Ejemplos

``` r
as_nombre_provincia(11)
#> [1] "Iquique"

as_nombre_provincia(c(11, 71, 73, 99))
#> Warning: Algunos códigos de provincia no pudieron convertirse a nombres de provincia: 99
#> [1] "Iquique" "Talca"   "Curicó"  NA       
```
