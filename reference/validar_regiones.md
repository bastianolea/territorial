# Validación de calidad de nombres de regiones de Chile

Esta función recibe la columna con nombres de regiones de un dataframe
(idealmente `nombre_region`), y retorna una evaluación de posibles
problemas con los nombres existentes.

## Uso

``` r
validar_regiones(nombre_region)
```

## Argumentos

- nombre_region:

  Columna con nombres de regiones

## Valor

Dataframe intacto, mensajes de diagnóstico
