# Nombres de comunas de Chile

Vector de texto que contiene el nombre de las 346 comunas de Chile, tal
como aparecen en la tabla
[territorios](https://bastianolea.github.io/territorial/reference/territorios.md).

## Uso

``` r
comunas()
```

## Valor

Vector de nombres de comunas de Chile

## Ver también

[`codigos_comunas()`](https://bastianolea.github.io/territorial/reference/codigos_comunas.md)
para un vector de códigos únicos territoriales de comunas,
[`regiones()`](https://bastianolea.github.io/territorial/reference/regiones.md)
para un vector de regiones de Chile, y
[`provincias()`](https://bastianolea.github.io/territorial/reference/provincias.md)
para las provincias. Puedes usar
[`as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md)
para obtener códigos únicos territoriales (CUT) a partir de los nombres
de comunas.

## Ejemplos

``` r
comunas()
#>   [1] "Arica"                "Camarones"            "Putre"               
#>   [4] "General Lagos"        "Iquique"              "Alto Hospicio"       
#>   [7] "Pozo Almonte"         "Camiña"               "Colchane"            
#>  [10] "Huara"                "Pica"                 "Antofagasta"         
#>  [13] "Mejillones"           "Sierra Gorda"         "Taltal"              
#>  [16] "Calama"               "Ollagüe"              "San Pedro de Atacama"
#>  [19] "Tocopilla"            "María Elena"          "Copiapó"             
#>  [22] "Caldera"              "Tierra Amarilla"      "Chañaral"            
#>  [25] "Diego de Almagro"     "Vallenar"             "Alto del Carmen"     
#>  [28] "Freirina"             "Huasco"               "La Serena"           
#>  [31] "Coquimbo"             "Andacollo"            "La Higuera"          
#>  [34] "Paihuano"             "Vicuña"               "Illapel"             
#>  [37] "Canela"               "Los Vilos"            "Salamanca"           
#>  [40] "Ovalle"               "Combarbalá"           "Monte Patria"        
#>  [43] "Punitaqui"            "Río Hurtado"          "Valparaíso"          
#>  [46] "Casablanca"           "Concón"               "Juan Fernández"      
#>  [49] "Puchuncaví"           "Quintero"             "Viña del Mar"        
#>  [52] "Isla de Pascua"       "Los Andes"            "Calle Larga"         
#>  [55] "Rinconada"            "San Esteban"          "La Ligua"            
#>  [58] "Cabildo"              "Papudo"               "Petorca"             
#>  [61] "Zapallar"             "Quillota"             "Calera"              
#>  [64] "Hijuelas"             "La Cruz"              "Nogales"             
#>  [67] "San Antonio"          "Algarrobo"            "Cartagena"           
#>  [70] "El Quisco"            "El Tabo"              "Santo Domingo"       
#>  [73] "San Felipe"           "Catemu"               "Llaillay"            
#>  [76] "Panquehue"            "Putaendo"             "Santa María"         
#>  [79] "Quilpué"              "Limache"              "Olmué"               
#>  [82] "Villa Alemana"        "Santiago"             "Cerrillos"           
#>  [85] "Cerro Navia"          "Conchalí"             "El Bosque"           
#>  [88] "Estación Central"     "Huechuraba"           "Independencia"       
#>  [91] "La Cisterna"          "La Florida"           "La Granja"           
#>  [94] "La Pintana"           "La Reina"             "Las Condes"          
#>  [97] "Lo Barnechea"         "Lo Espejo"            "Lo Prado"            
#> [100] "Macul"                "Maipú"                "Ñuñoa"               
#> [103] "Pedro Aguirre Cerda"  "Peñalolén"            "Providencia"         
#> [106] "Pudahuel"             "Quilicura"            "Quinta Normal"       
#> [109] "Recoleta"             "Renca"                "San Joaquín"         
#> [112] "San Miguel"           "San Ramón"            "Vitacura"            
#> [115] "Puente Alto"          "Pirque"               "San José de Maipo"   
#> [118] "Colina"               "Lampa"                "Tiltil"              
#> [121] "San Bernardo"         "Buin"                 "Calera de Tango"     
#> [124] "Paine"                "Melipilla"            "Alhué"               
#> [127] "Curacaví"             "María Pinto"          "San Pedro"           
#> [130] "Talagante"            "El Monte"             "Isla de Maipo"       
#> [133] "Padre Hurtado"        "Peñaflor"             "Rancagua"            
#> [136] "Codegua"              "Coinco"               "Coltauco"            
#> [139] "Doñihue"              "Graneros"             "Las Cabras"          
#> [142] "Machalí"              "Malloa"               "Mostazal"            
#> [145] "Olivar"               "Peumo"                "Pichidegua"          
#> [148] "Quinta de Tilcoco"    "Rengo"                "Requínoa"            
#> [151] "San Vicente"          "Pichilemu"            "La Estrella"         
#> [154] "Litueche"             "Marchihue"            "Navidad"             
#> [157] "Paredones"            "San Fernando"         "Chépica"             
#> [160] "Chimbarongo"          "Lolol"                "Nancagua"            
#> [163] "Palmilla"             "Peralillo"            "Placilla"            
#> [166] "Pumanque"             "Santa Cruz"           "Talca"               
#> [169] "Constitución"         "Curepto"              "Empedrado"           
#> [172] "Maule"                "Pelarco"              "Pencahue"            
#> [175] "Río Claro"            "San Clemente"         "San Rafael"          
#> [178] "Cauquenes"            "Chanco"               "Pelluhue"            
#> [181] "Curicó"               "Hualañé"              "Licantén"            
#> [184] "Molina"               "Rauco"                "Romeral"             
#> [187] "Sagrada Familia"      "Teno"                 "Vichuquén"           
#> [190] "Linares"              "Colbún"               "Longaví"             
#> [193] "Parral"               "Retiro"               "San Javier"          
#> [196] "Villa Alegre"         "Yerbas Buenas"        "Chillán"             
#> [199] "Bulnes"               "Chillán Viejo"        "El Carmen"           
#> [202] "Pemuco"               "Pinto"                "Quillón"             
#> [205] "San Ignacio"          "Yungay"               "Quirihue"            
#> [208] "Cobquecura"           "Coelemu"              "Ninhue"              
#> [211] "Portezuelo"           "Ránquil"              "Trehuaco"            
#> [214] "San Carlos"           "Coihueco"             "Ñiquén"              
#> [217] "San Fabián"           "San Nicolás"          "Concepción"          
#> [220] "Coronel"              "Chiguayante"          "Florida"             
#> [223] "Hualqui"              "Lota"                 "Penco"               
#> [226] "San Pedro de la Paz"  "Santa Juana"          "Talcahuano"          
#> [229] "Tomé"                 "Hualpén"              "Lebu"                
#> [232] "Arauco"               "Cañete"               "Contulmo"            
#> [235] "Curanilahue"          "Los Álamos"           "Tirúa"               
#> [238] "Los Ángeles"          "Antuco"               "Cabrero"             
#> [241] "Laja"                 "Mulchén"              "Nacimiento"          
#> [244] "Negrete"              "Quilaco"              "Quilleco"            
#> [247] "San Rosendo"          "Santa Bárbara"        "Tucapel"             
#> [250] "Yumbel"               "Alto Biobío"          "Temuco"              
#> [253] "Carahue"              "Cunco"                "Curarrehue"          
#> [256] "Freire"               "Galvarino"            "Gorbea"              
#> [259] "Lautaro"              "Loncoche"             "Melipeuco"           
#> [262] "Nueva Imperial"       "Padre Las Casas"      "Perquenco"           
#> [265] "Pitrufquén"           "Pucón"                "Saavedra"            
#> [268] "Teodoro Schmidt"      "Toltén"               "Vilcún"              
#> [271] "Villarrica"           "Cholchol"             "Angol"               
#> [274] "Collipulli"           "Curacautín"           "Ercilla"             
#> [277] "Lonquimay"            "Los Sauces"           "Lumaco"              
#> [280] "Purén"                "Renaico"              "Traiguén"            
#> [283] "Victoria"             "Valdivia"             "Corral"              
#> [286] "Lanco"                "Los Lagos"            "Máfil"               
#> [289] "Mariquina"            "Paillaco"             "Panguipulli"         
#> [292] "La Unión"             "Futrono"              "Lago Ranco"          
#> [295] "Río Bueno"            "Puerto Montt"         "Calbuco"             
#> [298] "Cochamó"              "Fresia"               "Frutillar"           
#> [301] "Los Muermos"          "Llanquihue"           "Maullín"             
#> [304] "Puerto Varas"         "Castro"               "Ancud"               
#> [307] "Chonchi"              "Curaco de Vélez"      "Dalcahue"            
#> [310] "Puqueldón"            "Queilén"              "Quellón"             
#> [313] "Quemchi"              "Quinchao"             "Osorno"              
#> [316] "Puerto Octay"         "Purranque"            "Puyehue"             
#> [319] "Río Negro"            "San Juan de la Costa" "San Pablo"           
#> [322] "Chaitén"              "Futaleufú"            "Hualaihué"           
#> [325] "Palena"               "Coyhaique"            "Lago Verde"          
#> [328] "Aysén"                "Cisnes"               "Guaitecas"           
#> [331] "Cochrane"             "O'Higgins"            "Tortel"              
#> [334] "Chile Chico"          "Río Ibáñez"           "Punta Arenas"        
#> [337] "Laguna Blanca"        "Río Verde"            "San Gregorio"        
#> [340] "Cabo de Hornos"       "Antártica"            "Porvenir"            
#> [343] "Primavera"            "Timaukel"             "Natales"             
#> [346] "Torres del Paine"    
```
