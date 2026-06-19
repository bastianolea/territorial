# Contextualizar datos de nivel comunal con variables territoriales

Para cualquier tabla de datos de nivel comunal que tenga al menos una
variable territorial (`codigo_comuna` o `nombre_comuna`), indicar esta
variable para agregar todo el resto de variables territoriales. De esta
manera, se contextualizan territorialmente los datos al agregar todas
las variables territoriales faltantes.

## Uso

``` r
contextualizar(datos, variable = NULL)
```

## Argumentos

- datos:

  Dataframe de datos comunales al que se quieren agregar columnas con
  variables territoriales

- variable:

  Variable territorial ya existente en el dataframe (`codigo_comuna` o
  `nombre_comuna`)

## Valor

El mismo dataframe con las columnas `codigo_region`, `nombre_region`,
`codigo_provincia`, `nombre_provincia`, `codigo_comuna` y
`nombre_comuna` agregadas al inicio.

## Ejemplos

``` r
datos <- dplyr::tribble(
  ~nombre_comuna, ~valor,
  "Cerrillos",    1,
  "Arica",        2,
  "Putre",        3)

datos |>
  contextualizar(variable = "nombre_comuna")
#> ℹ columnas agregadas: codigo_region, nombre_region, codigo_provincia, nombre_provincia y codigo_comuna
#> # A tibble: 3 × 7
#>   codigo_region nombre_region    codigo_provincia nombre_provincia codigo_comuna
#>           <dbl> <chr>                       <dbl> <chr>                    <dbl>
#> 1            13 Metropolitana d…              131 Santiago                 13102
#> 2            15 Arica y Parinac…              151 Arica                    15101
#> 3            15 Arica y Parinac…              152 Parinacota               15201
#> # ℹ 2 more variables: nombre_comuna <chr>, valor <dbl>
```
