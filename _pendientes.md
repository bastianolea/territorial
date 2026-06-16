


is.comuna
- [ ] error si no se entrega comuna


as.codigo_territorial()



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
- comunas() = retorna un vector con los nombres de comunas
- localidades() = xxx

Funciones de pruebas 
- is.comuna() = revisa si el o los elementos son comunas; recibe nombres de comunas limpios o CUT
- evaluar_comunas() = revisa el nivel de suciedad de los datos
- is.isla()/is.continental()?
- xxx = en qué comuna está una localidad

Funciones para corregir
limpiar_comunas() = limpia comunas y las deja estandarizadas
as.codigo_comunas()? = convierte nombre de comunas en CUT
xxx = retorna la clasificacion de la comuna/cut

Avanzado
- tipo que combine nombre de comuna con código comunal
- columna territorio que sea una clase que contiene toda esa info
