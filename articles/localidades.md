# Localidades

Según la definición del INE, una localidad es un “Área geográfica con
nombre propio de conocimiento generalizado por la población. Puede estar
poblada o no, aunque debe contener, a lo menos, una vivienda susceptible
de ser habitada. Generalmente, se circunscribe dentro de un distrito
censal; no obstante, puede rebasar a éste.”

En el paquete [territorial](https://bastianolea.github.io/territorial),
la tabla
[`territorial::localidades`](https://bastianolea.github.io/territorial/reference/localidades.md)
contiene una lista de todas las localidades de Chile, en base a la
información del [estudio de **Identificación de localidades en condición
de
aislamiento**](https://ide.subdere.gov.cl/estudio-actualizacion-de-base-censal-identificacion-de-localidades-en-condicion-de-aislamiento/),
realizado por la [Subsecretaría de Desarrollo Regional y
Administrativo](https://ide.subdere.gov.cl) y publicado el año 2021.

``` r

library(territorial)
library(dplyr)
```

``` r

territorial::localidades
#> # A tibble: 29,256 × 6
#>    codigo_comuna localidad              tipo        subtipo habitantes viviendas
#>            <dbl> <chr>                  <chr>       <chr>        <dbl>     <dbl>
#>  1          1101 Indeterminada          Localidad … Indete…         30        12
#>  2          1101 Río Seco               Localidad … Caserío        131       117
#>  3          1101 Cholito                Localidad … Asenta…          2         2
#>  4          1101 Complejo Aduana El Loa Localidad … Parcel…          0         1
#>  5          1101 Caleta San Marcos      Localidad … Asenta…        259       153
#>  6          1101 Caleta Chipana         Localidad … Caserío         84        57
#>  7          1101 Ike Ike                Localidad … Asenta…         29        11
#>  8          1101 Indeterminada          Localidad … Indete…         11         7
#>  9          1101 Piedra Polo            Localidad … Asenta…          5         7
#> 10          1101 Altos de Río Seco      Localidad … Caserío         14        13
#> # ℹ 29,246 more rows
```

Esta tabla puede ser ampliada en sus columnas territoriales usando la
función
[`territorial::contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md),
para agregar las comunas, regiones y provincias correspondientes a cada
localidad:

``` r

territorial::localidades |> 
  contextualizar(codigo_comuna) |> 
  glimpse()
#> ℹ columnas agregadas: codigo_region, nombre_region, codigo_provincia, nombre_provincia y nombre_comuna
#> Rows: 29,256
#> Columns: 11
#> $ codigo_region    <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
#> $ nombre_region    <chr> "Tarapacá", "Tarapacá", "Tarapacá", "Tarapacá", "Tara…
#> $ codigo_provincia <dbl> 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 1…
#> $ nombre_provincia <chr> "Iquique", "Iquique", "Iquique", "Iquique", "Iquique"…
#> $ codigo_comuna    <dbl> 1101, 1101, 1101, 1101, 1101, 1101, 1101, 1101, 1101,…
#> $ nombre_comuna    <chr> "Iquique", "Iquique", "Iquique", "Iquique", "Iquique"…
#> $ localidad        <chr> "Indeterminada", "Río Seco", "Cholito", "Complejo Adu…
#> $ tipo             <chr> "Localidad rural", "Localidad rural", "Localidad rura…
#> $ subtipo          <chr> "Indeterminada", "Caserío", "Asentamiento minero", "P…
#> $ habitantes       <dbl> 30, 131, 2, 0, 259, 84, 29, 11, 5, 14, 16, 63, 216, 2…
#> $ viviendas        <dbl> 12, 117, 2, 1, 153, 57, 11, 7, 7, 13, 2, 35, 97, 1, 1…
```

Si se tiene el nombre de una localidad de Chile, y se de sea conocer
dónde está ubicada, existe la función
[`territorial::ubicar_localidades()`](https://bastianolea.github.io/territorial/reference/ubicar_localidades.md):

``` r

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
```

## Referencias

- [Infraestructura de Datos Geoespaciales, Subsecretaría de Desarrollo
  Regional y Administrativo (IDE Subdere)](https://ide.subdere.gov.cl)
- [Identificación de localidades en condición de
  aislamiento](https://ide.subdere.gov.cl/wp-content/uploads/2023/11/EABC-ILCA-2021-2.pdf)
  (en PDF)

## Agradecimientos

- Matías Poch Clavero, profesional de la Unidad de Investigación
  Territorial, Subsecretaría de Desarrollo Regional y Administrativo
