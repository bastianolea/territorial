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
y el artículo apropiado (de o del, según
[`articulo_region()`](https://bastianolea.github.io/territorial/reference/articulo_region.md))
para cada nombre de región.

## Ejemplos

``` r
redactar_region("Maule")
#> Error in loadNamespace(x): no hay paquete llamado ‘stringr’
```
