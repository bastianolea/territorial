
## Pendientes
- [ ] `is.comuna()`: error si no se entrega comuna
- [ ] hacer hex logo

evaluar calidad de comunas 
tabla con formas alternativas de escribir

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
- [x] `territorios()` = tabla con todos los datos territoriales (comuna, region, provincia, clasificaciones)
  - [ ] cambiar a función o no????
- [x] `comunas()` = retorna un vector con los nombres de comunas
- [ ] `localidades()` = xxx
- [ ] `clasificacion()` = clasificación comunal de odepa

Funciones de pruebas 
- [x] `is.comuna()` = revisa si el o los elementos son comunas; recibe nombres de comunas limpios o CUT
- [ ] `is.codigo_comuna()` = revisa si el o los elementos son códigos de comunas válidos
- [ ] `evaluar_comunas()` = revisa el nivel de suciedad de los datos
  - revisar si la versión en minúscula/mayúscula es igual a la entregada
- [ ] `is.isla()`/`is.continental()`? detectar comunas específicas con características particulares

Funciones para corregir
- [ ] `limpiar_comunas()` = limpia comunas y las deja estandarizadas
- [ ] `as.codigo_comuna()` = convierte nombre de comunas en CUT
- [ ] `limpiar_regiones()` = limpiar nombres de regiones 
- [ ] `abreviar_regiones()` = cambiar nombres de regiones a nombres cortos
- [x] `ordenar_regiones()` = ordenar regiones de norte a sur

Funciones de complementar datos
Estas deberían aplicar distinto dependiendo si se le entrega el CUT o el nombre?
- [ ] `poblacion_comuna()` = agregar población de comunas
- [ ] `superficie_comuna()` = agregar superficie
- [ ] `coordenadas_municipio()` = agregar lat/long municipio
- [ ] `ubicar_localidad()` = en qué comuna está una localidad
- [ ] complementar comunas con metadatos (región, provincia) (no sería un left join?)

Avanzado
- tipo que combine nombre de comuna con código comunal
- columna territorio que sea una clase que contiene toda esa info
