# Prueba de suciedad extrema

Una de las utilidades principales del paquete
[territorial](https://bastianolea.github.io/territorial) es poder
[limpiar automáticamente las
comunas](https://bastianolea.github.io/territorial/reference/limpiar_comunas.html)
de una base de datos que venga con datos sucios: comunas mal escritas,
en mayúsculas, sin tildes, sin eñes, etc.

En este ejemplo, probaremos la función
[`territorial::limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
con un caso extremo de datos intencionalmente sucios.

``` r

library(territorial)
library(dplyr)

set.seed(1234)
```

Crearemos una tabla con nombres de comunas ensuciados, a partir de la
tabla `territorios` que viene con el paquete, y usando algunas funciones
utilitarias [inspiradas en el paquete
`{messy}`](https://nrennie.rbind.io/messy/) para ensuciar los datos.

``` r

sucios <- territorios |> 
  select(nombre_comuna) |> 
  mutate(nombres_sucios = nombre_comuna |> 
      territorial:::reemplazar_texto(porcentaje = 0.1) |>
      territorial:::eliminar_texto(porcentaje = 0.1) |>
      territorial:::insertar_texto(porcentaje = 0.1)
  ) |> 
  filter_out(nombre_comuna == nombres_sucios) # excluir los que no se ensuciaron por azar
```

Como sus nombres lo indican, estas funciones reemplazan, eliminan e
insertan texto aleatoriamente, para simular errores de escritura, datos
corruptos, u otros problemas de calidad de datos.

Así queda una muestra de los datos sucios:

``` r

sucios |> 
  slice_sample(n = 10)
```

    # A tibble: 10 × 2
       nombre_comuna    nombres_sucios
       <chr>            <chr>
     1 Juan Fernández   dJuan erYández
     2 Santo Domingo    SantoWDomiJno
     3 Nueva Imperial   Nueva IWeTrial
     4 Calle Larga      ColleLargaP
     5 La Estrella      Lat Estrell
     6 Casablanca       Cawablaca
     7 Torres del Paine Yorres de PaineE
     8 Alto Hospicio    lto Hvospvcio
     9 La Cisterna      La CiEsteja
    10 San Gregorio     ISanJGregoro    

Ahora que tenemos la columna `nombres_sucios`, usamos
[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
para limpiar los datos, creando la columna `nombres_limpios`:

``` r

limpios <- sucios |> 
  mutate(nombres_limpios = limpiar_comunas(nombres_sucios))
```

Ahora veamos el resultado de esta prueba de limpieza extrema:

``` r

limpios |> 
  select(nombres_sucios, nombres_limpios) |> 
  print(n = 30)
```

    # A tibble: 109 × 2
       nombres_sucios      nombres_limpios
       <chr>               <chr>
     1 nGeneral Lagp       General Lagos
     2 lto Hvospvcio       Alto Hospicio
     3 PozoRoAlmnte        Pozo Almonte
     4 AnofagKaeta         Antofagasta
     5 Mejilpone           Mejillones
     6 SieHa GordaA        Sierra Gorda
     7 San Pmnoro dAtacama San Pedro de Atacama
     8 arna ElenaZ         María Elena
     9 Tiera AVmarilda     Tierra Amarilla
    10 DiXeuo de Almgro    Diego de Almagro
    11 Alto det arwmen     Alto del Carmen
    12 La Hiucra           La Higuera
    13 ComEarblá           Combarbalá
    14 Mnte PaJteia        Monte Patria
    15 RUo Hutasdo         Río Hurtado
    16 Vlparatso           Valparaíso
    17 Cawablaca           Casablanca
    18 dJuan erYández      Juan Fernández
    19 PuchuJcaí           Puchuncaví
    20 ViñadeFn Mar        Viña del Mar
    21 Isla de PmQscu      Isla de Pascua
    22 ColleLargaP         Calle Larga
    23 SaQn Wteban         San Esteban
    24 San UAYtoni         San Antonio
    25 SantoWDomiJno       Santo Domingo
    26 han Felie           San Felipe
    27 Sana MarqaW         Santa María
    28 Vvila Alemhna       Villa Alemana
    29 erro NamvFa         Cerro Navia
    30 staEción Centrvl    Estación Central
    # ℹ 79 more rows

Podemos confirmar que la limpieza realizada con
[`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
es capaz de abarcar casos muy extremos: por ejemplo, identifica que
`SvnMPmedro d Atacaa` es *San Pedro de Atacama*, o que `SanaWMaríaW` es
*Santa María*, por lo que la función podría resultar apropiada para
detección de datos escritos a mano o de documentos antiguos procesados
con OCR.

A este nivel de dificultad, la limpieza no siempre es 100% correcta.

``` r

problemas <- limpios |> 
  filter(is.na(nombres_limpios) | nombre_comuna != nombres_limpios)
```

Luego de esta limpieza, quedaron 0 casos donde los nombres limpios se
dedujeron incorrectamente a partir de los nombres sucios:

``` r

problemas
```

    # A tibble: 0 × 3
    # ℹ 3 variables: nombre_comuna <chr>, nombres_sucios <chr>,
    #   nombres_limpios <chr>
