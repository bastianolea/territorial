# Ubicar localidades en la comuna que les corresponde

Al igual que
[`ubicar_comunas()`](https://bastianolea.github.io/territorial/reference/ubicar_comunas.md),
para un vector de nombres de localidades, retorna las comunas donde se
ubican dichas localidades. Las localidades son zonas geográficas, grupos
de viviendas o asentamientos más pequeños que una comuna y que poseen un
nombre propio, pero que no son entidades administrativas (para más
información, ver la tabla
[`localidades`](https://bastianolea.github.io/territorial/reference/localidades.md)).

## Uso

``` r
ubicar_localidades(
  nombre_localidad = NULL,
  nombre_region = NULL,
  mostrar_proceso = TRUE
)
```

## Argumentos

- nombre_localidad:

  Nombres de localidades, idealmente como aparecen en
  [localidades](https://bastianolea.github.io/territorial/reference/localidades.md).

- nombre_region:

  Opcionalmente, una región para circunscribir la búsqueda y así
  retornar mejores resultados.

- mostrar_proceso:

  Por defecto, muestra una tabla con el resultado del proceso de
  limpieza. Cambiar a FALSE para ocultar.

## Valor

Vector con nombres de comunas correspondientes

## Detalles

Al buscar las localidades, primero busca por coincidencias exactas de
nombres y, si existen más de una con el mismo nombre, retorna la
localidad con mayor población (según el estudio de Localidades Aisladas
2021 de Subdere). Si no se encuentra una localidad exacta, se buscan por
coincidencia inexacta.

## Ejemplos

``` r
ubicar_localidades("La Boca")
#> ℹ Buscando localidad 'La Boca'
#> ! Se encontraron 4 localidades coincidentes:
#> # A tibble: 4 × 5
#>   nombre_region                         nombre_comuna localidad tipo     subtipo
#>   <chr>                                 <chr>         <chr>     <chr>    <chr>  
#> 1 Libertador General Bernardo O'Higgins Navidad       La Boca   Localid… Aldea  
#> 2 Valparaíso                            Casablanca    La Boca   Localid… Parcel…
#> 3 Ñuble                                 Cobquecura    La Boca   Localid… Caserío
#> 4 Ñuble                                 Cobquecura    La Boca   Localid… Parcel…
#> ℹ Retornando la primera localidad: La Boca, ubicada en la comuna de Navidad, Región del Libertador General Bernardo O'Higgins
#> [1] "Navidad"

ubicar_localidades(c("Chada", "La Dormida", "Mallarauco"))
#> ℹ Buscando localidad 'Chada'
#> ! Se encontraron 5 localidades coincidentes:
#> # A tibble: 5 × 5
#>   nombre_region                         nombre_comuna localidad tipo     subtipo
#>   <chr>                                 <chr>         <chr>     <chr>    <chr>  
#> 1 Metropolitana de Santiago             Paine         Chada     Localid… Parcel…
#> 2 La Araucanía                          Pitrufquén    Chada     Localid… Parcel…
#> 3 Metropolitana de Santiago             Paine         Chada     Localid… Fundo-…
#> 4 Libertador General Bernardo O'Higgins Codegua       Chada     Localid… Fundo-…
#> 5 Metropolitana de Santiago             Paine         Chada     Urbano   Pueblo 
#> ℹ Retornando la primera localidad: Chada, ubicada en la comuna de Paine, Región Metropolitana de Santiago
#> ℹ Buscando localidad 'La Dormida'
#> ! Se encontró 1 localidad coincidente:
#> # A tibble: 1 × 5
#>   nombre_region nombre_comuna localidad  tipo            subtipo          
#>   <chr>         <chr>         <chr>      <chr>           <chr>            
#> 1 Valparaíso    Olmué         La Dormida Localidad rural Parcela de agrado
#> ℹ Localidad encontrada: La Dormida, ubicada en la comuna de Olmué, Región de Valparaíso
#> ℹ Buscando localidad 'Mallarauco'
#> ! Se encontró 1 localidad coincidente:
#> # A tibble: 1 × 5
#>   nombre_region             nombre_comuna localidad  tipo            subtipo    
#>   <chr>                     <chr>         <chr>      <chr>           <chr>      
#> 1 Metropolitana de Santiago Peñaflor      Mallarauco Localidad rural Parcela de…
#> ℹ Localidad encontrada: Mallarauco, ubicada en la comuna de Peñaflor, Región Metropolitana de Santiago
#> [1] "Paine"    "Olmué"    "Peñaflor"

ubicar_localidades("Alfalfal")
#> ℹ Buscando localidad 'Alfalfal'
#> ! No se encontraron localidades coincidentes para 'Alfalfal'; buscando por coincidencia inexacta...
#> ! Se encontraron 0 localidades coincidentes por búsqueda inexacta:
#> # A tibble: 7 × 5
#>   nombre_region             nombre_comuna     localidad          tipo    subtipo
#>   <chr>                     <chr>             <chr>              <chr>   <chr>  
#> 1 Coquimbo                  La Serena         Colonia Alfalfares Locali… Parcel…
#> 2 Metropolitana de Santiago San José de Maipo El Alfalfal        Locali… Caserío
#> 3 Coquimbo                  La Serena         Alfalfares Oriente Locali… Parcel…
#> 4 Coquimbo                  La Serena         Alfalfares Oriente Locali… Parcel…
#> 5 Coquimbo                  La Serena         Colonia Alfalfares Locali… Parcel…
#> 6 Coquimbo                  Paihuano          La Alfalfa         Locali… Parcel…
#> 7 Metropolitana de Santiago San José de Maipo El Alfalfal        Locali… Parcel…
#> ℹ Retornando la primera localidad: Colonia Alfalfares, ubicada en la comuna de La Serena, Región de Coquimbo
#> [1] "La Serena"

# cuando se conoce el nombre de la región, se pueden mejorar los resultados:
ubicar_localidades("Alfalfal", nombre_region = "Metropolitana de Santiago")
#> ℹ Buscando localidad 'Alfalfal'
#> ! No se encontraron localidades coincidentes para 'Alfalfal'; buscando por coincidencia inexacta...
#> ! Se encontraron 0 localidades coincidentes por búsqueda inexacta:
#> # A tibble: 2 × 5
#>   nombre_region             nombre_comuna     localidad   tipo           subtipo
#>   <chr>                     <chr>             <chr>       <chr>          <chr>  
#> 1 Metropolitana de Santiago San José de Maipo El Alfalfal Localidad rur… Caserío
#> 2 Metropolitana de Santiago San José de Maipo El Alfalfal Localidad rur… Parcel…
#> ℹ Retornando la primera localidad: El Alfalfal, ubicada en la comuna de San José de Maipo, Región Metropolitana de Santiago
#> [1] "San José de Maipo"
```
