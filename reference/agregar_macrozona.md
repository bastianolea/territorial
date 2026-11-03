# Agregar macrozona del país a regiones

Las macrozonas son agrupaciones de regiones de Chile que permiten
entender el territorio en base a grupos geográficos. Para un vector de
códigos de regiones (del 1 al 16), entrega las macrozonas
correspondientes a cada región.

## Uso

``` r
agregar_macrozona(codigo_region, tipo = 1, ordenar = TRUE)
```

## Argumentos

- codigo_region:

  Vector de códigos de región (del 1 al 16) o de nombres de región (ver
  [`as_codigo_region()`](https://bastianolea.github.io/territorial/reference/as_codigo_region.md)),
  que se convierten automáticamente a códigos. También puede ser un data
  frame con la columna `codigo_region`, en cuyo caso se retorna el data
  frame con la columna nueva `macrozona`.

- tipo:

  Tipo de macrozonas a aplicar. Por defecto se usa el tipo 1. Ver la
  documentación más arriba.

- ordenar:

  Entregar resultados como un factor ordenado (de norte a sur), o como
  textos sin orden. Por defecto entrega factor.

## Valor

Factor con macrozonas regionales, de acuerdo al tipo de clasificación de
regiones elegido. Si la entrada es un data frame, retorna el data frame
con la columna `macrozona` agregada.

## Detalles

Como no existe una clasificación fija de macrozonas, existen varias
alternativas para elegir:

- Macrozonas tipo 1: desde Arica a Coquimbo son *Norte*, desde
  Valparaíso a Maule *Centro*, desde Ñuble a Los Lagos *Sur*, y desde
  Aysén a Magallanes *Austral*.

- Macrozonas tipo 2: distribución balanceada por cantidad de regiones: 4
  grupos de 4 regiones: *Norte*, *Centro*, *Centro/sur* y *Sur*.

- Macrozonas tipo 3: según las macrozonas del Ministerio de Ciencia,
  Tecnología, Conocimiento e Innovación, que definr 5 macrozonas
  (*Norte, Centro, Centro sur, Sur,* y *Austral*), y excluye a la Región
  Metropolitana. Para más información, \#' [revisar el
  decreto](https://www.bcn.cl/leychile/navegar?idNorma=1142798) que
  establece a las Seremis del ministerio de Ciencia.

- Macrozonas tipo 4: basadas en el [programa curricular de educación
  básica](https://es.wikipedia.org/wiki/Regiones_naturales_de_Chile) del
  Ministerio de Educación de Chile, existirían *Norte grande, Norte
  chico, Zona central, Zona sur* y *Zona austral*.

- Macrozonas tipo 5: dividen al país en *norte, centro* y *sur* según
  las agrupaciones del estudio Identificación de Localidades en
  Condición de Aislamiento 2012, de Subdere.

## Ver también

[`ordenar_regiones()`](https://bastianolea.github.io/territorial/reference/ordenar_regiones.md)
para ordenar regiones de norte a sur, y
[`agregar_clasificacion()`](https://bastianolea.github.io/territorial/reference/agregar_clasificacion.md)
para clasificar comunas en urbanas, mixtas o rurales. Si no tienes
códigos de región, usa
[`as_codigo_region()`](https://bastianolea.github.io/territorial/reference/as_codigo_region.md)
o
[`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md).

## Ejemplos

``` r
agregar_macrozona(c(15, 13, 12), tipo = 1)
#> [1] Norte   Centro  Austral
#> Levels: Norte Centro Sur Austral

# con un data frame, usa `codigo_region` o `codigo_comuna`
territorios |>
  agregar_macrozona(tipo = 2)
#> # A tibble: 346 × 7
#>    codigo_region nombre_region codigo_provincia nombre_provincia codigo_comuna
#>            <dbl> <chr>                    <dbl> <chr>                    <dbl>
#>  1             1 Tarapacá                    11 Iquique                   1101
#>  2             1 Tarapacá                    11 Iquique                   1107
#>  3             1 Tarapacá                    14 Tamarugal                 1401
#>  4             1 Tarapacá                    14 Tamarugal                 1402
#>  5             1 Tarapacá                    14 Tamarugal                 1403
#>  6             1 Tarapacá                    14 Tamarugal                 1404
#>  7             1 Tarapacá                    14 Tamarugal                 1405
#>  8             2 Antofagasta                 21 Antofagasta               2101
#>  9             2 Antofagasta                 21 Antofagasta               2102
#> 10             2 Antofagasta                 21 Antofagasta               2103
#> # ℹ 336 more rows
#> # ℹ 2 more variables: nombre_comuna <chr>, macrozona <fct>

territorios |>
  dplyr::distinct(codigo_region, nombre_region) |>
  ordenar_regiones() |>
  dplyr::mutate(
    macrozona_1 = agregar_macrozona(codigo_region, tipo = 1),
    macrozona_2 = agregar_macrozona(codigo_region, tipo = 2),
    macrozona_3 = agregar_macrozona(codigo_region, tipo = 3),
    macrozona_4 = agregar_macrozona(codigo_region, tipo = 4)
 )
#> # A tibble: 16 × 6
#>    codigo_region nombre_region   macrozona_1 macrozona_2 macrozona_3 macrozona_4
#>            <dbl> <fct>           <fct>       <fct>       <fct>       <fct>      
#>  1            15 Arica y Parina… Norte       Norte       Norte       Norte Gran…
#>  2             1 Tarapacá        Norte       Norte       Norte       Norte Gran…
#>  3             2 Antofagasta     Norte       Norte       Norte       Norte Gran…
#>  4             3 Atacama         Norte       Norte       Norte       Norte Chico
#>  5             4 Coquimbo        Norte       Centro      Centro      Norte Chico
#>  6             5 Valparaíso      Centro      Centro      Centro      Norte Chico
#>  7            13 Metropolitana … Centro      Centro      Metropolit… Zona centr…
#>  8             6 Libertador Gen… Centro      Centro      Centro sur  Zona centr…
#>  9             7 Maule           Centro      Centro/sur  Centro sur  Zona centr…
#> 10            16 Ñuble           Sur         Centro/sur  Centro sur  Zona centr…
#> 11             8 Biobío          Sur         Centro/sur  Centro sur  Zona centr…
#> 12             9 La Araucanía    Sur         Centro/sur  Sur         Zona Sur   
#> 13            14 Los Ríos        Sur         Sur         Sur         Zona Sur   
#> 14            10 Los Lagos       Sur         Sur         Sur         Zona Sur   
#> 15            11 Aysén del Gene… Austral     Sur         Austral     Zona Austr…
#> 16            12 Magallanes y d… Austral     Sur         Austral     Zona Austr…
```
