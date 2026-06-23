# NA

## Pendientes

`is.comuna()`: poner error si no se entrega comuna

`is.comuna()`: poner error si no es caracter

editar vignettes/territorial.qmd

agregar github action de tests

subir a github pages

cambiar a español

escribir readme

crear ejemplos con datos reales

crear examples para cada función

hacer hex logo

tabla con formas alternativas de escribir comunas

ver guía de estilo para pensar nombres de funciones

cambiar tildes por ascii: stringi::stri_escape_unicode(“Lélàô”)

explicar leves modificaciones de tabla de territorios

[`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md):
qué pasa cuando es a nivel regional?

¿es un buen nombre?

buscar y limpiar datos de localidades

cambiar puntos por guiones bajos

[`validar_regiones()`](https://bastianolea.github.io/territorial/reference/validar_regiones.md)

arreglar: no se llaman artículos, sino preposiciones

hacer tests de
[`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md)

## Idea general

- geografía oficial
  - obtener
  - niveles de calidad
- división política administrativa
- excluir islas, antártica
- estadísticas básicas
  - población
  - superficie
  - coordenadas clave
    - municipios
    - localidades

## Funciones

Funciones con datos - \[x\] `territorios` = tabla con todos los datos
territoriales (comuna, region, provincia, clasificaciones) - \[ \]
cambiar a función o no???? - \[x\]
[`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md)
= retorna un vector con los nombres de comunas - \[ \] `localidades()` =
xxx - \[x\] `clasificacion` = clasificación territorial de odepa

Funciones de pruebas - \[x\]
[`is_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/is_nombre_comuna.md)
= revisa si el o los elementos son comunas; recibe nombres de comunas
limpios o CUT - \[x\]
[`is_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/is_codigo_comuna.md)
= revisa si el o los elementos son códigos de comunas válidos - \[ \]
`evaluar_comunas()` = revisa el nivel de suciedad de los datos - revisar
si la versión en minúscula/mayúscula es igual a la entregada - \[ \]
`is_isla()`/`is_continental()`? detectar comunas específicas con
características particulares - \[ \] `revisar_comunas()` cuántas comunas
únicas incluye, y si todas son válidas - función que compare si los
códigos comunales corresponden con los nombres de comuna existentes???

Funciones para corregir - \[ \] `limpiar_nombres_comunas()` = limpia
comunas y las deja estandarizadas - \[x\]
[`as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md)
= convierte nombre de comunas en CUT - \[ \] avisar si ninguno coincide
con warnings - \[x\]
[`as_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/as_nombre_comuna.md)
= convierte CUT a nombre de comunas - \[ \] `limpiar_regiones()` =
limpiar nombres de regiones - \[ \] `abreviar_regiones()` = cambiar
nombres de regiones a nombres cortos - \[ \]
[`abreviar_comunas()`](https://bastianolea.github.io/territorial/reference/abreviar_comunas.md)
= cambiar nombres de comunas a nombres cortos - \[ \] sacar desde
scraping electoral Servel - \[x\]
[`ordenar_regiones()`](https://bastianolea.github.io/territorial/reference/ordenar_regiones.md)
= ordenar regiones de norte a sur

Funciones de complementar datos Estas deberían aplicar distinto
dependiendo si se le entrega el CUT o el nombre? - \[ \]
`poblacion_comuna()` = agregar población de comunas - \[ \]
`superficie_comuna()` = agregar superficie - \[ \]
`coordenadas_municipio()` = agregar lat/long municipio - \[ \]
`ubicar_localidad()` = en qué comuna está una localidad - \[x\]
[`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md)
= agrega variables territoriales faltantes - \[x\]
[`agregar_clasificacion()`](https://bastianolea.github.io/territorial/reference/agregar_clasificacion.md)

Avanzado - tipo que combine nombre de comuna con código territorial -
columna territorio que sea una clase que contiene toda esa info

Ideas: - sugerir posibles match de comunas con búsqueda inexacta
(agrepl()?)
