# Validación de calidad de nombres de comunas de Chile

Esta función recibe una columna con nombres de comunas de un dataframe
(idealmente `nombre_comuna`), o un vector con nombres de comunas, y
retorna una evaluación de posibles problemas con los nombres existentes.
Funciona tanto con un dataframe con una columna `nombre_comuna`, o un
vector que contenga los nombres de comunas a evaluar. La función
solamente retorna avisos cuando existan problemas, por lo que si todos
los datos son correctos, solo devolverá los datos tal cual.

## Uso

``` r
validar_comunas(datos, variable = NULL)
```

## Argumentos

- datos:

  Dataframe con una columna de nombre de comunas, o vector de nombres de
  comunas

- variable:

  Columna del dataframe con los nombres de comunas (se pasa sin
  comillas, p.ej. `comuna`)

## Valor

Dataframe o vector intacto pero en modo invisible, con mensajes de
diagnóstico si se encuentran problemas de calidad

## Ejemplos

``` r
validar_comunas(c("chiguayante", "la florida", "paine"))
#> ℹ Resumen: 3 casos de comunas que no conciden con comunas correctamente escritas (ver `territorial::comunas()`): chiguayante, la florida y paine
#> ! Minúsculas: 3 casos de comunas escritas en minúsculas: chiguayante, la florida y paine

territorial::territorios |>
  validar_comunas(nombre_comuna)
```
