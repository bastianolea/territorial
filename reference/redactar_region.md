# Redactar nombres de regiones de Chile

A partir de los nombres de regiones de Chile (como aparecen en
[`regiones()`](https://bastianolea.github.io/territorial/reference/regiones.md)),
retorna la redacción de los nombres incluyendo "Región de/del"; por
ejemplo, "Maule" se vuelve en "Región del Maule".

## Uso

``` r
redactar_region(nombre_region)
```

## Argumentos

- nombre_region:

  Nombres de región, como aparecen en
  [`regiones()`](https://bastianolea.github.io/territorial/reference/regiones.md)

## Valor

Vector de nombres de región redactados, incluyendo la palabra "Región",
y la preposición apropiada ('de' o 'del', según
[`preposicion_region()`](https://bastianolea.github.io/territorial/reference/preposicion_region.md))
para cada nombre de región.

## Ejemplos

``` r
redactar_region("Maule")
#> [1] "Región del Maule"
```
