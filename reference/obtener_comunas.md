# Obtener las comunas de una región de Chile

Entregando uno o más códigos de región o nombres de región, retorna un
vector con los nombres de las comunas correspondientes.

## Uso

``` r
obtener_comunas(codigo_region)
```

## Argumentos

- codigo_region:

  Uno o más códigos de región en formato numérico (como aparecen en
  [territorios](https://bastianolea.github.io/territorial/reference/territorios.md)),
  o nombres de región (como en
  [`regiones()`](https://bastianolea.github.io/territorial/reference/regiones.md))
  en formato caracter o factor.

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

obtener_comunas(c(15, 1))
#> ℹ Comunas de la región: Iquique, Alto Hospicio, Pozo Almonte, Camiña, Colchane, Huara, Pica, Arica, Camarones, Putre y General Lagos
#>  [1] "Iquique"       "Alto Hospicio" "Pozo Almonte"  "Camiña"       
#>  [5] "Colchane"      "Huara"         "Pica"          "Arica"        
#>  [9] "Camarones"     "Putre"         "General Lagos"
```
