## Pendientes
- [x] limpiar regiones
- [x] revisar por qué en la viñeta de primeros pasos salen líneas vacías: https://bastianolea.github.io/territorial/articles/territorial.html#limpieza-de-nombres-de-comunas-de-chile
- [x] acortar_regiones debería arrojar error con dataframe, o al menos aplicar igual si existe la columna
- [ ] función para convertir códigos únicos territoriales antiguos a actuales (Ñuble, Marga Marga)


## Ideas
- [x] `buscar_comunas()` con agrepl
  - [x] pero debería poder aplicar a otras tablas
- [x] `obtener_comunas()` obtener comunas de la región, entregar como vector o redactada 
- [x] clasificar regiones por zona (norte, centro, sur)
- [ ] convertir códigos DEIS a comunas
- [x] `contar_comunas()` = cuántas comunas únicas incluye, y si todas son válidas
- [ ] `confirmar_comunas()` = comparar si los códigos comunales corresponden con los nombres de comuna


## Cambios
Al final las mismas funciones ahora aplican igual a columnas o vectores
- [-] flexibilizar agregar_poblacion (sacar de aquí y pasar al otro paquete)

- [x] crear un ejemplo de cómo aplicar funciones con mutate a un datafrme
  - [x] check que sea dataframe
  - [x] check que tenga la columna
  - [x] check que la columna sea del tipo apropiado
  - [x] check que tenga valores válidos del tipo apropiado


## Pendientes
- [-] agregar población censo 2024
- [-] agregar superficie total, urbana
- [ ] ejemplos
  - [x] agregar ejemplos de `agregar_poblacion()` a viñetas
  - [x] agregar ejemplos de `as_nombre_region()` y `as_codigo_region()` a viñetas
  - [x] agregar ejemplos de `agregar_macrozona()` a viñetas
  - [x] crear viñeta de `agregar_macrozona()`?
- [x] al convertir comuna a código territorial, si no se encuentra la comuna, limpiar con warning
- [x] al ubicar comuna en la región, si no se encuentra la comuna, limpiar con warning
- [x] función para convertir a nombres cortos de regiones
- [ ] qué pasa en is_nombre_region con los nombres cortos de regiones?
- [ ] `contextualizar()`: qué pasa cuando es a nivel regional?
- [ ] ver guía de estilo para pensar nombres de funciones
- [x] `is_nombre_comuna()`: poner error si no es caracter
- [x] editar vignettes/territorial.qmd
- [-] agregar github action de tests (no porque webea el warning)
- [x] subir a github pages
- [x] cambiar pkgdown a español
- [x] escribir readme
- [x] crear ejemplos con datos reales
- [x] crear examples para cada función
- [x] hacer hex logo
- [x] tabla con formas alternativas de escribir comunas
- [x] cambiar tildes por ascii: stringi::stri_escape_unicode("Lélàô ")
- [x] explicar leves modificaciones de tabla de territorios
- [x] buscar y limpiar datos de localidades
- [x] cambiar puntos por guiones bajos
- [x] `validar_regiones()`
- [x] arreglar: no se llaman artículos, sino preposiciones
- [x] hacer tests de `validar_comunas()`
- [x] función para averiguar en qué región está una comuna

## Funciones 

Funciones con datos
- [x] `territorios` = tabla con todos los datos territoriales (comuna, region, provincia, clasificaciones)
  - [ ] cambiar a función o no????
- [x] `comunas()` = retorna un vector con los nombres de comunas
- [x] `localidades()` = xxx
- [x] `clasificacion` = clasificación territorial de odepa

Funciones de pruebas 
- [x] `is_nombre_comuna()` = revisa si el o los elementos son comunas; recibe nombres de comunas limpios o CUT
- [x] `is_codigo_comuna()` = revisa si el o los elementos son códigos de comunas válidos
- [x] `validar_comunas()` = revisa el nivel de suciedad de los datos
  - revisar si la versión en minúscula/mayúscula es igual a la entregada
- [ ] `is_isla()`/`is_continental()`? detectar comunas específicas con características particulares
- [ ] `revisar_comunas()` cuántas comunas únicas incluye, y si todas son válidas
- [ ] `confirmar_comunas()` = función que compare si los códigos comunales corresponden con los nombres de comuna existentes???

Funciones para corregir
- [x] `limpiar_comunas()` = limpia comunas y las deja estandarizadas
- [x] `as_codigo_comuna()` = convierte nombre de comunas en CUT
  - [x] avisar si ninguno coincide con warnings
- [x] `as_nombre_comuna()` = convierte CUT a nombre de comunas
- [ ] `limpiar_regiones()` = limpiar nombres de regiones 
- [ ] `abreviar_regiones()` = cambiar nombres de regiones a nombres cortos
- [x] `abreviar_comunas()` = cambiar nombres de comunas a nombres cortos
- [x] `ordenar_regiones()` = ordenar regiones de norte a sur

Funciones de complementar datos
Estas deberían aplicar distinto dependiendo si se le entrega el CUT o el nombre?
- [-] `poblacion_comuna()` = agregar población de comunas
- [ ] `superficie_comuna()` = agregar superficie
- [ ] `coordenadas_municipio()` = agregar lat/long municipio
- [x] `ubicar_localidades()` = en qué comuna está una localidad
- [x] `contextualizar()` = agrega variables territoriales faltantes
- [x] `agregar_clasificacion()`
