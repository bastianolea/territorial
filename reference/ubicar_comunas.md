# Ubicar comunas en la región o provincia que les corresponde

Entregando códigos comunales (como los que aparecen en
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md))
o nombres de comunas (que serán convertidos a códigos comunales con
[`as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md)),
retorna los nombres de las regiones o provincias (según el argumento
`nivel`) donde se ubican dichas comunas. Retorna NA si no corresponde
con ninguna.

## Uso

``` r
ubicar_comunas(codigo_comuna, nivel = "región")
```

## Argumentos

- codigo_comuna:

  Códigos comunales en formato numérico, o nombres de comunas (como en
  [`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md))

- nivel:

  Ubicar la/s comuna/s en su "región" (por defecto) o "provincia".

## Valor

Vector con nombres de regiones o provincias correspondientes

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

ubicar_comunas("Puente Alto", nivel = "provincia")
#> [1] "Cordillera"
```
