# Ubicar comunas en la región que les corresponde

Entregando códigos comunales (como los que aparecen en
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md))
o nombres de comunas, retorna los nombres de las regiones donde se
ubican dichas comunas. Retorna NA si no corresponde con ninguna.

## Uso

``` r
ubicar_comunas(codigo_comuna)
```

## Argumentos

- codigo_comuna:

  Códigos comunales en formato numérico, o nombres de comunas (como en
  [`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md))

## Valor

Vector con nombres de regiones correspondientes

## Ver también

[`obtener_comunas()`](https://bastianolea.github.io/territorial/reference/obtener_comunas.md)
para hacer lo inverso,
[`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md)
para agregar región, provincia y códigos a una tabla, y
[`ubicar_localidades()`](https://bastianolea.github.io/territorial/reference/ubicar_localidades.md)
para territorios más pequeños que una comuna.

## Ejemplos

``` r
ubicar_comunas(c("Cerrillos", "Navidad"))
#> [1] "Metropolitana de Santiago"            
#> [2] "Libertador General Bernardo O'Higgins"

ubicar_comunas(c(1101, 13103))
#> [1] "Tarapacá"                  "Metropolitana de Santiago"
```
