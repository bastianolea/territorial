# Índice del paquete

## Datos territoriales

Funciones y tablas de datos que entregan datos de uso territorial

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
- [`localidades`](https://bastianolea.github.io/territorial/reference/localidades.md)
  : Tabla de localidades de Chile

## Evaluación de unidades territoriales

Funciones que permiten probar la calidad de los datos, o pueden ser
usados para lógica condicional

- [`is_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/is_codigo_comuna.md)
  : Evaluar si un dato corresponde a un código territorial válido de una
  comuna de Chile
- [`is_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/is_nombre_comuna.md)
  : Evaluar si un texto corresponde al nombre válido de una comuna de
  Chile
- [`is_nombre_region()`](https://bastianolea.github.io/territorial/reference/is_nombre_region.md)
  : Evaluar si un texto corresponde a un nombre de región de Chile
  válido
- [`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md)
  : Validación de calidad de nombres de comunas de Chile
- [`validar_regiones()`](https://bastianolea.github.io/territorial/reference/validar_regiones.md)
  : Validación de calidad de nombres de regiones de Chile

## Limpieza y corrección de territorios

Funciones para transformar datos de identificación de territorios,
ordenarlos, etc.

- [`as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md)
  : Convertir nombres de comunas a códigos comunales
- [`as_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/as_nombre_comuna.md)
  : Convertir códigos comunales a nombres de comunas
- [`ordenar_regiones()`](https://bastianolea.github.io/territorial/reference/ordenar_regiones.md)
  : Ordenar regiones de Chile geográficamente
- [`ubicar_comunas()`](https://bastianolea.github.io/territorial/reference/ubicar_comunas.md)
  : Ubicar comunas en la región que les corresponde
- [`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
  : Limpieza de nombres de comunas de Chile a sus nombres oficiales

## Complementar nombres de territorios

Funciones que toman los nombres de territorios y hacen más cosas con
ellos

- [`preposicion_region()`](https://bastianolea.github.io/territorial/reference/preposicion_region.md)
  : Preposición (de/del) de cada región de Chile
- [`redactar_comunas()`](https://bastianolea.github.io/territorial/reference/redactar_comunas.md)
  : Redactar una secuencia de comunas en una oración
- [`redactar_region()`](https://bastianolea.github.io/territorial/reference/redactar_region.md)
  : Redactar nombres de regiones de Chile
- [`abreviar_comunas()`](https://bastianolea.github.io/territorial/reference/abreviar_comunas.md)
  : Crear abreviaciones de 3 letras desde nombres comunas

## Complementar datos territoriales

Funciones para agregar nuevas variables a partir de datos territoriales
existentes

- [`agregar_clasificacion()`](https://bastianolea.github.io/territorial/reference/agregar_clasificacion.md)
  : Agregar clasificación comunal PNDR a comunas
- [`agregar_orden_region()`](https://bastianolea.github.io/territorial/reference/agregar_orden_region.md)
  : Agregar orden geográfico (norte a sur) a códigos de regiones
