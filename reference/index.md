# Índice del paquete

## Datos territoriales

Funciones que entregan datos de uso territorial

- [`territorios`](https://bastianolea.github.io/territorial/reference/territorios.md)
  : Tabla de comunas, provincias y regiones de Chile
- [`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md)
  : Nombres de comunas de Chile
- [`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md)
  : Contextualizar datos de nivel comunal con variables territoriales

## Evaluación de unidades territoriales

Funciones que permiten probar la calidad de los datos, o pueden ser
usados para lógica condicional

- [`is_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/is_codigo_comuna.md)
  : Evaluar si un texto corresponde a un código territorial válido de
  una comuna de Chile
- [`is_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/is_nombre_comuna.md)
  : Evaluar si un texto corresponde al nombre válido de una comuna de
  Chile

## Corrección y limpieza de comunas

Funciones para transformar datos de identificación de territorios,
ordenarlos, etc.

- [`as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md)
  : Convertir nombres de comunas a códigos comunales
- [`as_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/as_nombre_comuna.md)
  : Convertir códigos comunales a nombres de comunas
- [`ordenar_regiones()`](https://bastianolea.github.io/territorial/reference/ordenar_regiones.md)
  : Ordenar regiones de Chile geográficamente
