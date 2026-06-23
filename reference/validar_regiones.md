# Validación de calidad de nombres de regiones de Chile

Esta función recibe la columna con nombres de regiones de un dataframe
(idealmente `nombre_region`), y retorna una evaluación de posibles
problemas con los nombres existentes. Funciona tanto con un dataframe
con una columna `nombre_region`, o un vector que contenga los nombres de
regiones a evaluar.

## Uso

``` r
validar_regiones(datos, variable = "nombre_region")
```

## Argumentos

- nombre_region:

  Columna con nombres de regiones, o vector con nombres de regiones

## Valor

Dataframe o vector intacto, con mensajes de diagnóstico si se encuentran
problemas de calidad

## Ejemplos

``` r
validar_regiones(c("los lagos", "nuble", "OHIGGINS"))
#> ! mayúsculas: 1 caso de regiones escritas en mayúsculas
#> ! mayúsculas: 2 casos de regiones escritas en minúsculas
#> ! ortografía: 1 caso de la Región de Ñuble escrita sin eñe
#> ! ortografía: 1 caso de la Región de O'Higgins escrita sin su apóstrofo (')
#> [1] "los lagos" "nuble"     "OHIGGINS" 
```
