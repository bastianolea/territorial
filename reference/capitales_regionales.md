# Capitales regionales de Chile

Tabla de datos basada en
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md)
que contiene las comunas donde están ubicadas las capitales regionales
de cada región.

## Uso

``` r
capitales_regionales()
```

## Valor

*Dataframe* de 16 filas

## Ver también

Para ver todas las comunas, regiones y provincias de Chile, usa
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md).
Usa
[`regiones()`](https://bastianolea.github.io/territorial/reference/regiones.md)
para un vector con todas las regiones, o
[`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md)
para un vector con todas las comunas de Chile.

## Ejemplos

``` r

capitales_regionales()
#> # A tibble: 16 × 6
#>    codigo_region nombre_region   codigo_provincia nombre_provincia codigo_comuna
#>            <dbl> <chr>                      <dbl> <chr>                    <dbl>
#>  1            15 Arica y Parina…              151 Arica                    15101
#>  2             1 Tarapacá                      11 Iquique                   1101
#>  3             2 Antofagasta                   21 Antofagasta               2101
#>  4             3 Atacama                       31 Copiapó                   3101
#>  5             4 Coquimbo                      41 Elqui                     4102
#>  6             5 Valparaíso                    51 Valparaíso                5101
#>  7            13 Metropolitana …              131 Santiago                 13101
#>  8             6 Libertador Gen…               61 Cachapoal                 6101
#>  9             7 Maule                         71 Talca                     7101
#> 10            16 Ñuble                        161 Diguillín                16101
#> 11             8 Biobío                        81 Concepción                8101
#> 12             9 La Araucanía                  91 Cautín                    9101
#> 13            14 Los Ríos                     141 Valdivia                 14101
#> 14            10 Los Lagos                    101 Llanquihue               10101
#> 15            11 Aysén del Gene…              111 Coyhaique                11101
#> 16            12 Magallanes y d…              121 Magallanes               12101
#> # ℹ 1 more variable: nombre_comuna <chr>
```
