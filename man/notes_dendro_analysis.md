-   [Notas análisis dendro](#notas-analisis-dendro)
    -   [Sincronización](#sincronizacion)
    -   [Transformación RW a BAI](#transformacion-rw-a-bai)
        -   [Justificación](#justificacion)
        -   [Procedimiento](#procedimiento)
        -   [Planteamiento del análisis](#planteamiento-del-analisis)
-   [References](#references)

Notas análisis dendro
=====================

Sincronización
--------------

Sincronizamos visualmene cada una de las series de radios (rw) y posteriormente verificamos la sincronización con COFECHA (Holmes 1983). Se puede obtener COFECHA en este [enlace](http://web.utk.edu/~grissino/software.htm). Resultados COFECHA:

-   San Juan: [`./data_raw/dendro_ring/sn_sanjuan/sn_sanjuan_cofecha.OUT`](/data_raw/dendro_ring/sn_sanjuan/sn_sanjuan_cofecha.OUT)
-   Cañar: [`./data_raw/dendro_ring/sn_canar/sn_canar_cofecha.OUT`](/data_raw/dendro_ring/sn_canar/sn_canar_cofecha.OUT)

-   \[ \] :red\_circle: Tabla con estadísticos (ver otros ejemplos): Ha de te

Transformación RW a BAI
-----------------------

### Justificación

-   Vamos a transformar los datos de RW a BAI.
-   Existe una tendencia de decrecimiento en las medidas de RW con el incremento del tamaño del árbol o con el incremento de la edad (ver Biondi and Qeadan (2008), Dorado-Liñán et al. (2017))

> ... one of the main elements of dendrochronological standardization is removing the biological trend, i.e. the progressive decline of ring width along a cross-sectional radius that is caused by the corresponding increase in stem size and tree age over time... (Biondi and Qeadan 2008)

> ... Individual tree-ring series were coverted to Basal Area Increment (BAI) to avoid age-related trends in non-juvenile ring-width measurement (Dorado-Liñán et al. 2017)

-   El objetivo de esta transformación es remover las tendencias relacionadas con la edad. Podría tratarse de una forma de estandarización.
-   Teóricamente y bajo unas condiciones climáticas medias y en ausencia de perturbaciones, BAI tiene una tendencia creciente en edades tempranas (hasta 40-50 años) y posteriormente se estabiliza por un largo periodod hasta que al final decrece antes de morir (ver p. 229 en Gea-Izquierdo and Cañellas (2014)). Por tanto, una vez transformado a BAI, las tendencias observadas estarían relacionadas con cambios ambientales a largo plazo.

Por tanto, tendencias en BAI (ver en Gea-Izquierdo and Cañellas (2014)):

-   Tendencias negativas: expresan un declive en la productividad
-   Tendencias positivas: efecto positivo del clima o de la fertilización atmosférica

### Procedimiento

-   Aproximaciones y funciones en R:

    -   `dplR::bai.out()`: Utiliza sumatorio de rw si no se le proporcionan los diámetros. No elimina valor de corteza.
    -   Aproximación de Piovesa et al. (2008). Podemos utilizar varias funciones: `BAItree()` escrita por G. Gea (código aquí: [./script/R/gea/BAItree.R](/script/R/gea/BAItree.R)); o la función `bai_piovesan()` escrita por A.J. Pérez (código aquí: [./script/R/bai\_piovesan.R](/script/R/bai_piovesan.R))
-   Calcular el BAI por cada árbol haciendo la media de crecimiento (RW) a nivel de árbol.

-   :red\_circle: Estimación corteza en BAItree como lo ha calculado (lo de la encina)
-   :red\_circle: Dudas funcion BAItree Guillermo.

------------------------------------------------------------------------

### Planteamiento del análisis

-   2 sitios y dos cotas por sitio
-   Comparación formal entre crecimientos entre sitios
-   4 cronos separadas y dos cronos promedio

References
==========

Biondi, F., and F. Qeadan. 2008. A theory-driven approach to tree-ring standardization: Defining the biological trend from expected basal area increment. Tree-Ring Research 64:81–96.

Dorado-Liñán, I., I. Cañellas, M. Valbuena-Carabaña, L. Gil, and G. Gea-Izquierdo. 2017. Coexistence in the mediterranean-temperate transitional border: Multi-century dynamics of a mixed old-growth forest under global change. Dendrochronologia 44:48–57.

Gea-Izquierdo, G., and I. Cañellas. 2014. Local climate forces instability in long-term productivity of a mediterranean oak along climatic gradients. Ecosystems 17:228–241.

Holmes, R. L. 1983. Computer-assisted quality control in tree-ring dating and measurement. Tree-Ring Bulletin 43:69–78.

Piovesa, G., F. Biondi, A. D. Filippo, A. Alessandrini, and M. Maugeri. 2008. Drought-driven growth reduction in old beech (fagus sylvatica l.) forests of the central apennines, italy. Global Change Biology 14:1265–1281.
