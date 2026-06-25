# Limpieza de nombres de comunas de Chile a sus nombres oficiales

A partir de un vector de nombres de columnas, se realizan tres pasos de
limpieza (confirmación de nombres correctas, limpieza de texto,
detección por coincidencia) para retornar los nombres de comunas
oficiales apropiados. Los nombres de comunas son los que aparecen en
[`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md).

## Uso

``` r
limpiar_comunas(nombre_comuna, aproximar = TRUE, mostrar_proceso = TRUE)
```

## Argumentos

- nombre_comuna:

  Vector de nombres de comunas

- aproximar:

  El paso de limpieza por aproximación y coincidencia de nombres puede
  entregar resultados inexactos. Cambiar a FALSE para omitir.

- mostrar_proceso:

  Por defecto, muestra una tabla con el resultado del proceso de
  limpieza. Cambiar a FALSE para ocultar.

## Valor

Vector de nombres de comunas con correcciones aplicadas.

## Ejemplos

``` r
limpiar_comunas(c("COLCHANE", "Alto Ospicio", "probidencia", "huara", "laflorida", "cerritos", "llay-llay"))
#> ℹ Limpiando 7 nombres de comunas (7 son distintas)
#> 
#> ── Paso 1: confirmar comunas correctas 
#> ℹ De las 7 comunas, ninguna tiene nombres 100% correctos. Los siguientes pasos intentarán la limpieza
#> 
#> ── Paso 2: coincidencias por limpieza de texto 
#> ℹ A partir de la limpieza de texto, se limpiaron 2 de 7 comunas: Colchane y Huara
#> 
#> ── Paso 3: coincidencias aproximadas de texto 
#> ! alerta, se encontraron más de una coincidencia para la comuna `laflorida`: la florida y florida
#> ℹ Se limpiaron 5 de 5 comunas por medio de coincidencias aproximadas de texto: Alto Hospicio, Providencia, La Florida, Cerrillos y Llaillay
#> 
#> ── Conclusión de limpieza de comunas 
#> ✔ De las 7 comunas, se limpiaron 7 en total (100%)
#> ℹ Mostrando proceso:
#> # A tibble: 7 × 5
#>   original     correctas limpieza coincidencia  resultado    
#>   <chr>        <chr>     <chr>    <chr>         <chr>        
#> 1 COLCHANE     NA        Colchane NA            Colchane     
#> 2 Alto Ospicio NA        NA       Alto Hospicio Alto Hospicio
#> 3 probidencia  NA        NA       Providencia   Providencia  
#> 4 huara        NA        Huara    NA            Huara        
#> 5 laflorida    NA        NA       La Florida    La Florida   
#> 6 cerritos     NA        NA       Cerrillos     Cerrillos    
#> 7 llay-llay    NA        NA       Llaillay      Llaillay     
#> 
#> [1] "Colchane"      "Alto Hospicio" "Providencia"   "Huara"        
#> [5] "La Florida"    "Cerrillos"     "Llaillay"     
```
