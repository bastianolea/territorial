# NA

## Pendientes

limpiar regiones

revisar por qué en la viñeta de primeros pasos salen líneas vacías:
<https://bastianolea.github.io/territorial/articles/territorial.html#limpieza-de-nombres-de-comunas-de-chile>

acortar_regiones debería arrojar error con dataframe, o al menos aplicar
igual si existe la columna

## Ideas

`buscar_comunas()` con agrepl

pero debería poder aplicar a otras tablas

[`obtener_comunas()`](https://bastianolea.github.io/territorial/reference/obtener_comunas.md)
obtener comunas de la región, entregar como vector o redactada

clasificar regiones por zona (norte, centro, sur)

convertir códigos DEIS a comunas

[`contar_comunas()`](https://bastianolea.github.io/territorial/reference/contar_comunas.md)
= cuántas comunas únicas incluye, y si todas son válidas

`confirmar_comunas()` = comparar si los códigos comunales corresponden
con los nombres de comuna

## Cambios

Al final las mismas funciones ahora aplican igual a columnas o
vectores - \[-\] flexibilizar agregar_poblacion (sacar de aquí y pasar
al otro paquete)

crear un ejemplo de cómo aplicar funciones con mutate a un datafrme

check que sea dataframe

check que tenga la columna

check que la columna sea del tipo apropiado

check que tenga valores válidos del tipo apropiado

## Pendientes

\[-\] agregar población censo 2024

\[-\] agregar superficie total, urbana

ejemplos

agregar ejemplos de `agregar_poblacion()` a viñetas

agregar ejemplos de
[`as_nombre_region()`](https://bastianolea.github.io/territorial/reference/as_nombre_region.md)
y
[`as_codigo_region()`](https://bastianolea.github.io/territorial/reference/as_codigo_region.md)
a viñetas

agregar ejemplos de
[`agregar_macrozona()`](https://bastianolea.github.io/territorial/reference/agregar_macrozona.md)
a viñetas

crear viñeta de
[`agregar_macrozona()`](https://bastianolea.github.io/territorial/reference/agregar_macrozona.md)?

al convertir comuna a código territorial, si no se encuentra la comuna,
limpiar con warning

al ubicar comuna en la región, si no se encuentra la comuna, limpiar con
warning

función para convertir a nombres cortos de regiones

qué pasa en is_nombre_region con los nombres cortos de regiones?

[`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md):
qué pasa cuando es a nivel regional?

ver guía de estilo para pensar nombres de funciones

[`is_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/is_nombre_comuna.md):
poner error si no es caracter

editar vignettes/territorial.qmd

\[-\] agregar github action de tests (no porque webea el warning)

subir a github pages

cambiar pkgdown a español

escribir readme

crear ejemplos con datos reales

crear examples para cada función

hacer hex logo

tabla con formas alternativas de escribir comunas

cambiar tildes por ascii: stringi::stri_escape_unicode(“Lélàô”)

explicar leves modificaciones de tabla de territorios

buscar y limpiar datos de localidades

cambiar puntos por guiones bajos

[`validar_regiones()`](https://bastianolea.github.io/territorial/reference/validar_regiones.md)

arreglar: no se llaman artículos, sino preposiciones

hacer tests de
[`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md)

función para averiguar en qué región está una comuna

## Funciones

Funciones con datos - \[x\] `territorios` = tabla con todos los datos
territoriales (comuna, region, provincia, clasificaciones) - \[ \]
cambiar a función o no???? - \[x\]
[`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md)
= retorna un vector con los nombres de comunas - \[x\]
[`localidades()`](https://bastianolea.github.io/territorial/reference/localidades.md)
= xxx - \[x\] `clasificacion` = clasificación territorial de odepa

Funciones de pruebas - \[x\]
[`is_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/is_nombre_comuna.md)
= revisa si el o los elementos son comunas; recibe nombres de comunas
limpios o CUT - \[x\]
[`is_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/is_codigo_comuna.md)
= revisa si el o los elementos son códigos de comunas válidos - \[x\]
[`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md)
= revisa el nivel de suciedad de los datos - revisar si la versión en
minúscula/mayúscula es igual a la entregada - \[ \]
`is_isla()`/`is_continental()`? detectar comunas específicas con
características particulares - \[ \] `revisar_comunas()` cuántas comunas
únicas incluye, y si todas son válidas - \[ \] `confirmar_comunas()` =
función que compare si los códigos comunales corresponden con los
nombres de comuna existentes???

Funciones para corregir - \[x\]
[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
= limpia comunas y las deja estandarizadas - \[x\]
[`as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md)
= convierte nombre de comunas en CUT - \[x\] avisar si ninguno coincide
con warnings - \[x\]
[`as_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/as_nombre_comuna.md)
= convierte CUT a nombre de comunas - \[ \]
[`limpiar_regiones()`](https://bastianolea.github.io/territorial/reference/limpiar_regiones.md)
= limpiar nombres de regiones - \[ \] `abreviar_regiones()` = cambiar
nombres de regiones a nombres cortos - \[x\]
[`abreviar_comunas()`](https://bastianolea.github.io/territorial/reference/abreviar_comunas.md)
= cambiar nombres de comunas a nombres cortos - \[x\]
[`ordenar_regiones()`](https://bastianolea.github.io/territorial/reference/ordenar_regiones.md)
= ordenar regiones de norte a sur

Funciones de complementar datos Estas deberían aplicar distinto
dependiendo si se le entrega el CUT o el nombre? - \[-\]
`poblacion_comuna()` = agregar población de comunas - \[ \]
`superficie_comuna()` = agregar superficie - \[ \]
`coordenadas_municipio()` = agregar lat/long municipio - \[x\]
[`ubicar_localidades()`](https://bastianolea.github.io/territorial/reference/ubicar_localidades.md)
= en qué comuna está una localidad - \[x\]
[`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md)
= agrega variables territoriales faltantes - \[x\]
[`agregar_clasificacion()`](https://bastianolea.github.io/territorial/reference/agregar_clasificacion.md)
