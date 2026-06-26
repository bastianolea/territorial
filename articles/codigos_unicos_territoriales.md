# Códigos Únicos Territoriales

``` r

library(territorial)
library(dplyr)
```

*En construcción*

``` r

territorial::territorios |> 
  select(starts_with("codigo"))
#> # A tibble: 346 × 3
#>    codigo_region codigo_provincia codigo_comuna
#>            <dbl>            <dbl>         <dbl>
#>  1             1               11          1101
#>  2             1               11          1107
#>  3             1               14          1401
#>  4             1               14          1402
#>  5             1               14          1403
#>  6             1               14          1404
#>  7             1               14          1405
#>  8             2               21          2101
#>  9             2               21          2102
#> 10             2               21          2103
#> # ℹ 336 more rows
```
