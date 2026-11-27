# Índice del paquete

## Datos territoriales

Funciones y tablas que entregan datos de uso territorial

- [`territorios`](https://bastianolea.github.io/territorial/reference/territorios.md)
  : Tabla de comunas, provincias y regiones de Chile
- [`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md)
  : Nombres de comunas de Chile
- [`codigos_comunas()`](https://bastianolea.github.io/territorial/reference/codigos_comunas.md)
  : Códigos de comunas de Chile
- [`regiones()`](https://bastianolea.github.io/territorial/reference/regiones.md)
  : Nombres de regiones de Chile
- [`provincias()`](https://bastianolea.github.io/territorial/reference/provincias.md)
  : Nombres de provincias de Chile
- [`localidades`](https://bastianolea.github.io/territorial/reference/localidades.md)
  : Tabla de localidades de Chile
- [`clasificacion`](https://bastianolea.github.io/territorial/reference/clasificacion.md)
  : Tabla de clasificación comunal PNDR, Censo 2024
- [`capitales_regionales()`](https://bastianolea.github.io/territorial/reference/capitales_regionales.md)
  : Capitales regionales de Chile
- [`cut_historicos`](https://bastianolea.github.io/territorial/reference/cut_historicos.md)
  : Códigos únicos territoriales históricos

## Validación de datos territoriales

Funciones que permiten probar la calidad de los datos territoriales

- [`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md)
  : Validación de calidad de nombres de comunas de Chile
- [`validar_regiones()`](https://bastianolea.github.io/territorial/reference/validar_regiones.md)
  : Validación de calidad de nombres de regiones de Chile
- [`contar_comunas()`](https://bastianolea.github.io/territorial/reference/contar_comunas.md)
  : Conteo de comunas disponibles, indicando las faltantes
- [`is_capital_regional()`](https://bastianolea.github.io/territorial/reference/is_capital_regional.md)
  : Evaluar si una comuna corresponde a una capital regional
- [`is_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/is_codigo_comuna.md)
  : Evaluar si un dato corresponde a un código territorial válido de una
  comuna de Chile
- [`is_codigo_comuna_antiguo()`](https://bastianolea.github.io/territorial/reference/is_codigo_comuna_antiguo.md)
  : Evaluar si un código único territorial comunal es antiguo o
  desactualizado
- [`is_codigo_region()`](https://bastianolea.github.io/territorial/reference/is_codigo_region.md)
  : Evaluar si un dato corresponde a un código de región de Chile válido
- [`is_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/is_nombre_comuna.md)
  : Evaluar si un texto corresponde al nombre válido de una comuna de
  Chile
- [`is_nombre_region()`](https://bastianolea.github.io/territorial/reference/is_nombre_region.md)
  : Evaluar si un texto corresponde a un nombre de región de Chile
  válido
- [`is_rural()`](https://bastianolea.github.io/territorial/reference/is_rural.md)
  : Evaluar si una comuna es rural

## Limpieza y corrección de territorios

Funciones para transformar datos de identificación de territorios,
ordenarlos, etc.

- [`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
  : Limpieza de nombres de comunas de Chile a sus nombres oficiales
- [`limpiar_regiones()`](https://bastianolea.github.io/territorial/reference/limpiar_regiones.md)
  : Limpieza de nombres de regiones de Chile a sus nombres oficiales
- [`as_capital_regional()`](https://bastianolea.github.io/territorial/reference/as_capital_regional.md)
  : Convertir regiones a capitales regionales
- [`as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md)
  : Convertir nombres de comunas a códigos comunales
- [`as_codigo_provincia()`](https://bastianolea.github.io/territorial/reference/as_codigo_provincia.md)
  : Convertir nombres de provincias a códigos de provincia
- [`as_codigo_region()`](https://bastianolea.github.io/territorial/reference/as_codigo_region.md)
  : Convertir nombres de regiones a códigos regionales
- [`as_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/as_nombre_comuna.md)
  : Convertir códigos comunales a nombres de comunas
- [`as_nombre_provincia()`](https://bastianolea.github.io/territorial/reference/as_nombre_provincia.md)
  : Convertir códigos de provincia a nombres de provincias
- [`as_nombre_region()`](https://bastianolea.github.io/territorial/reference/as_nombre_region.md)
  : Convertir códigos regionales a nombres de regiones
- [`ordenar_regiones()`](https://bastianolea.github.io/territorial/reference/ordenar_regiones.md)
  : Ordenar regiones de Chile geográficamente
- [`ubicar_comunas()`](https://bastianolea.github.io/territorial/reference/ubicar_comunas.md)
  : Ubicar comunas en la región o provincia que les corresponde
- [`ubicar_localidades()`](https://bastianolea.github.io/territorial/reference/ubicar_localidades.md)
  : Ubicar localidades en la comuna que les corresponde
- [`ubicar_provincias()`](https://bastianolea.github.io/territorial/reference/ubicar_provincias.md)
  : Ubicar provincias en la región que les corresponde
- [`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md)
  : Contextualizar datos de nivel comunal con variables territoriales
- [`actualizar_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/actualizar_codigo_comuna.md)
  : Actualizar códigos únicos territoriales comunales antiguos o
  desactualizados

## Complementar nombres de territorios

Funciones que toman los nombres de territorios y hacen más cosas con
ellos

- [`redactar_comunas()`](https://bastianolea.github.io/territorial/reference/redactar_comunas.md)
  : Redactar una secuencia de comunas en una oración
- [`redactar_region()`](https://bastianolea.github.io/territorial/reference/redactar_region.md)
  : Redactar nombres de regiones de Chile
- [`abreviar_comunas()`](https://bastianolea.github.io/territorial/reference/abreviar_comunas.md)
  : Crear abreviaciones de 3 letras desde nombres comunas
- [`acortar_regiones()`](https://bastianolea.github.io/territorial/reference/acortar_regiones.md)
  : Acortar nombres de las regiones de Chile
- [`preposicion_region()`](https://bastianolea.github.io/territorial/reference/preposicion_region.md)
  : Preposición (de/del) de cada región de Chile

## Complementar datos territoriales

Funciones para agregar nuevas variables a partir de datos territoriales
existentes

- [`agregar_clasificacion()`](https://bastianolea.github.io/territorial/reference/agregar_clasificacion.md)
  : Agregar clasificación comunal PNDR a comunas
- [`agregar_macrozona()`](https://bastianolea.github.io/territorial/reference/agregar_macrozona.md)
  : Agregar macrozona del país a regiones
- [`agregar_orden_region()`](https://bastianolea.github.io/territorial/reference/agregar_orden_region.md)
  : Agregar orden geográfico (norte a sur) a códigos de regiones

## Consulta de datos territoriales

Funciones y utilidades para navegar datos territoriales

- [`buscar_comuna()`](https://bastianolea.github.io/territorial/reference/buscar_comuna.md)
  : Buscar comunas por similitud
- [`obtener_comunas()`](https://bastianolea.github.io/territorial/reference/obtener_comunas.md)
  : Obtener las comunas de una región de Chile

## Misceláneas

Otras funciones secundarias

- [`aplicacion()`](https://bastianolea.github.io/territorial/reference/aplicacion.md)
  :

  Uso interactivo del paquete `territorial`

- [`trivia()`](https://bastianolea.github.io/territorial/reference/trivia.md)
  : Jugar a una trivia de comunas, provincias y regiones de Chile
