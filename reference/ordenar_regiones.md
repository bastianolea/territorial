# Ordenar regiones de Chile geogr\u00e1ficamente

Ordena una columna de nombres de regiones de Chile (`nombre_region`) a
partir de la columna `codigo_region`, resultando en una columna
`nombre_region` en formato factor, ordenada de norte a sur.

## Uso

``` r
ordenar_regiones(datos, limpiar = TRUE, ordenar = TRUE)
```

## Argumentos

- datos:

  Tabla de datos que contenga las columnas `nombre_region` y
  `codigo_region`

- limpiar:

  Para ordenar la variable `nombre_region`, se crea la variable
  intermedia `orden_region`, que por defecto se elimina después de
  usarla. Cambiar a FALSE para mantenerla.

- ordenar:

  ¿Ordenar la tabla de datos según regiones? (por defecto TRUE)

## Valor

Tabla de datos con la variable `nombre_region` en formato factor,
ordenado geogr\u00e1ficamente (de norte a sur)

## Ejemplos

``` r
regiones <- dplyr::tribble(
  ~codigo_region,                  ~nombre_region,
  1,                                   "Tarapacá",
  2,                                "Antofagasta",
  3,                                    "Atacama",
  4,                                   "Coquimbo",
  5,                                 "Valparaíso",
  6,      "Libertador General Bernardo O'Higgins",
  7,                                      "Maule",
  8,                                     "Biobío",
  9,                               "La Araucanía",
  10,                                 "Los Lagos",
  11, "Aysén del General Carlos Ibáñez del Campo",
  12,      "Magallanes y de la Antártica Chilena",
  13,                 "Metropolitana de Santiago",
  14,                                  "Los Ríos",
  15,                        "Arica y Parinacota",
  16,                                     "Ñuble"
  )

regiones |>
  ordenar_regiones()
#> # A tibble: 16 × 2
#>    codigo_region nombre_region                            
#>            <dbl> <fct>                                    
#>  1            15 Arica y Parinacota                       
#>  2             1 Tarapacá                                 
#>  3             2 Antofagasta                              
#>  4             3 Atacama                                  
#>  5             4 Coquimbo                                 
#>  6             5 Valparaíso                               
#>  7            13 Metropolitana de Santiago                
#>  8             6 Libertador General Bernardo O'Higgins    
#>  9             7 Maule                                    
#> 10            16 Ñuble                                    
#> 11             8 Biobío                                   
#> 12             9 La Araucanía                             
#> 13            14 Los Ríos                                 
#> 14            10 Los Lagos                                
#> 15            11 Aysén del General Carlos Ibáñez del Campo
#> 16            12 Magallanes y de la Antártica Chilena     
```
