


is.comuna
- [ ] error si no se entrega comuna




evaluar calidad de comunas 
tabla con formas alternativas de escribir


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

Funciones con datos
- territorios() = tabla con todos los datos territoriales (comuna, region, provincia, clasificaciones)
  - cambiar a función o no????
- comunas() = retorna un vector con los nombres de comunas
- localidades = xxx
- clasificacion = clasificación comunal de odepa

Funciones de pruebas 
- is.comuna() = revisa si el o los elementos son comunas; recibe nombres de comunas limpios o CUT
- evaluar_comunas() = revisa el nivel de suciedad de los datos
  - si la versión en minúscula/mayúscula es igual a la entregada
- is.isla()/is.continental()? detectar comunas específicas con características particulares


Funciones para corregir
- limpiar_comunas() = limpia comunas y las deja estandarizadas
- as.codigo_comuna()? = convierte nombre de comunas en CUT
- limpiar nombres de regiones a nombres cortos
- ordenar_regiones() = ordenar regiones de norte a sur

Funciones de complementar datos
- agregar población de comunas
- complementar comunas con metadatos (región, provincia)
- ubicar_localidad() = en qué comuna está una localidad

Avanzado
- tipo que combine nombre de comuna con código comunal
- columna territorio que sea una clase que contiene toda esa info
