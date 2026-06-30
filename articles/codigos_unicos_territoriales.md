# Códigos Únicos Territoriales

``` r

library(territorial)
library(dplyr)
```

El Ministerio del Interior de Chile es el organismo encargado de
establecer la división política administrativa de Chile, y entre otras
tareas, esto implica la sistematización de una codificación única para
reconocer las regiones, provincias y comunas del país. La última
actualización fue en 2018, al incluirse la región de Ñuble.

Los códigos únicos territoriales son números que identifican de manera
única a las regiones, provincias y comunas de Chile. Son especialmente
útiles para poder trabajar con datos territoriales sin tener que estar
filtrando constantemente por nombres, que pueden ser largos, difíciles
de escirbir, o derechamente incorrectos. Por eso, al trabajar con datos
se prefiere operar sobre los códigos únicos territoriales para eliminar
posibilidades de error.

El paquete [territorial](https://bastianolea.github.io/territorial)
incluye la tabla de datos `territorios`, que presenta los códigos únicos
territoriales de regiones, provincias y comunas, junto a sus nombres
oficiales.

## Regiones

Las **regiones** se identifican con un código entre 1 y 16, siendo 1
Tarapacá, 16 Ñuble, y 13 la Región Metropolitana.

``` r

territorial::territorios |> 
  select(ends_with("region")) |> 
  distinct() |> 
  print(n = Inf)
#> # A tibble: 16 × 2
#>    codigo_region nombre_region                            
#>            <dbl> <chr>                                    
#>  1             1 Tarapacá                                 
#>  2             2 Antofagasta                              
#>  3             3 Atacama                                  
#>  4             4 Coquimbo                                 
#>  5             5 Valparaíso                               
#>  6             6 Libertador General Bernardo O'Higgins    
#>  7             7 Maule                                    
#>  8             8 Biobío                                   
#>  9             9 La Araucanía                             
#> 10            10 Los Lagos                                
#> 11            11 Aysén del General Carlos Ibáñez del Campo
#> 12            12 Magallanes y de la Antártica Chilena     
#> 13            13 Metropolitana de Santiago                
#> 14            14 Los Ríos                                 
#> 15            15 Arica y Parinacota                       
#> 16            16 Ñuble
```

## Provincias

Las **provincias** toman el código de la región a la que pertenecen, y
le agregan un dígito al final. Por ejemplo, en la Región Metropolitana
(región de código 13) existen 6 provincias, siendo la provincia de
Santiago la de código 131 (región 13, provincia 1), la provincia
Cordillera código 132 (región 13, provincia 2), etc.

``` r

territorial::territorios |> 
  filter(codigo_region == 13) |> 
  select(ends_with("provincia")) |> 
  distinct()
#> # A tibble: 6 × 2
#>   codigo_provincia nombre_provincia
#>              <dbl> <chr>           
#> 1              131 Santiago        
#> 2              132 Cordillera      
#> 3              133 Chacabuco       
#> 4              134 Maipo           
#> 5              135 Melipilla       
#> 6              136 Talagante
```

## Comunas

Las **comunas** de Chile poseen códigos únicos territoriales que van del
1101 (región 1, provincia 1, comuna `01`, correspondiente a *Iquique*)
al 16305 (región 15, provincia 3, comuna `05`, comuna de *San Nicolás*).
Por ejemplo, las comunas de la región de Tarapacá son:

``` r

territorial::territorios |> 
  filter(nombre_region == "Tarapacá") |> 
  select(ends_with("comuna"), ends_with("provincia"))
#> # A tibble: 7 × 4
#>   codigo_comuna nombre_comuna codigo_provincia nombre_provincia
#>           <dbl> <chr>                    <dbl> <chr>           
#> 1          1101 Iquique                     11 Iquique         
#> 2          1107 Alto Hospicio               11 Iquique         
#> 3          1401 Pozo Almonte                14 Tamarugal       
#> 4          1402 Camiña                      14 Tamarugal       
#> 5          1403 Colchane                    14 Tamarugal       
#> 6          1404 Huara                       14 Tamarugal       
#> 7          1405 Pica                        14 Tamarugal
```

## Referencias

- [Decreto Exento N° 1.115 del Ministerio del Interior y Seguridad
  Pública que actualiza los códigos
  territoriales](https://www.subdere.gov.cl/sites/default/files/documentos/DTO-1115-SEPT_2018.pdf)
- [Subdere: Códigos Únicos Territoriales - Actualizado al
  2018](https://www.subdere.gov.cl/documentacion/c%C3%B3digos-%C3%BAnicos-territoriales-actualizados-al-06-de-septiembre-2018)
- [Gobierno digital: plataforma
  Codificador](https://codificador.digital.gob.cl/codificaciones-del-estado/codigos-unicos-territoriales)
