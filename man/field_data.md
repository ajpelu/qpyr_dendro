-   [Muestreo](#muestreo)
    -   [Spatial Coverage](#spatial-coverage)
    -   [Metodologia muestreo](#metodologia-muestreo)
    -   [Temporal coverage](#temporal-coverage)
    -   [Collectors](#collectors)
-   [Laboratorio:](#laboratorio)
    -   [Medición:](#medicion)
    -   [Output](#output)
    -   [References](#references)

Muestreo
========

Spatial Coverage
----------------

Dos localidades de muestreo en Sierra Nevada: Robledal de Cañar y Robledal de San Juan. En cada una de las zonas dos zonas (high and low elevation). *T**O**D**O* :red\_circle: `INCLUIR LINK A MAPA CON ZONZAS Y TABLA CON NOMBRES DE MUESTREO`

Metodologia muestreo
--------------------

-   Número de árboles: En Cáñar muestreamos 30 árboles (15 y 15) mientras que en San Juan 20 (10 y 10) árboles
-   De cada árbol se midió la altura y el perímetro a la altura del pecho (para sacar dbh)
-   Los árboles fueron seleccionados de forma aleatoria
-   Tomamos al menos 2 cores perpendiculares por árbol a una altura de 1.3 m. Para ello utilizamos una barrena de Pressler
-   Los cores se etiquetaron y se guardaron en pajitas hasta su manipulacion en la laboratorio

Temporal coverage
-----------------

-   13-14 Noviembre 2016

Collectors
----------

-   Guillermo Gea-Izquierdo
-   Regino Zamora-Rodríguez
-   Antonio J. Pérez-Luque
-   Francisco J. Bonet-García (13 Nov)

Laboratorio:
============

-   Cada core se montó sobre soportes de madera convenientemente etiquetados
-   Cada core se pegó utilizando cola soluble al agua y fixo (scott)
-   Ojo con montar bien las muestras (plano transversal, ver Fritts (1976))
-   Una vez montadas, son lijadas (empezando por lija gruesa hasta lija menos gruesa)

Medición:
---------

-   Primero datación visual cruzada (sincronización // cross-dating)
-   La medición de anillos se realizó utilizando un estereomicroscópio acoplado a un dispositivo LINTAB (Rinntech, Heidelberg, Germany) con una precision de 0.01 mm (1/100 mm); y utilizando el software [TSAP-Win](http://www.rinntech.de/content/view/17/48/lang,english/index.html)
-   La sincronización se realizó primero de forma visual y luego se verificó utilizando los valores de los estadísticos:
    -   Gleichläufigkeit (Glk)
    -   t-value
    -   Cross-datin index (CDI)
-   Posteriormente la sincronización (cross-dating) fue evaluada utilizando COFECHA (Holmes 1983)

Output
------

De la medición y posterior sincronización se han generado varios archivos, en concreto de tres tipos para cada localidad:

-   `sn_qpyr_LOC2016.fh`. Archivo en formato Heidelberg, generado por el software TSAP-Win con los datos de las series de cada core, de cada árbol, y las cronos medias.
-   `sn_LOC.rwl`. Archivo en formato Tucson con las mediciones de cada core
-   `sn_LOC_cofecha.OUT`. Archivo de salida de la comprobación de la sincronización realizada con COFECHA (<span class="citeproc-not-found" data-reference-id="Holmes">**???**</span>, Grissino-Mayer 2001)

donde `LOC` puede ser: `sanjuan` o `canar`. Se ha generado dos carpetas, una para cada localidad:

-   `./data_raw/dendro_ring/sn_canar/`
-   `./data_raw/dendro_ring/sn_sanjuan/`

En el caso de Cáñar, tuvimos algunos desajustes en la sincronización, por que también existe otro archivo `.fh` llamado `SN_QPYR_Canar_2016_antonio_viejas.fh` que contiene los datos antes de las correcciones realizadas por Guillermo.

Finalmente, existe una copia de seguridad de todos los archivos

Para mas información sobre formatos de datos en dendrocronología ver [material suplementario](http://www.treeringsociety.org/resources/SOM/Brewer_Murphy_SupplementaryMaterial.pdf) de (Brewer et al. 2011).

References
----------

Brewer, P. W., D. Murphy, and E. Jansma. 2011. Tricycle: A Universal Conversion Tool For Digital Tree-Ring Data. Tree-Ring Research 67:135–144.

Fritts, H. C. 1976. Tree rings and climate. Academic Press, London.

Grissino-Mayer, H. D. 2001. Evaluating crossdating accuracy: a manual and tutorial for the computer program COFECHA. Tree-Ring Research 57:205–221.

Holmes, R. L. 1983. Computer-assisted quality control in tree-ring dating and measurement. Tree-Ring Bulletin 43:69–78.
