# Preposición (de/del) de cada región de Chile

Esta función entrega la preposición usada para cada región de Chile; por
ejemplo, Valparaíso es la "Región *de* Valparaíso", pero Maule es la
"Región *del* Maule".

## Uso

``` r
preposicion_region(nombre_region)
```

## Argumentos

- nombre_region:

  Nombres de región, como aparecen en
  [`regiones()`](https://bastianolea.github.io/territorial/reference/regiones.md)

## Valor

Vector de preposiciones para cada nombre de región. Retorna NA si no se
detecta la región.

## Ver también

[`redactar_region()`](https://bastianolea.github.io/territorial/reference/redactar_region.md)
para redactar el nombre completo de la región ("Región del Maule").

## Ejemplos

``` r
preposicion_region("Ñuble")
#> [1] "de"

preposicion_region("O'Higgins")
#> [1] "de"
```
