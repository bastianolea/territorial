# Validación de calidad de nombres de comunas de Chile

Esta función recibe la columna con nombres de comunas de un dataframe
(idealmente `nombre_comuna`), y retorna una evaluación de posibles
problemas con los nombres existentes. Funciona tanto con un dataframe
con una columna `nombre_comuna`, o un vector que contenga los nombres de
comunas a evaluar.

## Uso

``` r
validar_comunas(datos, variable = "nombre_comuna")
```

## Argumentos

- nombre_comuna:

  Columna con nombres de comunas, o vector con nombres de comunas

## Valor

Dataframe o vector intacto, con mensajes de diagnóstico si se encuentran
problemas de calidad

## Ejemplos

``` r
validar_comunas(c("colliguay", "la florida", "paine"))
#> ! mayúsculas: 3 casos de comunas escritas en minúsculas
#> [1] "colliguay"  "la florida" "paine"     
```
