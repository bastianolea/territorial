# Buscar comunas por similitud

Usar un término de búsqueda para obtener una tabla con comunas de
nombres similares. Funciona con cualquier tabla de datos que contenga
una columna con nombres de comunas, por lo que esta función puede
ayudarte a encontrar comunas en fuentes externas y así confirmar o
solucionar problemas. Para buscar sobre las comunas oficiales de Chile,
usa
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md).

## Uso

``` r
buscar_comuna(
  datos,
  texto,
  columna = nombre_comuna,
  similitud = 0.9,
  cantidad = 6
)
```

## Argumentos

- datos:

  Tabla de datos sobre la cual buscar, por ejemplo
  [territorios](https://bastianolea.github.io/territorial/reference/territorios.md).
  Debe contener una columna con nombres de comunas (especificada en el
  argumento `columna`).

- texto:

  Texto que quieres buscar entre las comunas

- columna:

  Columna de `datos` que contiene los nombres de comunas a comparar. Por
  defecto `nombre_comuna`. Se puede especificar sin comillas (tidy
  evaluation) o como texto.

- similitud:

  El nivel de similitud mínimo a retornar, donde 1 es total similitud y
  0 es nula similitud. Por defecto es 0,9.

- cantidad:

  Cantidad máxima de resultados, por defecto 6. Poner `Inf` para mostrar
  todos.

## Valor

Mensajes respecto de la búsqueda, y el dataframe entregado en el
argumento `datos` filtrado según comunas que cumplan con el criterio de
`similitud` de la búsqueda.

## Ejemplos

``` r
territorios |>
 buscar_comuna("peña") |>
 dplyr::select(nombre_comuna, puntaje)
#> ℹ Se encontraron 3 comunas similares.
#> ℹ Los resultados más cercanos al término `peña` son: Peñalolén y Peñaflor
#> # A tibble: 3 × 2
#>   nombre_comuna        puntaje
#>   <chr>                  <dbl>
#> 1 Peñalolén                1  
#> 2 Peñaflor                 1  
#> 3 San Pedro de Atacama     0.9

territorios |>
 buscar_comuna("alto") |>
 dplyr::select(nombre_comuna, puntaje)
#> ! Se encontraron 10 resultados, mostrando sólo 6.
#> ℹ Los resultados más cercanos al término `alto` son: Alto Hospicio, Alto del Carmen, Alto Biobío y Puente Alto
#> # A tibble: 6 × 2
#>   nombre_comuna   puntaje
#>   <chr>             <dbl>
#> 1 Alto Hospicio     1    
#> 2 Alto del Carmen   1    
#> 3 Alto Biobío       1    
#> 4 Puente Alto       1    
#> 5 Santo Domingo     0.923
#> 6 Pozo Almonte      0.917

territorios |>
 buscar_comuna("antofagasta") |>
 dplyr::select(nombre_comuna, puntaje)
#> ℹ Se encontró 1 comuna similar.
#> ℹ Los resultados más cercanos al término `antofagasta` son: Antofagasta
#> # A tibble: 1 × 2
#>   nombre_comuna puntaje
#>   <chr>           <dbl>
#> 1 Antofagasta         1

territorios |>
 buscar_comuna("perro") |>
 dplyr::select(nombre_comuna, puntaje)
#> ℹ Se encontraron 4 comunas similares.
#> Warning: No hay comunas de alta similaridad al término `perro`
#> # A tibble: 4 × 2
#>   nombre_comuna        puntaje
#>   <chr>                  <dbl>
#> 1 San Pedro de Atacama   0.95 
#> 2 San Pedro de la Paz    0.947
#> 3 Pedro Aguirre Cerda    0.947
#> 4 Cerro Navia            0.909
```
