# Índice del paquete

## Datos territoriales

Funciones que entregan datos de uso territorial

- [`territorios`](https://bastianolea.github.io/territorial/reference/territorios.md)
  : Tabla de comunas, provincias y regiones de Chile
- [`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md)
  : Nombres de comunas de Chile
- [`regiones()`](https://bastianolea.github.io/territorial/reference/regiones.md)
  : Nombres de regiones de Chile
- [`clasificacion`](https://bastianolea.github.io/territorial/reference/clasificacion.md)
  : Tabla de clasificación comunal PNDR, Censo 2024
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
- [`validar_regiones()`](https://bastianolea.github.io/territorial/reference/validar_regiones.md)
  : Validación de calidad de nombres de regiones de Chile

## Corrección y limpieza de territorios

Funciones para transformar datos de identificación de territorios,
ordenarlos, etc.

- [`as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md)
  : Convertir nombres de comunas a códigos comunales
- [`as_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/as_nombre_comuna.md)
  : Convertir códigos comunales a nombres de comunas
- [`ordenar_regiones()`](https://bastianolea.github.io/territorial/reference/ordenar_regiones.md)
  : Ordenar regiones de Chile geográficamente

## Complementar nombres de territorios

Funciones que toman los nombres de territorios y hacen más cosas con
ellos

- [`articulo_region()`](https://bastianolea.github.io/territorial/reference/articulo_region.md)
  : Artículos (de/del) de cada región de Chile
- [`redactar_region()`](https://bastianolea.github.io/territorial/reference/redactar_region.md)
  : Redactar nombres de regiones de Chile

## Complementar datos territoriales

Funciones para agregar nuevas variables a partir de datos territoriales
existentes

- [`agregar_clasificacion()`](https://bastianolea.github.io/territorial/reference/agregar_clasificacion.md)
  : Agregar clasificación comunal PNDR a comunas
