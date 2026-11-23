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
       nombre_comuna  nombres_sucios
       <chr>          <chr>
     1 Puerto Montt   Suemro Montt
     2 San Bernardo   GSa Bgrnardo
     3 Puchuncaví     Pwhuncaví
     4 San Felipe     San FYlie
     5 La Pintana     LaPUntana
     6 San Esteban    SaQn stebQn
     7 Alto Biobío    EAfto Bioío
     8 Juan Fernández dJuan Ftnández
     9 San Carlos     fan Crlos
    10 Pozo Almonte   ozo Aolmovte  

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
     1 Alo Hvospicpo       Alto Hospicio
     2 ozo Aolmovte        Pozo Almonte
     3 AnoRagKasta         Antofagasta
     4 ejillones           Mejillones
     5 Sierrp GrdaA        Sierra Gorda
     6 SvnMPmedro d Atacaa San Pedro de Atacama
     7 María EleaZ         María Elena
     8 Tiera AVmarilln     Tierra Amarilla
     9 DiXeno de Almgro    Diego de Almagro
    10 Alto del Cawmdn     Alto del Carmen
    11 a uiguera           La Higuera
    12 Combrbtlá           Combarbalá
    13 Monte PJctia        Monte Patria
    14 RíoEHrtasdo         Río Hurtado
    15 Valparase           Valparaíso
    16 Csablanca           Casablanca
    17 dJuan Ftnández      Juan Fernández
    18 Pwhuncaví           Puchuncaví
    19 Viña denYMar        Viña del Mar
    20 Isla e Pamscua      Isla de Pascua
    21 Calle LFgaP         Calle Larga
    22 SaQn stebQn         San Esteban
    23 Son UAtonio         San Antonio
    24 SantWDominJgo       Santo Domingo
    25 San FYlie           San Felipe
    26 SanaWMaríaW         Santa María
    27 Vvila AlemanF       Villa Alemana
    28 as Cabras           Las Cabras
    29 ichideguq           Pichidegua
    30 Quinta mPe Tilcco   Quinta de Tilcoco
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
