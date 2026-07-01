# Validación de calidad de nombres de regiones de Chile

Esta función recibe la columna con nombres de regiones de un dataframe
(idealmente `nombre_region`), y retorna una evaluación de posibles
problemas con los nombres existentes. Funciona tanto con un dataframe
con una columna `nombre_region`, o un vector que contenga los nombres de
regiones a evaluar. La función solamente retorna avisos cuando existan
problemas, por lo que si todos los datos son correctos, solo devolverá
los datos tal cual.

## Uso

``` r
validar_regiones(datos, variable = NULL)
```

## Argumentos

- datos:

  Dataframe con una columna de nombre de regiones, o vector de nombres
  de regiones

- variable:

  Columna del dataframe con los nombres de regiones (se pasa sin
  comillas, p.ej. `region`)

## Valor

Dataframe o vector intacto pero en modo invisible, con mensajes de
diagnóstico si se encuentran problemas de calidad

## Ejemplos

``` r
validar_regiones(c("los lagos", "nuble", "OHIGGINS"))
#> ! Mayúsculas: 1 caso de regiones escritas en mayúsculas
#> ! Mayúsculas: 2 casos de regiones escritas en minúsculas
#> ! Ortografía: 1 caso de la Región de Ñuble escrita sin eñe
#> ! Ortografía: 1 caso de la Región de O'Higgins escrita sin su apóstrofo (')
#> ✖ Validación de regiones: se encontraron 5 problemas con las regiones!

territorial::territorios |>
  validar_regiones(nombre_region)
#> ✔ Todas las regiones están correctas!
```
