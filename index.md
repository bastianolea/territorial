# Paquete `{territorial}`

Herramientas para facilitar el trabajo con datos de comunas y regiones
de Chile en R.

El objetivo de este paquete es poder ayudar a todas las personas que
trabajan datos territoriales de Chile a simplificar sus procesos de
análisis de datos con R. Principalmente, este paquete busca facilitar
tareas de limpieza y procesamiento de datos que suelen ser necesarias al
trabajar con datos de Chile a nivel comunal y regional.

Por ejemplo:

- Revisar si los nombres de comunas y regiones vienen bien escritos
  ([`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md)
  y
  [`validar_regiones()`](https://bastianolea.github.io/territorial/reference/validar_regiones.md))
- Limpiar automáticamente los nombres de las comunas con
  [`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
- Agregar todos los datos territoriales (regiones y provincias con sus
  códigos únicos) a partir de las comunas
  ([`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md))
- Convertir nombres de comunas a códigos únicos comunales
  ([`as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md))
  y viceversa
  ([`as_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/as_nombre_comuna.md))
- Ordenar las regiones del país de norte a sur
  ([`ordenar_regiones()`](https://bastianolea.github.io/territorial/reference/ordenar_regiones.md))
- Redactar los nombres de las regiones
  ([`redactar_region()`](https://bastianolea.github.io/territorial/reference/redactar_region.md))
- y más!

La razón de este paquete viene de mi propia experiencia trabajando con
datos sociales: los datos territoriales vienen siempre con dudosa
calidad en las variables que especifican las comunas: nombres mal
escritos, en mayúsculas, sin eñes, etc.

Revisa la viñeta
[`vignette("territorial")`](https://bastianolea.github.io/territorial/articles/territorial.md)
para una introducción al paquete!

------------------------------------------------------------------------

Paquete desarrollado bajo el [programa de Campeones de
ROpenSci](https://ropensci.org/es/champions/), con el apoyo de mi
mentora [Andrea Gómez Vargas](https://github.com/SoyAndrea)

## Instalación

Puedes instalar la versión de desarrollo este paquete desde GitHub:

``` r

# install.packages("pak")
pak::pak("bastianolea/territorial")
```

*Nota:* el paquete está en etapa de desarrollo. Si bien es funcional y
útil en este momento, sus funciones pueden cambiar en futuras versiones,
y su estabilidad no está garantizada.

## Usando `{territorial}`

Como su nombre lo dice,
[territorial](https://bastianolea.github.io/territorial) entrega varias
herramientas para trabajar con datos territoriales de Chile,
principalmente sus regiones o comunas.

``` r

library(territorial)
```

La premisa del paquete es que tenemos una tabla
([`territorial::territorios`](https://bastianolea.github.io/territorial/reference/territorios.md))
que contiene los nombres oficiales y los códigos únicos territoriales de
todas las regiones, provincias y comunas de Chile.

Si tienes datos comunales de Chile, puedes revisar la calidad de sus
comunas con
[`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md),
para detectar posibles problemas:

``` r

datos |> 
  validar_comunas(nombre_comuna)
```

``` R
! Resumen: 7 casos de comunas que no conciden con comunas correctamente escritas (ver `territorial::comunas()`): PIRQUE, Maipu, santiago, prohibidencia, CERRILLOS, San José De Maipo y OHiggins

! Mayúsculas: 2 casos de comunas escritas en mayúsculas: PIRQUE y CERRILLOS

! Minúsculas: 2 casos de comunas escritas en minúsculas: santiago y prohibidencia

! Mayúsculas: 1 caso de comunas con preposiciones ('de', 'del') escritas en mayúsculas: San José De Maipo

ℹ Tildes: 1 caso de comunas que deberían tener tildes y no los tienen: Maipu

ℹ Problemas comunes: 1 caso de comunas popularmente mal escritas: OHiggins

✖ Validación de comunas: se encontraron 14 problemas con las comunas! Usa `territorial::limpiar_comunas()` para solucionarlos.
```

También puedes limpiar automáticamente las comunas con
[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md),
y obtener una columna con las comunas correctas (que salen de la tabla
[`territorial::territorios`](https://bastianolea.github.io/territorial/reference/territorios.md)),
obtenidas por medio de varias técnicas de limpieza de datos:

``` r

library(dplyr)
```

``` r

datos |> 
  mutate(nombre_corregido = limpiar_comunas(nombre_comuna))
```

``` R
ℹ Limpiando 8 nombres de comunas (8 son distintas)

── Paso 1: confirmar comunas correctas 

ℹ De las 8 comunas distintas, 1 ya eran correctas: El Monte

── Paso 2: coincidencias por limpieza de texto 

ℹ A partir de la limpieza de texto, se limpiaron 7 de 8 comunas: Pirque, El Monte, Maipú, Santiago, Cerrillos, San José de Maipo y O'Higgins

── Paso 3: casos especiales 

ℹ Se encontraron 0 casos especiales: 

── Paso 4: coincidencias aproximadas de texto 

ℹ Se limpiaron 1 de 1 comunas por medio de coincidencias aproximadas de texto: Providencia

── Conclusión de limpieza de comunas 

✔ De las 8 comunas distintas, se limpiaron 8 en total (100%)

# A tibble: 8 × 2
  nombre_comuna     nombre_corregido 
  <chr>             <chr>            
1 PIRQUE            Pirque           
2 El Monte          El Monte         
3 Maipu             Maipú            
4 santiago          Santiago         
5 prohibidencia     Providencia      
6 CERRILLOS         Cerrillos        
7 San José De Maipo San José de Maipo
8 OHiggins          O'Higgins        
```

Si necesitamos agregar datos territoriales a una tabla de datos que
solamente tiene las comunas o los códigos únicos territoriales de Chile
(`vignette(codigos_unicos_territoriales)`), podemos usar
[`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md)
para agregar rápidamente todas las columnas territoriales que falten.

``` r

datos <- tribble(
  ~nombre_comuna, ~poblacion,
  "Puente Alto",    1,
  "La Florida",     1,
  "La Granja",      1,
  "San Joaquín",    1)
```

``` r

datos |>
  contextualizar(nombre_comuna)
```

``` R
ℹ columnas agregadas: codigo_region, nombre_region, codigo_provincia, nombre_provincia y codigo_comuna

# A tibble: 4 × 7
  codigo_region nombre_region    codigo_provincia nombre_provincia codigo_comuna
          <dbl> <chr>                       <dbl> <chr>                    <dbl>
1            13 Metropolitana d…              132 Cordillera               13201
2            13 Metropolitana d…              131 Santiago                 13110
3            13 Metropolitana d…              131 Santiago                 13111
4            13 Metropolitana d…              131 Santiago                 13129
# ℹ 2 more variables: nombre_comuna <chr>, poblacion <dbl>
```

Así, un dataframe que solamente tiene nombres de comuna puede pasar a
tener todas las demás variables que descrien territorialmente a esos
datos.

------------------------------------------------------------------------

Estas son algunas de las funciones principales, pero existen muchas más
que facilitan el trabajo con datos territoriales de Chile: [revisa el
índice!](https://bastianolea.github.io/territorial/reference/)
