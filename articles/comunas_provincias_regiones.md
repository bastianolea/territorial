# Comunas, provincias y regiones de Chile

El paquete `territorial` incluye una tabla de todas las comunas y
regiones del país, junto a sus provincias y los [códigos únicos
territoriales](https://bastianolea.github.io/territorial/articles/codigos_unicos_territoriales.html)
de cada uno.

A continuación se entrega una tabla interactiva con todas las comunas de
Chile al 2027, obtenida mediante
[`territorial::territorios`](https://bastianolea.github.io/territorial/reference/territorios.md).
Los datos provienen de Subdere, Ministerio del Interior de Chile,
publicados en el Diario Oficial el 21 de septiembre de 2018, con [leves
modificaciones](https://bastianolea.github.io/territorial/reference/territorios.html#detalles)
para corregir algunos nombres de comunas.

Puedes ordenar las columnas o **buscar** cualquier comuna, provincia o
región.

Ver código de la tabla

``` r

library(territorial)
library(DT)

territorios |> 
  datatable(
    class = "tabla_dt",
    options = list(
      ordering = TRUE,
      pageLength = 20,
      columnDefs = list(
        list(
          targets = '_all',
          className = 'dt-head-compact'
        )
      ),
      dom = 'Bfrtip',
      # traducir tabla datatable al español
      language = list(
        info = paste0(
          '_TOTAL_ comunas en total, mostrando del _START_ al _END_'
        ),
        paginate = list(
          previous = 'Anterior',
          `next` = 'Siguiente',
          fist = "Primera",
          last = "Última"
        ),
        search = "Buscar:",
        lengthMenu = paste("Mostrar _MENU_ comunas"),
        emptyTable = paste("No hay comunas con datos"),
        infoEmpty = paste("Mostrando 0 comunas"),
        zeroRecords = "Sin resultados",
        infoFiltered = paste0(
          "(filtrando de un total de _MAX_ comunas)"
        )
      )
    ),
    selection = "single",
    rownames = FALSE,
    # nombres de columnas
    colnames = c("Código región", "Region", 
                 "Código provincia", "Provincia", 
                 "Código comuna", "Comuna")
  )
```

[Descargar tabla en
Excel](https://github.com/bastianolea/territorial/blob/main/data-raw/territorial_chile.xlsx?raw=true)
