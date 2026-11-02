# Validación de calidad de nombres de comunas de Chile

Esta función recibe una variable con nombres de comunas de un dataframe,
o un vector con nombres de comunas, y retorna una evaluación de posibles
problemas con los nombres existentes.

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

## Detalles

Funciona tanto con un dataframe (si la columna se llama `nombre_comuna`
no es necesario especificarla), o un vector que contenga los nombres de
comunas a evaluar. La función solamente retorna avisos cuando existan
problemas, y retorna los datos de manera invisible.

## Ver también

[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
para corregir automáticamente los problemas detectados, y
[`contar_comunas()`](https://bastianolea.github.io/territorial/reference/contar_comunas.md)
para revisar si faltan comunas en los datos. Para regiones, usa
[`validar_regiones()`](https://bastianolea.github.io/territorial/reference/validar_regiones.md).

## Ejemplos

``` r
validar_comunas(c("chiguayante", "la florida", "paine"))
#> ! Resumen: 3 casos de comunas que no conciden con comunas correctamente escritas (ver `territorial::comunas()`): chiguayante, la florida y paine
#> ! Minúsculas: 3 casos de comunas escritas en minúsculas: chiguayante, la florida y paine
#> ✖ Validación de comunas: se encontraron 6 problemas con las comunas! Usa `territorial::limpiar_comunas()` para solucionarlos.

territorios |>
  validar_comunas(nombre_comuna)
#> ✔ Todas las comunas están correctas!

# si ya existe una columna `nombre_comuna`, puede omitirse el argumento
territorios |>
  validar_comunas()
#> ✔ Todas las comunas están correctas!
```
