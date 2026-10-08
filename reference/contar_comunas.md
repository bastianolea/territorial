# Conteo de comunas disponibles, indicando las faltantes

Revisa un vector o una tabla de datos (asumiendo la columna
`nombre_comuna`, o indicando una columna que contenga nombres de
comunas) e indica el conteo de comunas únicas, y emite mensajes
dependiendo de esta cantidad: si es correcta (345 o 346), si es menor
(indicando las que faltan) o si es mayor (recomendando validar con
[`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md)).

## Uso

``` r
contar_comunas(datos, variable = NULL, largo = 30)
```

## Argumentos

- datos:

  Dataframe con una columna de nombre de comunas, o vector de nombres de
  comunas

- variable:

  Columna del dataframe con los nombres de comunas (se pasa sin
  comillas, p.ej. `comuna`)

- largo:

  Si faltan comunas en los datos, enumera esta cantidad de comunas. Por
  defecto son 30, y el argumento se pasa a
  [`redactar_comunas()`](https://bastianolea.github.io/territorial/reference/redactar_comunas.md).

## Valor

Dataframe o vector intacto pero en modo invisible, con mensajes de
conteo de comunas

## Detalles

Sirve para revisar rápidamente que los datos abarquen todos los
territorios del país, o indicar si faltan algunos.

## Ejemplos

``` r
territorios |>
  dplyr::slice_sample(n = 300) |>
  contar_comunas()
#> ℹ Cantidad de comunas únicas: 300
#> ! La cantidad de comunas es anómala: hay 300, pero deberían ser 346. Revísalas con `territorial::validar_comunas()`
#> → Las comunas faltantes son: Iquique, Alto Hospicio, Mejillones, Paihuano, Ovalle, Monte Patria, Santo Domingo, Codegua, Coinco, Machalí, Marchihue, Chépica, Empedrado, San Rafael, Cauquenes, Chanco, Molina, Rauco, Longaví, Parral, Yerbas Buenas, Penco, Tomé, Contulmo, Gorbea, Toltén, Los Muermos, Quellón, Chaitén, Hualaihué y 16 comunas más
```
