-   [Notas análisis dendro](#notas-analisis-dendro)
    -   [Sincronización](#sincronizacion)
    -   [Transformación RW a BAI](#transformacion-rw-a-bai)
        -   [Justificación](#justificacion)
        -   [Procedimiento](#procedimiento)
    -   [Chronologias](#chronologias)
        -   [Similitud chronologias](#similitud-chronologias)
        -   [Planteamiento del análisis](#planteamiento-del-analisis)
-   [References](#references)

Notas análisis dendro
=====================

Sincronización
--------------

Sincronizamos visualmene cada una de las series de radios (rw) y posteriormente verificamos la sincronización con COFECHA (Holmes 1983). Se puede obtener COFECHA en este [enlace](http://web.utk.edu/~grissino/software.htm). Resultados COFECHA:

-   San Juan: [`./data_raw/dendro_ring/sn_sanjuan/sn_sanjuan_cofecha.OUT`](/data_raw/dendro_ring/sn_sanjuan/sn_sanjuan_cofecha.OUT)
-   Cañar: [`./data_raw/dendro_ring/sn_canar/sn_canar_cofecha.OUT`](/data_raw/dendro_ring/sn_canar/sn_canar_cofecha.OUT)

Transformación RW a BAI
-----------------------

### Justificación

-   Vamos a transformar los datos de RW a BAI.
-   Existe una tendencia de decrecimiento en las medidas de RW con el incremento del tamaño del árbol o con el incremento de la edad (ver (<span class="citeproc-not-found" data-reference-id="Biondi2008">**???**</span>), Dorado-Liñán et al. (2017))

> ... one of the main elements of dendrochronological standardization is removing the biological trend, i.e. the progressive decline of ring width along a cross-sectional radius that is caused by the corresponding increase in stem size and tree age over time... (<span class="citeproc-not-found" data-reference-id="Biondi2008">**???**</span>)

> ... Individual tree-ring series were coverted to Basal Area Increment (BAI) to avoid age-related trends in non-juvenile ring-width measurement (Dorado-Liñán et al. 2017)

-   El objetivo de esta transformación es remover las tendencias relacionadas con la edad. Podría tratarse de una forma de estandarización.
-   Teóricamente y bajo unas condiciones climáticas medias y en ausencia de perturbaciones, BAI tiene una tendencia creciente en edades tempranas (hasta 40-50 años) y posteriormente se estabiliza por un largo periodod hasta que al final decrece antes de morir (ver p. 229 en (<span class="citeproc-not-found" data-reference-id="GeaIzquierdo2014">**???**</span>)). Por tanto, una vez transformado a BAI, las tendencias observadas estarían relacionadas con cambios ambientales a largo plazo.

Por tanto, tendencias en BAI (ver en (<span class="citeproc-not-found" data-reference-id="GeaIzquierdo2014">**???**</span>)):

-   Tendencias negativas: expresan un declive en la productividad
-   Tendencias positivas: efecto positivo del clima o de la fertilización atmosférica

### Procedimiento

-   Aproximaciones y funciones en R:

    -   `dplR::bai.out()`: Utiliza sumatorio de rw si no se le proporcionan los diámetros. No elimina valor de corteza.
    -   Aproximación de Piovesa et al. (2008). Podemos utilizar varias funciones: `BAItree()` escrita por G. Gea (código aquí: [./script/R/gea/BAItree.R](/script/R/gea/BAItree.R)); o la función `bai_piovesan()` escrita por A.J. Pérez (código aquí: [./script/R/bai\_piovesan.R](/script/R/bai_piovesan.R))
-   Calcular el BAI por cada árbol haciendo la media de crecimiento (RW) a nivel de árbol. Para el cálculo de la media de crecimiento por árbol utilizamos la siguiente función [./script/R/rw\_byTree.R](/script/R/rw_byTree.R)) creada específicamente para ello. También podríamos hacerlo con la función `treeMean`

-   :red\_circle: Estimación corteza en BAItree como lo ha calculado (lo de la encina)
-   :red\_circle: Dudas funcion BAItree Guillermo.

Chronologias
------------

Para cada sitio y/o loc construimos una cronología utilizando las series de BAI. Podemos utilizar varias aproximaciones: \* media aritmética \* Tukey’s Biweight Robust Mean (ver pág 123 Cook and Kairukstis (1990))

La media aritmética es la que usa Guillermo para BAI, si queremos hacer cronologías directamente con RW, pues utilizaríamos la biweight. (G. Gea *com. per*). He encontrado algunas diferencias sobre todo en las cronologias de Cañar :red\_circle: ASK to GUILLERMO.

Puedo calcularlas con la función `chron()` pero esto no me permite obtener sd, se del bai por año. Por ello me creo una función llamada `chrono_bai` (código aquí: [./script/R/chrono\_bai.R](/script/R/gea/chrono_bai.R))

### Similitud chronologias

Testamos si utilizar una crono por localidad (CA / SJ) o una por site (CA High, CA Low, SJ High, SJ Low). Para ello varias aproximaciones:

-   Crear una crono por cada sitio
-   Comparación visual (grafica)
-   Comparación similitud series (ver la aproximación de Dorado-Liñán et al. (2017)):

    -   Cada cronologia es suavizada usando centred moving averages con diferentes windows sizes. Para ello utilizamos la función `suaviza_cronos` (código aquí: [./script/R/suaviza\_cronos.R](/script/R/gea/suaviza_cronos.R))
    -   Posteriormente se calcula la correlación entre chronos para cada suavizado.
    -   Con boosptrap se obtienen niveles de significación :red\_circle: ASK to Guillermo and Isabel.

------------------------------------------------------------------------

### Planteamiento del análisis

-   2 sitios y dos cotas por sitio
-   Comparación formal entre crecimientos entre sitios
-   4 cronos separadas y dos cronos promedio

References
==========

Cook, E., and L. Kairukstis. 1990. Methods of dendrochronology: Applications in the environmental sciences. Kluwer Academic, Doredrecht.

Dorado-Liñán, I., I. Cañellas, M. Valbuena-Carabaña, L. Gil, and G. Gea-Izquierdo. 2017. Coexistence in the mediterranean-temperate transitional border: Multi-century dynamics of a mixed old-growth forest under global change. Dendrochronologia 44:48–57.

Holmes, R. L. 1983. Computer-assisted quality control in tree-ring dating and measurement. Tree-Ring Bulletin 43:69–78.

Piovesa, G., F. Biondi, A. D. Filippo, A. Alessandrini, and M. Maugeri. 2008. Drought-driven growth reduction in old beech (fagus sylvatica l.) forests of the central apennines, italy. Global Change Biology 14:1265–1281.
