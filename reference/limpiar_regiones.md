# Limpieza de nombres de regiones de Chile a sus nombres oficiales

A partir de un dataframe con una variable de nombres de región
(idealmente `nombre_region`), o un vector de nombres de regiones, se
realizan cuatro pasos de limpieza (confirmación de nombres correctos,
limpieza de texto, limpieza de casos especiales, y detección por
coincidencia) para retornar los nombres de regiones oficiales
apropiados. Los nombres de regiones considerados *limpios* son los que
aparecen en
[`regiones()`](https://bastianolea.github.io/territorial/reference/regiones.md),
incluyendo también sus versiones cortas (ver
[`acortar_regiones()`](https://bastianolea.github.io/territorial/reference/acortar_regiones.md));
por ejemplo, tanto "Aysén" como "Aysén del General Carlos Ibáñez del
Campo" se consideran nombres limpios.

## Uso

``` r
limpiar_regiones(
  datos,
  variable = NULL,
  aproximar = TRUE,
  procedimiento = FALSE
)
```

## Argumentos

- datos:

  Dataframe con una columna de nombres de regiones, o vector de nombres
  de regiones

- variable:

  Columna del dataframe con los nombres de regiones (se pasa sin
  comillas, p.ej. `region`). Si no se especifica, se asume
  `nombre_region`. Si se aplica a un vector, omitir este argumento.

- aproximar:

  El paso de limpieza por aproximación y coincidencia de nombres puede
  entregar resultados inexactos. Cambiar a FALSE para omitir.

- procedimiento:

  Mostrar una tabla con los resultados intermedios del proceso de
  limpieza. Elegir entre TRUE o FALSE, por defecto FALSE.

## Valor

Si la entrada es un dataframe, retorna el dataframe con la columna de
regiones reemplazada. Si es un vector, retorna un vector de nombres de
regiones oficiales (en su versión larga) con correcciones aplicadas.

## Detalles

Los nombres se limpian en cuatro pasos:

1.  Contrastando los nombres entregados con los nombres correctos de las
    regiones
    ([`regiones()`](https://bastianolea.github.io/territorial/reference/regiones.md))
    y sus versiones cortas
    ([`acortar_regiones()`](https://bastianolea.github.io/territorial/reference/acortar_regiones.md)),
    para ver si hay regiones bien escritas antes de proseguir con la
    limpieza de las demás.

2.  Se *limpian* los nombres de regiones entregados, transformándolos a
    minúsculas y eliminando todo tipo de símbolos posibles, para dejar
    las palabras en sus formas más básicas (por ejemplo, `Ñuble` se
    vuelve `nuble`). Luego, se aplica el mismo proceso a los nombres de
    regiones correctos (largos y cortos), y se hace un cruce entre ambos
    conjuntos de nombres: si los nombres coinciden, significa que se
    entregaron nombres de regiones escritos en mayúsculas o minúsculas,
    regiones sin tildes o con tildes extra, regiones sin símbolos
    especiales, entre otras, y son reemplazadas con sus versiones
    correctas.

3.  Se buscan algunos casos especiales de regiones que son típicamente
    mal escritos, pero que son difíciles de identificar de manera
    automática, por ejemplo, cuando a la Región Metropolitana le dicen
    "RM" o "Santiago", o cuando a la región de Aysén le ponen "Aisén"
    (con i latina).

4.  Si en los pasos anteriores quedaron regiones que no coincidieron (es
    decir, que sus problemas van más allá de tildes, mayúsculas o
    símbolos), se realiza una coincidencia parcial de textos o *fuzzy
    matching* usando la función
    [`base::agrepl()`](https://rdrr.io/r/base/agrep.html), que utiliza
    el [algoritmo de distancia de
    Levenshtein](https://es.wikipedia.org/wiki/Distancia_de_Levenshtein)
    para encontrar las regiones correctamente escritas que más se
    parecen a las regiones entregadas. En todos estos casos se emite una
    alerta que indica la coincidencia encontrada, ya que al ser una
    aproximación, no se garantiza que la coincidencia sea correcta.
    Puedes desactivar este paso poniendo `aproximar = FALSE`.
    Finalmente, se muestra una tabla que describe el proceso de limpieza
    para su revisión (que puede ocultarse con `procedimiento = FALSE`),
    y se retornan los nombres de regiones oficiales (en su versión
    larga).

## Ejemplos

``` r
limpiar_regiones(c("MAULE", "biobio", "la araucania", "Los rios", "RM", "aisen"))
#> ℹ Limpiando 6 nombres de región (6 son distintos)
#> → Paso 1: confirmar regiones correctas
#> ℹ De las 6 regiones distintas, ninguna tiene nombres 100% correctos. Los siguientes pasos intentarán la limpieza
#> → Paso 2: coincidencias por limpieza de texto
#> ℹ A partir de la limpieza de texto, se limpiaron 4 de 6 regiones: Maule, Biobío, La Araucanía y Los Ríos
#> → Paso 3: casos especiales
#> ℹ Se encontraron 3 casos especiales: Biobío, Metropolitana de Santiago y Aysén del General Carlos Ibáñez del Campo
#> → Paso 4: coincidencias aproximadas de texto
#> ℹ No se limpiaron regiones como parte de este paso
#> → Conclusión de limpieza de regiones
#> ✔ De las 6 regiones distintas, se limpiaron 6 en total (100%)
#> [1] "Maule"                                    
#> [2] "Biobío"                                   
#> [3] "La Araucanía"                             
#> [4] "Los Ríos"                                 
#> [5] "Metropolitana de Santiago"                
#> [6] "Aysén del General Carlos Ibáñez del Campo"

datos <- dplyr::tibble(
  nombre_region = c("TARAPACA", "Coquimbo", "valparaiso",
                    "santiago", "ohiggins", "NUBLE"),
  valores = c(4, 6, 2, 8, 6, 3)
  )

# si existe `nombre_region`, la función no requiere argumentos:
datos |>
  limpiar_regiones()
#> ℹ Limpiando 6 nombres de región (6 son distintos)
#> → Paso 1: confirmar regiones correctas
#> ℹ De las 6 regiones distintas, 1 ya eran correctas: Coquimbo
#> → Paso 2: coincidencias por limpieza de texto
#> ℹ A partir de la limpieza de texto, se limpiaron 5 de 6 regiones: Tarapacá, Coquimbo, Valparaíso, Libertador General Bernardo O'Higgins y Ñuble
#> → Paso 3: casos especiales
#> ℹ Se encontró 1 caso especial: Metropolitana de Santiago
#> → Paso 4: coincidencias aproximadas de texto
#> ℹ No se limpiaron regiones como parte de este paso
#> → Conclusión de limpieza de regiones
#> ✔ De las 6 regiones distintas, se limpiaron 6 en total (100%)
#> # A tibble: 6 × 2
#>   nombre_region                         valores
#>   <chr>                                   <dbl>
#> 1 Tarapacá                                    4
#> 2 Coquimbo                                    6
#> 3 Valparaíso                                  2
#> 4 Metropolitana de Santiago                   8
#> 5 Libertador General Bernardo O'Higgins       6
#> 6 Ñuble                                       3

# también puede usarse sobre un vector:
datos |>
  dplyr::mutate(nombre_corregido = limpiar_regiones(nombre_region))
#> ℹ Limpiando 6 nombres de región (6 son distintos)
#> → Paso 1: confirmar regiones correctas
#> ℹ De las 6 regiones distintas, 1 ya eran correctas: Coquimbo
#> → Paso 2: coincidencias por limpieza de texto
#> ℹ A partir de la limpieza de texto, se limpiaron 5 de 6 regiones: Tarapacá, Coquimbo, Valparaíso, Libertador General Bernardo O'Higgins y Ñuble
#> → Paso 3: casos especiales
#> ℹ Se encontró 1 caso especial: Metropolitana de Santiago
#> → Paso 4: coincidencias aproximadas de texto
#> ℹ No se limpiaron regiones como parte de este paso
#> → Conclusión de limpieza de regiones
#> ✔ De las 6 regiones distintas, se limpiaron 6 en total (100%)
#> # A tibble: 6 × 3
#>   nombre_region valores nombre_corregido                     
#>   <chr>           <dbl> <chr>                                
#> 1 TARAPACA            4 Tarapacá                             
#> 2 Coquimbo            6 Coquimbo                             
#> 3 valparaiso          2 Valparaíso                           
#> 4 santiago            8 Metropolitana de Santiago            
#> 5 ohiggins            6 Libertador General Bernardo O'Higgins
#> 6 NUBLE               3 Ñuble                                
```
