-   [Notas análisis dendro](#notas-analisis-dendro)
    -   [Sincronización](#sincronizacion)
    -   [Transformación RW a BAI](#transformacion-rw-a-bai)
    -   [Muestreo](#muestreo)
        -   [Spatial Coverage](#spatial-coverage)
        -   [Metodología](#metodologia)
        -   [Temporal coverage](#temporal-coverage)
        -   [Collectors](#collectors)
    -   [Laboratorio:](#laboratorio)
        -   [Medición:](#medicion)
        -   [Output](#output)
-   [References](#references)

Notas análisis dendro
=====================

Sincronización
--------------

Sincronizamos visualmene cada una de las series de radios (rw) y posteriormente verificamos la sincronización con COFECHA (Holmes 1983)

-   \[\] :red\_circle: Link al ouptut y análisis de los datos de COFECHA
-   \[\] :red\_circle: Tabla 1 con estadísticos (ver otros ejemplos)

Transformación RW a BAI
-----------------------

-   Vamos a transformar los datos de RW a BAI.
-   Existe una tendencia de decrecimiento en las medidas de RW con el incremento del tamaño del árbol o con el incremento de la edad (ver (Biondi and Qeadan 2008, Dorado-Liñán et al. (2017)))

> ... one of the main elements of dendrochronological standardization is removing the biological trend, i.e. the progressive decline of ring width along a cross-sectional radius that is caused by the corresponding increase in stem size and tree age over time... (Biondi and Qeadan 2008)

> ... Individual tree-ring series were coverted to Basal Area Increment (BAI) to avoid age-related trends in non-juvenile ring-width measurement (see (Dorado-Liñán et al. 2017))

-   El objetivo de esta transformación es remover las tendencias relacionadas con la edad. Podría tratarse de una forma de estandarización.
-   Teóricamente y bajo unas condiciones climáticas medias y en ausencia de perturbaciones, BAI tiene una tendencia creciente en edades tempranas (hasta 40-50 años) y posteriormente se estabiliza por un largo periodod hasta que al final decrece antes de morir (ver Gea-Izquierdo and Cañellas (2014) p.229). Por tanto, una vez transformado a BAI, las tendencias observadas estarían relacionadas con cambios ambientales a largo plazo.

Por tanto, tendencias en BAI (ver Gea-Izquierdo and Cañellas (2014)): \* Tendencias negativas: expresan un declive en la productividad \* Tendencias positivas: efecto positivo del clima o de la fertilización atmosférica

Muestreo
--------

### Spatial Coverage

Dos localidades de muestreo en Sierra Nevada: Robledal de Cañar y Robledal de San Juan. En cada una de las zonas dos zonas (high and low elevation). *T**O**D**O* :red\_circle: `INCLUIR LINK A MAPA CON ZONZAS Y TABLA CON NOMBRES DE MUESTREO`

### Metodología

-   Número de árboles: En Cáñar muestreamos 30 árboles (15 y 15) mientras que en San Juan 20 (10 y 10) árboles
-   De cada árbol se midió la altura y el perímetro a la altura del pecho (para sacar dbh)
-   Los árboles fueron seleccionados de forma aleatoria
-   Tomamos al menos 2 cores perpendiculares por árbol a una altura de 1.3 m. Para ello utilizamos una barrena de Pressler
-   Los cores se etiquetaron y se guardaron en pajitas hasta su manipulacion en la laboratorio

### Temporal coverage

-   13-14 Noviembre 2016

### Collectors

-   Guillermo Gea-Izquierdo
-   Regino Zamora-Rodríguez
-   Antonio J. Pérez-Luque
-   Francisco J. Bonet-García (13 Nov)

Laboratorio:
------------

-   Cada core se montó sobre soportes de madera convenientemente etiquetados
-   Cada core se pegó utilizando cola soluble al agua y fixo (scott)
-   Ojo con montar bien las muestras (plano transversal, ver Fritts (1976))
-   Una vez montadas, son lijadas (empezando por lija gruesa hasta lija menos gruesa)

### Medición:

-   Primero datación visual cruzada (sincronización // cross-dating)
-   La medición de anillos se realizó utilizando un estereomicroscópio acoplado a un dispositivo LINTAB (Rinntech, Heidelberg, Germany) con una precision de 0.01 mm (1/100 mm); y utilizando el software [TSAP-Win](http://www.rinntech.de/content/view/17/48/lang,english/index.html)
-   La sincronización se realizó primero de forma visual y luego se verificó utilizando los valores de los estadísticos:
    -   Gleichläufigkeit (Glk)
    -   t-value
    -   Cross-datin index (CDI)
-   Posteriormente la sincronización (cross-dating) fue evaluada utilizando COFECHA (Holmes 1983)

### Output

De la medición y posterior sincronización se han generado varios archivos, en concreto de tres tipos para cada localidad:

-   `sn_qpyr_LOC2016.fh`. Archivo en formato Heidelberg, generado por el software TSAP-Win con los datos de las series de cada core, de cada árbol, y las cronos medias.
-   `sn_LOC.rwl`. Archivo en formato Tucson con las mediciones de cada core
-   `sn_LOC_cofecha.OUT`. Archivo de salida de la comprobación de la sincronización realizada con COFECHA (Holmes 1983 Grissino-Mayer (2001))

donde `LOC` puede ser: `sanjuan` o `canar`. Se ha generado dos carpetas, una para cada localidad:

-   `./data_raw/dendro_ring/sn_canar/`
-   `./data_raw/dendro_ring/sn_sanjuan/`

En el caso de Cáñar, tuvimos algunos desajustes en la sincronización, por que también existe otro archivo `.fh` llamado `SN_QPYR_Canar_2016_antonio_viejas.fh` que contiene los datos antes de las correcciones realizadas por Guillermo.

Finalmente, existe una copia de seguridad de todos los archivos en el archivo \[`./data_raw/dendro_ring/copia_seg/dendro.zip`\] y en mi carpeta drive backups

Para mas información sobre formatos de datos en dendrocronología ver [material suplementario](http://www.treeringsociety.org/resources/SOM/Brewer_Murphy_SupplementaryMaterial.pdf) de (Brewer et al. 2011).

References
==========

Biondi, F., and F. Qeadan. 2008. A theory-driven approach to tree-ring standardization: Defining the biological trend from expected basal area increment. Tree-Ring Research 64:81–96.

Brewer, P. W., D. Murphy, and E. Jansma. 2011. Tricycle: A Universal Conversion Tool For Digital Tree-Ring Data. Tree-Ring Research 67:135–144.

Dorado-Liñán, I., I. Cañellas, M. Valbuena-Carabaña, L. Gil, and G. Gea-Izquierdo. 2017. Coexistence in the mediterranean-temperate transitional border: Multi-century dynamics of a mixed old-growth forest under global change. Dendrochronologia 44:48–57.

Fritts, H. C. 1976. Tree rings and climate. Academic Press, London.

Gea-Izquierdo, G., and I. Cañellas. 2014. Local climate forces instability in long-term productivity of a mediterranean oak along climatic gradients. Ecosystems 17:228–241.

Grissino-Mayer, H. D. 2001. Evaluating crossdating accuracy: a manual and tutorial for the computer program COFECHA. Tree-Ring Research 57:205–221.

Holmes, R. L. 1983. Computer-assisted quality control in tree-ring dating and measurement. Tree-Ring Bulletin 43:69–78.
