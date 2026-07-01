# Limpieza de nombres de comunas de Chile a sus nombres oficiales

A partir de un vector de nombres de columnas, se realizan tres pasos de
limpieza (confirmación de nombres correctas, limpieza de texto,
detección por coincidencia) para retornar los nombres de comunas
oficiales apropiados. Los nombres de comunas son los que aparecen en
[`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md).

## Uso

``` r
limpiar_comunas(nombre_comuna, aproximar = TRUE, mostrar_proceso = FALSE)
```

## Argumentos

- nombre_comuna:

  Vector de nombres de comunas

- aproximar:

  El paso de limpieza por aproximación y coincidencia de nombres puede
  entregar resultados inexactos. Cambiar a FALSE para omitir.

- mostrar_proceso:

  Mostrar una tabla con el resultado del proceso de limpieza. Elegir
  entre TRUE o FALSE.

## Valor

Vector de nombres de comunas con correcciones aplicadas.

## Detalles

Los nombres son limpiados en cuatro pasos:

1.  Contrastando los nombres entregados con los nombres correctos de las
    comunas
    ([`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md)),
    para ver si hay comunas bien escritas antes de proseguir con la
    limpieza de las demás.

2.  Se *limpian* los nombres de comunas entregados, transformándolos a
    minúsculas y eliminando todo tipo de símbolos posibles, para dejar
    las palabras en sus formas más básicas (por ejemplo, `Ñuñoa` se
    vuelve `nunoa`). Luego, se aplica el mismo proceso a los nombres de
    comunas correctos
    ([`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md)),
    y se hace un cruce entre ambos conjuntos de nombres: si los nombres
    coinciden, significa que se entregaron nombres de comunas escritos
    en mayúsculas o minúsculas, comunas sin tildes o con tildes extra,
    comunas sin símbolos especiales o si eñe, entre otras, y son
    reemplazadas con sus versiones correctas.

3.  Se buscan algunos casos especiales de comunas que son típicamente
    mal escritos, pero que son difíciles de identificar de manera
    automática, por ejemplo, cuando a la comuna de *Cabo de Hornos* le
    ponen "Ex-Navarino".

4.  Si en los pasos anteriores quedaron comunas que no coincidieron (es
    decir, que sus problemas van más allá de tildes, mayúsculas o
    símbolos), se realiza una coincidencia parcial de textos o *fuzzy
    matching* usando la función
    [`base::agrepl()`](https://rdrr.io/r/base/agrep.html), que utiliza
    el [algoritmo de distancia de
    Levenshtein](https://es.wikipedia.org/wiki/Distancia_de_Levenshtein)
    para encontrar las comunas correctamente escritas que más se parecen
    a las comunas entregadas. Se esta forma, se pueden encontrar las
    comunas correctamente escritas para casos de comunas con faltas de
    ortografía (`Pobidencia` en vez de `Providencia`), comunas sin
    espacios entre sus palabras (`laflorida` en vez de `La Florida`), y
    formas alternativas de escribir las comunas (`llay-llay` en vez de
    `Llaillay`). En todos estos casos se emite una alerta que indica la
    coincidencia encontrada, ya que al ser una aproxmación, no se
    garantiza que la coincidencia sea correcta. Puedes desactivar este
    paso poniendo `aproximar = FALSE`. Finalmente, se muestra una tabla
    que describe el proceso de limpieza para su revisión (que puede
    ocultarse con `mostrar_proceso = FALSE`, y se retornan las comunas
    correctas.

## Ejemplos

``` r
limpiar_comunas(c("COLCHANE", "Alto Ospicio", "probidencia", "huara", "laflorida", "cerritos", "llay-llay"))
#> ℹ Limpiando 7 nombres de comunas (7 son distintas)
#> 
#> ── Paso 1: confirmar comunas correctas 
#> ℹ De las 7 comunas distintas, ninguna tiene nombres 100% correctos. Los siguientes pasos intentarán la limpieza
#> 
#> ── Paso 2: coincidencias por limpieza de texto 
#> ℹ A partir de la limpieza de texto, se limpiaron 2 de 7 comunas: Colchane y Huara
#> 
#> ── Paso 3: casos especiales 
#> ℹ Se encontraron 0 casos especiales: 
#> 
#> ── Paso 4: coincidencias aproximadas de texto 
#> ! alerta, se encontraron más de una coincidencia para la comuna `laflorida`: la florida y florida
#> ℹ Se limpiaron 5 de 5 comunas por medio de coincidencias aproximadas de texto: Alto Hospicio, Providencia, La Florida, Cerrillos y Llaillay
#> 
#> ── Conclusión de limpieza de comunas 
#> ✔ De las 7 comunas distintas, se limpiaron 7 en total (100%)
#> 
#> [1] "Colchane"      "Alto Hospicio" "Providencia"   "Huara"        
#> [5] "La Florida"    "Cerrillos"     "Llaillay"     

datos <- dplyr::tibble(
  nombre_comuna = c("PIRQUE", "El Monte", "Maipu", "santiago", "prohibidencia", "CERRILLOS", "San José De Maipo", "OHiggins"),
  valores = c(4, 6, 2, 8, 6, 3, 5, 8)
  )

datos |>
  dplyr::mutate(nombre_corregido = limpiar_comunas(nombre_comuna))
#> ℹ Limpiando 8 nombres de comunas (8 son distintas)
#> 
#> ── Paso 1: confirmar comunas correctas 
#> ℹ De las 8 comunas distintas, 1 ya eran correctas: El Monte
#> 
#> ── Paso 2: coincidencias por limpieza de texto 
#> ℹ A partir de la limpieza de texto, se limpiaron 7 de 8 comunas: Pirque, El Monte, Maipú, Santiago, Cerrillos, San José de Maipo y O'Higgins
#> 
#> ── Paso 3: casos especiales 
#> ℹ Se encontraron 0 casos especiales: 
#> 
#> ── Paso 4: coincidencias aproximadas de texto 
#> ℹ Se limpiaron 1 de 1 comunas por medio de coincidencias aproximadas de texto: Providencia
#> 
#> ── Conclusión de limpieza de comunas 
#> ✔ De las 8 comunas distintas, se limpiaron 8 en total (100%)
#> 
#> # A tibble: 8 × 3
#>   nombre_comuna     valores nombre_corregido 
#>   <chr>               <dbl> <chr>            
#> 1 PIRQUE                  4 Pirque           
#> 2 El Monte                6 El Monte         
#> 3 Maipu                   2 Maipú            
#> 4 santiago                8 Santiago         
#> 5 prohibidencia           6 Providencia      
#> 6 CERRILLOS               3 Cerrillos        
#> 7 San José De Maipo       5 San José de Maipo
#> 8 OHiggins                8 O'Higgins        
```
