# Convertir códigos regionales a nombres de regiones

Entregando códigos regionales (como los que aparecen en
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md)),
retorna los nombres de región correspondientes. Retorna NA si no
corresponde con ninguna.

## Uso

``` r
as_nombre_region(codigos_regiones)
```

## Argumentos

- codigos_regiones:

  Códigos regionales en formato numérico

## Valor

Vector con nombres de región

## Ejemplos

``` r
as_nombre_region(16)
#> [1] "Ñuble"

as_nombre_region(c(15, 4, 10, 99))
#> Warning: Algunos códigos regionales no pudieron convertirse a nombres de regiones: 99
#> [1] "Arica y Parinacota" "Coquimbo"           "Los Lagos"         
#> [4] NA                  
```
