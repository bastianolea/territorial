# Ejemplo: tasa de ocupación formal

En este ejemplo se limpian datos territoriales sobre la **tasa de
ocupación formal dependiente** a nivel comunal, publicados por el
Ministerio de Desarrollo Social y Familia como parte de sus
[estadísticas de registros administrativos
2025](https://bidat.gob.cl/details/ficha/dataset/estadisticas-registros-administrativos-2025?page=2).

Cargaremos los datos, limpiaremos los nombres de las comunas, y luego
agregaremos las columnas territoriales faltantes (regiones, provincias)
de dos maneras distintas: primero una por una, y luego todo de una vez
con
[`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md).

Puedes [descargar aquí los
datos](https://github.com/bastianolea/territorial/raw/main/data-raw/ejemplo_mideso.xlsx)
para seguir el ejemplo.

------------------------------------------------------------------------

Primero cargamos los datos originales:

``` r

library(dplyr)
library(readxl)
library(here)

datos_originales <- read_xlsx(
  here("data-raw/ejemplo_mideso.xlsx"),
  sheet = 3,
  skip = 2)

datos_originales
```

    # A tibble: 2,941 × 5
       Categoría    Nivel   Desagregación1 Desagregación2 `2025`
       <chr>        <chr>   <chr>          <chr>           <dbl>
     1 cuenta_ocup1 país    Nacional       <NA>             36.0
     2 cuenta_ocup1 sexo    Masculino      <NA>             41.1
     3 cuenta_ocup1 sexo    Femenino       <NA>             31.1
     4 cuenta_ocup1 tedad_4 15 a 29 años   <NA>             28.0
     5 cuenta_ocup1 tedad_4 30 a 44 años   <NA>             54.8
     6 cuenta_ocup1 tedad_4 45 a 59 años   <NA>             48.6
     7 cuenta_ocup1 tedad_4 60 o más años  <NA>             11.1
     8 cuenta_ocup1 region  Tarapacá       <NA>             35.9
     9 cuenta_ocup1 region  Antofagasta    <NA>             43.0
    10 cuenta_ocup1 region  Atacama        <NA>             37.7
    # ℹ 2,931 more rows

La planilla contiene indicadores para distintos niveles de desagregación
(país, sexo, tramos de edad, región, comuna, etc.), identificados en la
columna `Nivel`. Nos quedamos sólo con las filas comunales, y
seleccionamos el nombre de la comuna y el valor de la tasa de ocupación:

``` r

datos_comunales <- datos_originales |> 
  filter(Nivel == "comuna") |> 
  select(nombre_comuna = Desagregación1, 
         ocupacion = 5)

datos_comunales
```

    # A tibble: 346 × 2
       nombre_comuna ocupacion
       <chr>             <dbl>
     1 Iquique            36.8
     2 Alto Hospicio      35.2
     3 Pozo Almonte       34.3
     4 Camiña             17.8
     5 Colchane           23.9
     6 Huara              23.3
     7 Pica               30.3
     8 Antofagasta        43.3
     9 Mejillones         45.5
    10 Sierra Gorda       45.8
    # ℹ 336 more rows

Los datos solamente vienen con los nombres de comunas, y sin [códigos
únicos
territoriales](https://bastianolea.github.io/territorial/articles/codigos_unicos_territoriales.html),
ni regiones, ni nada más.

Cargamos el paquete `territorial` para evaluar la calidad de los nombres
de las comunas:

``` r

library(territorial)

datos_comunales |> 
  validar_comunas()
```

    ! Resumen: 4 casos de comunas que no conciden con comunas correctamente escritas (ver `territorial::comunas()`): Paiguano, Juan Fernandez, O Higgins y Treguaco

    ℹ Tildes: 1 caso de comunas que deberían tener tildes y no los tienen: Juan Fernandez

    ℹ Escrituras alternativas: 2 casos de comunas escritas de una forma no recomendada, aunque válida: Paiguano y Treguaco

    ✖ Validación de comunas: se encontraron 7 problemas con las comunas! Usa `territorial::limpiar_comunas()` para solucionarlos.

La validación detecta algunos problemas: *Juan Fernandez* le falta el
tilde, *O Higgins* tiene su apóstrofo omitido, a *Ránquil* le sobra el
tilde, y *Paiguano* y *Treguaco* están escritas de formas no
recomendadas.

Para corregirlos usamos
[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md),
que al no recibir una columna asume que existe una llamada
`nombre_comuna`:

``` r

datos_limpios <- datos_comunales |> 
  limpiar_comunas()
```

    ℹ Limpiando 346 nombres de comunas (346 son distintas)

    → Paso 1: confirmar comunas correctas

    ℹ De las 346 comunas distintas, 342 ya eran correctas: Iquique, Alto Hospicio, Pozo Almonte, Camiña, Colchane, Huara, Pica, Antofagasta, Mejillones, Sierra Gorda y 332 comunas más

    → Paso 2: coincidencias por limpieza de texto

    ℹ A partir de la limpieza de texto, se limpiaron 343 de 346 comunas: Iquique, Alto Hospicio, Pozo Almonte, Camiña, Colchane, Huara, Pica, Antofagasta, Mejillones, Sierra Gorda y 333 comunas más

    → Paso 3: casos especiales

    ℹ Se encontró 1 caso especial: Cabo de Hornos

    → Paso 4: coincidencias aproximadas de texto

    ℹ Se limpiaron 3 de 3 comunas por medio de coincidencias aproximadas de texto: Paihuano, O'Higgins y Trehuaco

    → Conclusión de limpieza de comunas

    ✔ De las 346 comunas distintas, se limpiaron 346 en total (100%)

La función nos informa que, de las 346 comunas distintas, 342 eran
correctas, y las demás se limpiaron mediante distintas técnicas
automatizadas.

Con esta limpieza ya confirmamos que nuestra base de datos tiene nombres
de comunas correctos, así que podemos basarnos en ellos para agregar más
variables territoriales.

## Agregar columnas territoriales paso a paso

Con
[`as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md)
transformamos el nombre de la comuna en su **código único territorial**
(ver
[`vignette("codigos_unicos_territoriales")`](https://bastianolea.github.io/territorial/articles/codigos_unicos_territoriales.md)),
con
[`ubicar_comunas()`](https://bastianolea.github.io/territorial/reference/ubicar_comunas.md)
obtenemos la **región** a la que pertenece cada comuna, y con
[`as_codigo_region()`](https://bastianolea.github.io/territorial/reference/as_codigo_region.md)
convertimos el nombre de la región en su **código regional**:

``` r

datos_paso_a_paso <- datos_limpios |> 
  mutate(codigo_comuna = as_codigo_comuna(nombre_comuna)) |> 
  mutate(nombre_region = ubicar_comunas(nombre_comuna)) |> 
  mutate(codigo_region = as_codigo_region(nombre_region))

datos_paso_a_paso
```

    # A tibble: 346 × 5
       nombre_comuna ocupacion codigo_comuna nombre_region codigo_region
       <chr>             <dbl>         <dbl> <chr>                 <dbl>
     1 Iquique            36.8          1101 Tarapacá                  1
     2 Alto Hospicio      35.2          1107 Tarapacá                  1
     3 Pozo Almonte       34.3          1401 Tarapacá                  1
     4 Camiña             17.8          1402 Tarapacá                  1
     5 Colchane           23.9          1403 Tarapacá                  1
     6 Huara              23.3          1404 Tarapacá                  1
     7 Pica               30.3          1405 Tarapacá                  1
     8 Antofagasta        43.3          2101 Antofagasta               2
     9 Mejillones         45.5          2102 Antofagasta               2
    10 Sierra Gorda       45.8          2103 Antofagasta               2
    # ℹ 336 more rows

Este método permite elegir exactamente qué columnas agregar y en qué
orden, a costa de escribir una línea por cada una.

## Agregar columnas territoriales con `contextualizar()`

Alternativamente, la función
[`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md)
agrega de una sola vez todas las columnas de identificación territorial
a partir del **nombre de la comuna** (o el código, si está presente). Es
decir que agrega automáticamente las variables de códigos y nombres de
región y provincia, y también código de comuna.

Como en este ejemplo no nos interesa la provincia, la quitamos después:

``` r

datos_contextualizados <- datos_limpios |> 
  contextualizar() |> 
  select(-ends_with("provincia"))
```

    ℹ No se especificó la variable: asumiendo columna `nombre_comuna`

    ℹ Columnas agregadas: codigo_region, nombre_region, codigo_provincia, nombre_provincia y codigo_comuna

``` r

datos_contextualizados
```

    # A tibble: 346 × 5
       codigo_region nombre_region codigo_comuna nombre_comuna ocupacion
               <dbl> <chr>                 <dbl> <chr>             <dbl>
     1             1 Tarapacá               1101 Iquique            36.8
     2             1 Tarapacá               1107 Alto Hospicio      35.2
     3             1 Tarapacá               1401 Pozo Almonte       34.3
     4             1 Tarapacá               1402 Camiña             17.8
     5             1 Tarapacá               1403 Colchane           23.9
     6             1 Tarapacá               1404 Huara              23.3
     7             1 Tarapacá               1405 Pica               30.3
     8             2 Antofagasta            2101 Antofagasta        43.3
     9             2 Antofagasta            2102 Mejillones         45.5
    10             2 Antofagasta            2103 Sierra Gorda       45.8
    # ℹ 336 more rows

## Comparar ambos métodos

Comparamos las columnas de nombres de comuna de ambos resultados con el
[paquete `{waldo}`](https://bastianolea.rbind.io/blog/waldo/):

``` r

waldo::compare(
  datos_paso_a_paso$nombre_comuna,
  datos_contextualizados$nombre_comuna
)
```

    ✔ No differences

No hay diferencias: ambos métodos entregan las mismas comunas en el
mismo orden. Si comparamos las tablas completas, la única diferencia es
el orden de las columnas, ya que
[`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md)
ubica las columnas territoriales al comienzo de la tabla:

``` r

waldo::compare(
  datos_paso_a_paso,
  datos_contextualizados
)
```

        names(old)      | names(new)
    [1] "nombre_comuna" - "codigo_region" [1]
    [2] "ocupacion"     - "nombre_region" [2]
    [3] "codigo_comuna" | "codigo_comuna" [3]
    [4] "nombre_region" - "nombre_comuna" [4]
    [5] "codigo_region" - "ocupacion"     [5]

Podemos reordenar las columnas del primer método para confirmar que el
contenido de las tablas completas es idéntico:

``` r

waldo::compare(
  datos_paso_a_paso |> select(all_of(names(datos_contextualizados))),
  datos_contextualizados
)
```

    ✔ No differences
