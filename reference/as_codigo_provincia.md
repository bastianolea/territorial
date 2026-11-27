# Convertir nombres de provincias a códigos de provincia

Entregando nombres de provincia correctos (como los que aparecen en
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md)),
retorna los códigos de provincia correspondientes en formato numérico.
Retorna NA si no corresponde con ninguna. El prefijo "Provincia de" es
ignorado, por lo que "Provincia de Iquique" y "Iquique" entregan el
mismo código.

## Uso

``` r
as_codigo_provincia(nombre_provincia)
```

## Argumentos

- nombre_provincia:

  Nombres de provincia (como los que aparecen en
  [territorios](https://bastianolea.github.io/territorial/reference/territorios.md))
  en formato caracter.

## Valor

Vector numérico con códigos de provincia.

## Detalles

Para más información sobre los códigos únicos territoriales, revisa la
viñeta
[`vignette("codigos_unicos_territoriales")`](https://bastianolea.github.io/territorial/articles/codigos_unicos_territoriales.md)

## Ver también

[`provincias()`](https://bastianolea.github.io/territorial/reference/provincias.md)
para un vector de los nombres de provincias,
[`as_nombre_provincia()`](https://bastianolea.github.io/territorial/reference/as_nombre_provincia.md)
para la conversión inversa, y
[`as_codigo_region()`](https://bastianolea.github.io/territorial/reference/as_codigo_region.md)
para convertir nombres de regiones.

## Ejemplos

``` r
as_codigo_provincia("Iquique")
#> [1] 11

as_codigo_provincia(c("Provincia de Copiapó", "Arica", "Nombre inventado"))
#> Warning: Algunos nombres de provincias no fueron reconocidos correctamente: Nombre
#> inventado
#> [1]  31 151  NA
```
