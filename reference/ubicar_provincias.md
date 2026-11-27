# Ubicar provincias en la región que les corresponde

Entregando códigos provinciales (como los que aparecen en
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md))
o nombres de provincias (que serán convertidos a códigos provinciales
con
[`as_codigo_provincia()`](https://bastianolea.github.io/territorial/reference/as_codigo_provincia.md)),
retorna los nombres de las regiones donde se ubican dichas provincias.
Retorna NA si no corresponde con ninguna.

## Uso

``` r
ubicar_provincias(codigo_provincia)
```

## Argumentos

- codigo_provincia:

  Códigos provinciales en formato numérico, o nombres de provincias
  (como en
  [`provincias()`](https://bastianolea.github.io/territorial/reference/provincias.md))

## Valor

Vector con nombres de regiones correspondientes

## Ver también

[`as_codigo_provincia()`](https://bastianolea.github.io/territorial/reference/as_codigo_provincia.md)
para convertir nombres de provincias a códigos,
[`as_nombre_provincia()`](https://bastianolea.github.io/territorial/reference/as_nombre_provincia.md)
para la operación inversa, y
[`ubicar_comunas()`](https://bastianolea.github.io/territorial/reference/ubicar_comunas.md)
para ubicar comunas en su región o provincia.

## Ejemplos

``` r
ubicar_provincias(c("Iquique", "Santiago"))
#> [1] "Tarapacá"                  "Metropolitana de Santiago"
```
