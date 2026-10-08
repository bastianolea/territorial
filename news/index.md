# Registro de cambios

## territorial 0.9.3 (2026/10/08)

- Mejora de tests para que sean más legibles, uso de
  [`anyNA()`](https://rdrr.io/r/base/NA.html) en lugar de
  `any(is.na())`, `&&` en lugar de `&`, y mejora en descripción del
  paquete (todas mejoras gracias a comentarios de [Maëlle
  Salmon](https://masalmon.eu)!)

## territorial 0.9.2 (2026/10/07)

- Corrección de problema con
  [`acortar_regiones()`](https://bastianolea.github.io/territorial/reference/acortar_regiones.md):
  ahora funciona con tablas de datos asumiendo que existe la columna
  `nombre_region`, y mejoras en funcionalidad de acortar nombres.
- Corrección de error en
  [`acortar_regiones()`](https://bastianolea.github.io/territorial/reference/acortar_regiones.md),
  [`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
  y
  [`limpiar_regiones()`](https://bastianolea.github.io/territorial/reference/limpiar_regiones.md)
  al recibir columnas o vectores de tipo factor (por ejemplo, tras usar
  [`ordenar_regiones()`](https://bastianolea.github.io/territorial/reference/ordenar_regiones.md)).
  Ahora se convierten correctamente a texto, advirtiendo que se perderá
  el orden de los niveles del factor.

## territorial 0.9.1 (2026/08/18)

- Nueva función
  [`obtener_comunas()`](https://bastianolea.github.io/territorial/reference/obtener_comunas.md)
  para recibir las comunas que forman parte de una o más regiones
- Mejoras en mensajes de algunas funciones
- Más contenido en la [viñeta
  principal](https://bastianolea.github.io/territorial/articles/territorial.html)
  del paquete

## territorial 0.9 (2026/08/16)

- Nueva función
  [`limpiar_regiones()`](https://bastianolea.github.io/territorial/reference/limpiar_regiones.md),
  que funciona igual a
  [`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
  pero para las regiones de Chile, en versiones largas o cortas
- Mejoras significativas en
  [`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
  y
  [`limpiar_regiones()`](https://bastianolea.github.io/territorial/reference/limpiar_regiones.md)
  al elegir entre nombres muy sucios que se parecen a varioas
  comunas/regiones válidas
- Pruebas de funcionamiento mucho más estrictas para
  [`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
  y
  [`limpiar_regiones()`](https://bastianolea.github.io/territorial/reference/limpiar_regiones.md)
  usando [el paquete `{messy}` para ensuciar los
  datos](https://nrennie.rbind.io/messy/) en distintos niveles: eliminar
  e insertar caracteres al azar, etc.
- Mejora de limpieza en
  [`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
  para eliminar “Ilustre Municipalidad” y textos similares en nombres de
  comunas
- Mejoras en
  [`agregar_macrozona()`](https://bastianolea.github.io/territorial/reference/agregar_macrozona.md)
  y en tests de
  [`agregar_macrozona()`](https://bastianolea.github.io/territorial/reference/agregar_macrozona.md),
  [`ubicar_comunas()`](https://bastianolea.github.io/territorial/reference/ubicar_comunas.md)
  y
  [`redactar_region()`](https://bastianolea.github.io/territorial/reference/redactar_region.md)

## territorial 0.8.13 (2026/08/14)

- Mejoras en
  [`preposicion_region()`](https://bastianolea.github.io/territorial/reference/preposicion_region.md)
  para formas alternativas de escribir regiones
- Mejoras en viñetas
- Menos mensajes irrelevantes en
  [`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md).

## territorial 0.8.12 (2026/08/12)

- Nueva función
  [`contar_comunas()`](https://bastianolea.github.io/territorial/reference/contar_comunas.md)
  para revisar rápidamente si faltan comunas en una tabla de datos o
  vector, o confirmar que estén todas.
- Menos mensajes irrelevantes en
  [`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md).
- Se eliminan `poblacion_proyeccion` y `agregar_poblacion()` porque se
  traspasan al [nuevo paquete `{poblador}` especializado en datos de
  población de Chile.](https://bastianolea.github.io/poblador/)

## territorial 0.8.11 (2026/08/11)

- Nueva función
  [`buscar_comuna()`](https://bastianolea.github.io/territorial/reference/buscar_comuna.md),
  que facilita la búsqueda de comunas por texto parcial o inexacto en
  cualquier tabla de datos, o por defecto en
  [`territorial::territorios`](https://bastianolea.github.io/territorial/reference/territorios.md).
- Agregados ejemplos a
  [`as_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/as_nombre_comuna.md)
  y
  [`as_nombre_region()`](https://bastianolea.github.io/territorial/reference/as_nombre_region.md),
  gracias a `pkgcheck::pkgcheck()`

## territorial 0.8.9.2 (2026/08/06)

- Corrección de función
  [`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md)
  para arrojar error en caso de recibir listas
- Corrección de comuna mal escrita! Qué bochorno
- Nuevos tests para
  [`comunas()`](https://bastianolea.github.io/territorial/reference/comunas.md),
  para evitar nuevos bochornos
- Más tests para
  [`agregar_macrozona()`](https://bastianolea.github.io/territorial/reference/agregar_macrozona.md)
  y
  [`acortar_regiones()`](https://bastianolea.github.io/territorial/reference/acortar_regiones.md)

## territorial 0.8.9 (2026/07/30)

- Las funciones
  [`contextualizar()`](https://bastianolea.github.io/territorial/reference/contextualizar.md),
  [`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md),
  [`validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md)
  y
  [`validar_regiones()`](https://bastianolea.github.io/territorial/reference/validar_regiones.md)
  ahora son más flexibles: se pueden usar sin especificar ningún
  argumento y asumirán que queremos validar las columnas `nombre_comuna`
  o `nombre_region` respectivamente, entregando mejores avisos y
  errores.
- Nuevos tests para confirmar que
  [`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
  funciona bien.
- Nuevo argumento para
  [`ordenar_regiones()`](https://bastianolea.github.io/territorial/reference/ordenar_regiones.md)
  en orden inverso, útil para algunas visualizaciones de datos.

## territorial 0.8.7 (2026/07/10)

- Tabla de datos con población comunal proyectada (2002-2035), base
  Censo 2017: `territorial::poblacion_proyeccion` (Nota: función
  removida y trasladada [al paquete
  `{poblador}`)](https://bastianolea.github.io/poblador/)
- Función para agregar población comunal a comunas:
  `territorial::agregar_poblacion()`

## territorial 0.8.6 (2026/07/08)

- Nueva función
  [`as_nombre_region()`](https://bastianolea.github.io/territorial/reference/as_nombre_region.md)
  para convertir códigos de región (del 1 al 16) a nombres de región, y
  [`as_codigo_region()`](https://bastianolea.github.io/territorial/reference/as_codigo_region.md)
  para convertir nombres de región a códigos de región.
- Mejora en
  [`limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
  para casos de comunas con nombres que contienen sólo números

## territorial 0.8.5 (2026/07/06)

- Funciones
  [`agregar_macrozona()`](https://bastianolea.github.io/territorial/reference/agregar_macrozona.md)
  y
  [`agregar_clasificacion()`](https://bastianolea.github.io/territorial/reference/agregar_clasificacion.md)
  ahora entregan sus resultados en factores ordenados (para poder
  ordenar de norte a sur, o para tener las clasificaciones en orden).

## territorial 0.8.4 (2026/07/03)

- Nueva función
  [`agregar_macrozona()`](https://bastianolea.github.io/territorial/reference/agregar_macrozona.md)
  para clasificar regiones de Chile, incluyendo 4 tipos de macrozonas
- Nueva función
  [`acortar_regiones()`](https://bastianolea.github.io/territorial/reference/acortar_regiones.md)
  para acortar el nombre de las regiones de Chile

## territorial 0.8.3 (2026/07/02)

- Mejores avisos y errores en
  [`territorial::is_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/is_nombre_comuna.md),
  [`territorial::as_nombre_comuna()`](https://bastianolea.github.io/territorial/reference/as_nombre_comuna.md),
  [`territorial::is_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/is_codigo_comuna.md)
  y
  [`territorial::as_codigo_comuna()`](https://bastianolea.github.io/territorial/reference/as_codigo_comuna.md)

## territorial 0.8.2 (2026/07/01)

- Se agregan pasos para limpiar casos especiales en
  [`territorial::limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
- Nuevos artículos con casos de uso
- Viñetas con explicaciones de conceptos

## territorial 0.8.0

- Nueva función
  [`territorial::ubicar_localidades()`](https://bastianolea.github.io/territorial/reference/ubicar_localidades.md)
- Mejoras en funciones
  [`territorial::validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md)
  y
  [`territorial::validar_regiones()`](https://bastianolea.github.io/territorial/reference/validar_regiones.md)

## territorial 0.7.7

- Mejoras en documentación de funciones
- Nuevas viñetas
- Corrección de lista de comunas

## territorial 0.7.7

- Mejoras en pruebas unitarias
- Mejoras en documentación de funciones

## territorial 0.7.0

- Nueva función
  [`territorial::limpiar_comunas()`](https://bastianolea.github.io/territorial/reference/limpiar_comunas.md)
- Mejoras en pruebas unitarias

## territorial 0.4.0

- Nueva función
  [`territorial::validar_comunas()`](https://bastianolea.github.io/territorial/reference/validar_comunas.md)
- Nueva función
  [`territorial::abreviar_comunas()`](https://bastianolea.github.io/territorial/reference/abreviar_comunas.md)
- Nueva función
  [`territorial::ubicar_comunas()`](https://bastianolea.github.io/territorial/reference/ubicar_comunas.md)

## territorial 0.2.0

- Nuevas funciones `territorial::articulo_region()` y
  [`territorial::redactar_region()`](https://bastianolea.github.io/territorial/reference/redactar_region.md)
