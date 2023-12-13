## Los datos disponibles

### Compras, ventas e impuestos por sector de actividad

| Variable                               | Tipo                                | Descripción                                                                                       | Etiqueta                                    |
|-----------------|-----------------|----------------------|-----------------|
| `anio_fiscal`                          | Numérico (Entero)                   | Año fiscal al que corresponden los datos.                                                         | Año Fiscal                                  |
| `mes_fiscal`                           | Numérico (Entero)                   | Mes fiscal al que corresponden los datos.                                                         | Mes Fiscal                                  |
| `tipo_contribuyente`                   | Categórico (Texto)                  | Tipo de contribuyente, en este caso, siempre es "SOCIEDADES".                                     | Tipo de Contribuyente                       |
| `actividad_economica`                  | Categórico (Texto - CIIU 5 dígitos) | Clasificación de la actividad económica según el Código Internacional Industrial Uniforme (CIIU). | Actividad Económica (CIIU)                  |
| `impuesto_causado_601`                 | Numérico (Decimal)                  | Monto del impuesto causado por la empresa, etiquetado como 601.                                   | Impuesto Causado (601)                      |
| `imp_a_pagar_por_percepcion_699`       | Numérico (Decimal)                  | Impuesto a pagar calculado en base a percepciones, etiquetado como 699.                           | Impuesto a Pagar por Percepción (699)       |
| `imp_a_pagar_por_retencion_799`        | Numérico (Decimal)                  | Impuesto a pagar calculado en base a retenciones, etiquetado como 799.                            | Impuesto a Pagar por Retención (799)        |
| `total_compras_locales_e_importac_519` | Numérico (Decimal)                  | Total de compras locales e importaciones realizadas por la empresa, etiquetado como 519.          | Total Compras Locales e Importaciones (519) |
| `total_ventas_y_exportaciones_419`     | Numérico (Decimal)                  | Total de ventas y exportaciones realizadas por la empresa, etiquetado como 419.                   | Total Ventas y Exportaciones (419)          |

> **Archivo:** "data/ts_series_iva.csv"

## Los datos disponibles

### Empresas activas que operan en Pichincha

| Variable      | Tipo               | Descripción                                                                                            | Etiqueta                         |
|----------------|----------------|------------------------|----------------|
| `fecha`       | Fecha (`<date>`)   | Fecha correspondiente a los datos recogidos.                                                           | Fecha                            |
| `nuevas`      | Numérico (Entero)  | Número de empresas que iniciaron actividades en la fecha indicada.                                     | Empresas Nuevas                  |
| `suspendidas` | Numérico (Entero)  | Número de empresas que suspendieron su RUC de manera indefinida en la fecha indicada.                  | Empresas Suspendidas             |
| `reingresos`  | Numérico (Entero)  | Número de empresas que reiniciaron actividades en la fecha indicada.                                   | Reingresos de Empresas           |
| `actividad`   | Categórico (Texto) | Categoría de actividad económica, posiblemente siguiendo la clasificación CIIU.                        | Actividad Económica              |
| `delta`       | Numérico (Entero)  | Diferencia entre el número de reingresos y el número de empresas suspendidas en la fecha indicada.     | Delta (Reingresos - Suspendidas) |
| `saldo`       | Numérico (Entero)  | Número total de empresas activas calculadas a partir del número de empresas activas en enero del 2000. | Saldo de Empresas Activas         |

> **Archivo:** "data/ts_series_pichincha.csv" De estos archivos tenemos una versión para cuatro actividades:

## Los datos disponibles

### Actividades de elaboración de alimentos 📊

Información descargada del sistema Saiku del SRI. Para usar estos datos, es importante filtrar y limpiar la información adecuadamente.

-   **C1050**: ELABORACIÓN DE PRODUCTOS LÁCTEOS 🥛
    -   ¡Vamos desde la vaca 🐄 hasta el consumidor! Esta actividad cubre todo lo relacionado con la transformación de la leche en productos como queso, yogurt y otros derivados lácteos.
-   **C1071**: ELABORACIÓN DE PRODUCTOS DE PANADERÍA 🍞
    -   ¡Horneamos felicidad! Aquí entramos al delicioso mundo de los panes, pasteles 🍰, galletas 🍪 y todo tipo de productos de panadería.
-   **C1103**: ELABORACIÓN DE BEBIDAS MALTEADAS Y DE MALTA 🍺
    -   De la cebada al bar, cubrimos la producción de cervezas artesanales y otras bebidas fermentadas a partir de malta. ¡Salud!

Información descargada del sistema Saiku del SRI.
