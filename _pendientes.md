
## Pendientes
- [ ] `is_comuna()`: poner error si no se entrega comuna
- [ ] `is_comuna()`: poner error si no es caracter
- [x] editar vignettes/territorial.qmd
- [-] agregar github action de tests (no porque webea el warning)
- [x] subir a github pages
  - [x] cambiar a español
- [x] escribir readme
- [x] crear ejemplos con datos reales
- [x] crear examples para cada función
- [x] hacer hex logo
- [x] tabla con formas alternativas de escribir comunas
- [ ] ver guía de estilo para pensar nombres de funciones
- [-] cambiar tildes por ascii: stringi::stri_escape_unicode("Lélàô ")
- [x] explicar leves modificaciones de tabla de territorios
- [ ] `contextualizar()`: qué pasa cuando es a nivel regional?
  - [ ] ¿es un buen nombre?
- [x] buscar y limpiar datos de localidades
- [x] cambiar puntos por guiones bajos
- [x] `validar_regiones()`
- [x] arreglar: no se llaman artículos, sino preposiciones
- [x] hacer tests de `validar_comunas()`
- [x] función para averiguar en qué región está una comuna
- [ ] qué pasa en is_nombre_region con los nombres cortos de regiones?
- [ ] convertir a nombres cortos de regiones 



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

Funciones con datos
- [x] `territorios` = tabla con todos los datos territoriales (comuna, region, provincia, clasificaciones)
  - [ ] cambiar a función o no????
- [x] `comunas()` = retorna un vector con los nombres de comunas
- [ ] `localidades()` = xxx
- [x] `clasificacion` = clasificación territorial de odepa

Funciones de pruebas 
- [x] `is_nombre_comuna()` = revisa si el o los elementos son comunas; recibe nombres de comunas limpios o CUT
- [x] `is_codigo_comuna()` = revisa si el o los elementos son códigos de comunas válidos
- [ ] `evaluar_comunas()` = revisa el nivel de suciedad de los datos
  - revisar si la versión en minúscula/mayúscula es igual a la entregada
- [ ] `is_isla()`/`is_continental()`? detectar comunas específicas con características particulares
- [ ] `revisar_comunas()` cuántas comunas únicas incluye, y si todas son válidas
- función que compare si los códigos comunales corresponden con los nombres de comuna existentes???

Funciones para corregir
- [ ] `limpiar_nombres_comunas()` = limpia comunas y las deja estandarizadas
- [x] `as_codigo_comuna()` = convierte nombre de comunas en CUT
  - [ ] avisar si ninguno coincide con warnings
- [x] `as_nombre_comuna()` = convierte CUT a nombre de comunas
- [ ] `limpiar_regiones()` = limpiar nombres de regiones 
- [ ] `abreviar_regiones()` = cambiar nombres de regiones a nombres cortos
- [ ] `abreviar_comunas()` = cambiar nombres de comunas a nombres cortos
  - [ ] sacar desde scraping electoral Servel
- [x] `ordenar_regiones()` = ordenar regiones de norte a sur

Funciones de complementar datos
Estas deberían aplicar distinto dependiendo si se le entrega el CUT o el nombre?
- [ ] `poblacion_comuna()` = agregar población de comunas
- [ ] `superficie_comuna()` = agregar superficie
- [ ] `coordenadas_municipio()` = agregar lat/long municipio
- [ ] `ubicar_localidad()` = en qué comuna está una localidad
- [x] `contextualizar()` = agrega variables territoriales faltantes
- [x] `agregar_clasificacion()`

Avanzado
- tipo que combine nombre de comuna con código territorial
- columna territorio que sea una clase que contiene toda esa info


Ideas: 
- sugerir posibles match de comunas con búsqueda inexacta (agrepl()?)
