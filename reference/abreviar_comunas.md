# Crear abreviaciones de 3 letras desde nombres comunas

A partir de un vector de nombres de comunas (como
[`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md)),
retorna nombres de comunas abreviados, como siglas de 3 caracteres (a
excepción de Santiago, que queda STGO). Sirve para poner nombres de
comunas donde hay poco espacio, como en mapas. Las abreviaciones no
necesariamente son únicas.

## Uso

``` r
abreviar_comunas(nombre_comuna)
```

## Argumentos

- nombre_comuna:

  Vector de nombres de comunas, como
  [`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md)

## Valor

Vector con siglas de comunas de tres o cuatro caracteres

## Detalles

Las siglas se construyen con las tres primeras letras de las comunas con
nombres de una palabra, y en las comuna de dos o más palabras con la
primera letra de la primera palabra y las dos primeras letras de la
segunda palabra. Se ajustan algunos casos, como eliminar símbolos (como
en O'Higgins), y sacar la "u" de las comunas que empiezan con "Que" para
reducir coincidencias de abreviaciones.

## Ejemplos

``` r
abreviar_comunas(c("Cerrillos", "La Florida", "Quellón"))
#> [1] "CER" "LFL" "QEL"
```
