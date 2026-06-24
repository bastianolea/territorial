# Ubicar comunas en la región que les corresponde

Para un vector de nombres de comuna o códigos comunales, retorna las
regiones donde se ubican dichas regiones.

## Uso

``` r
ubicar_comunas(nombre_comuna = NULL, codigo_comuna = NULL)
```

## Argumentos

- nombre_comuna:

  Nombres de comunas, como aparecen en
  [`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md)

- codigo_comuna:

  Códigos comunales, como aparecen en
  [territorios](https://bastianolea.github.io/territorial/reference/territorios.md)

## Valor

Vector con nombres de regiones correspondientes

## Ejemplos

``` r
ubicar_comunas(c("Cerrillos", "Navidad"))
#> [1] "Metropolitana de Santiago"            
#> [2] "Libertador General Bernardo O'Higgins"
```
