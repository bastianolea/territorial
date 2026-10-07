# Acortar nombres de las regiones de Chile

Hay regiones de Chile con nombres extensos, y que en ciertos contextos
requieren de una versión más breve. Esta función procesa el texto de los
nombres de regiones para, por ejemplo, pasar desde "Aysén del General
Carlos Ibáñez del Campo" a "Aysén".

## Uso

``` r
acortar_regiones(datos, variable = NULL)
```

## Argumentos

- datos:

  Dataframe con una columna de nombres de regiones, o vector de nombres
  de regiones

- variable:

  Columna del dataframe con los nombres de regiones (se pasa sin
  comillas, p.ej. `region`). Si no se especifica, se asume
  `nombre_region`. Si se aplica a un vector, omitir este argumento.

## Valor

Si la entrada es un dataframe, retorna el dataframe con la columna de
regiones reemplazada por sus versiones breves. Si es un vector, retorna
un vector de texto con nombres de regiones breves.

## Ejemplos

``` r
acortar_regiones("Libertador Gral. Bernardo O'Higgins")
#> [1] "O'Higgins"

territorios |>
  ordenar_regiones() |>
  dplyr::mutate(nombre_region_corto = acortar_regiones(nombre_region)) |>
  dplyr::select(nombre_region, nombre_region_corto)
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> ℹ In argument: `nombre_region_corto = acortar_regiones(nombre_region)`.
#> Caused by warning:
#> ! Los datos están en formato factor: se perderá el orden de los niveles al
#> convertirlos a texto
#> # A tibble: 346 × 2
#>    nombre_region      nombre_region_corto
#>    <fct>              <chr>              
#>  1 Arica y Parinacota Arica y Parinacota 
#>  2 Arica y Parinacota Arica y Parinacota 
#>  3 Arica y Parinacota Arica y Parinacota 
#>  4 Arica y Parinacota Arica y Parinacota 
#>  5 Tarapacá           Tarapacá           
#>  6 Tarapacá           Tarapacá           
#>  7 Tarapacá           Tarapacá           
#>  8 Tarapacá           Tarapacá           
#>  9 Tarapacá           Tarapacá           
#> 10 Tarapacá           Tarapacá           
#> # ℹ 336 more rows

datos <- dplyr::tibble(
  nombre_region = c(
    "Libertador Gral. Bernardo O'Higgins",
    "Aysén del General Carlos Ibáñez del Campo"
  ),
  valores = c(4, 6)
)

# si existe `nombre_region`, la función no requiere argumentos:
datos |>
  acortar_regiones()
#> # A tibble: 2 × 2
#>   nombre_region valores
#>   <chr>           <dbl>
#> 1 O'Higgins           4
#> 2 Aysén               6
```
