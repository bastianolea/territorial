# Obtener las comunas de una región de Chile

Entregando un nombre de región o un código de región, retorna un vector
con los nombres de las comunas correspondientes.

## Uso

``` r
obtener_comunas(nombre_region = NULL, codigo_region = NULL)
```

## Argumentos

- nombre_region:

  Uno o más nombres de región, como aparecen en
  [`regiones()`](https://bastianolea.github.io/territorial/reference/regiones.md)

- codigo_region:

  Uno o más códigos de región, como aparecen en
  [territorios](https://bastianolea.github.io/territorial/reference/territorios.md)

## Valor

Vector de comunas de la región o regiones

## Ver también

[`ubicar_comunas()`](https://bastianolea.github.io/territorial/reference/ubicar_comunas.md)
para hacer lo inverso (obtener la región de una comuna), y
[`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md)
o
[`regiones()`](https://bastianolea.github.io/territorial/reference/regiones.md)
para vectores con todas las comunas o regiones del país.

## Ejemplos

``` r
obtener_comunas("Tarapacá")
#> ℹ Comunas de la región: Iquique, Alto Hospicio, Pozo Almonte, Camiña, Colchane, Huara y Pica
#> [1] "Iquique"       "Alto Hospicio" "Pozo Almonte"  "Camiña"       
#> [5] "Colchane"      "Huara"         "Pica"         
```
