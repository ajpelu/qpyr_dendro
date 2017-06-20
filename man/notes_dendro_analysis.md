-   [Notas análisis dendro](#notas-analisis-dendro)
    -   [Sincronización](#sincronizacion)
    -   [Transformación RW a BAI](#transformacion-rw-a-bai)
        -   [Justificación](#justificacion)
        -   [Procedimiento](#procedimiento)
    -   [Chronologias](#chronologias)
        -   [Salidas gráficas (ver `./out/fig/chronos/`)](#salidas-graficas-ver-.outfigchronos)
        -   [Similitud chronologias](#similitud-chronologias)
    -   [Disturbance chronologies](#disturbance-chronologies)
-   [Resilience Analysis](#resilience-analysis)
    -   [(Gazol et al. 2017)](#gazol2017)
    -   [(Cavin and Jump 2017)](#cavin2017)
    -   [(<span class="citeproc-not-found" data-reference-id="Sanguesa2015">**???**</span>)](#sanguesa2015)
    -   [notas sueltas de correos](#notas-sueltas-de-correos)
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
-   Teóricamente y bajo unas condiciones climáticas medias y en ausencia de perturbaciones, BAI tiene una tendencia creciente en edades tempranas (hasta 40-50 años) y posteriormente se estabiliza por un largo periodod hasta que al final decrece antes de morir (ver p. 229 en Gea-Izquierdo and Cañellas (2014)). Por tanto, una vez transformado a BAI, las tendencias observadas estarían relacionadas con cambios ambientales a largo plazo.

Por tanto, tendencias en BAI (ver en Gea-Izquierdo and Cañellas (2014)):

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

Para cada sitio y/o loc construimos una cronología utilizando las series de BAI. Podemos utilizar varias aproximaciones:

-   media aritmética
-   Tukey’s Biweight Robust Mean (ver pág 123 Cook and Kairukstis (1990))

La media aritmética es la que usa Guillermo para BAI, si queremos hacer cronologías directamente con RW, pues utilizaríamos la biweight. (G. Gea *com. per*). He encontrado algunas diferencias sobre todo en las cronologias de Cañar :red\_circle: ASK to GUILLERMO.

Puedo calcularlas con la función `chron()` pero esto no me permite obtener sd, se del bai por año. Por ello me creo una función llamada `chrono_bai` (código aquí: [./script/R/chrono\_bai.R](/script/R/chrono_bai.R))

#### Salidas gráficas (ver `./out/fig/chronos/`)

Hacemos una comparación de cronos (BAi medios ± se), enfocado en cada sitio entre High and Low:

-   `crono_compara_sj_HL.pdf`
-   `crono_compara_ca_HL.pdf`
-   Todos los sitios juntos:

    -   Facet: `crono_compara_sites.pdf`
    -   Collapsed: `crono_compara_sites_collapsed.pdf`
    -   Collapsed (&gt;1950): `crono_compara_sites_collapsed50.pdf`
    -   Collapsed (&gt;1990): `crono_compara_sites_collapsed90.pdf`

Una vez analizadas las similitudes entre cronologías (ver apartado siguiente), decidimos quedarnos con 3 cronos: SJ, CAL y CAH. Y el plot de las cronos, con su error estandar es: `crono_compara_sitesSJCALH.pdf`

### Similitud chronologias

Testamos si utilizar una crono por localidad (CA / SJ) o una por site (CA High, CA Low, SJ High, SJ Low). Para ello varias aproximaciones:

-   Crear una crono por cada sitio
-   Comparación visual (grafica)
-   Comparación similitud series (ver la aproximación de Dorado-Liñán et al. (2017)):

    -   Cada cronologia es suavizada usando centred moving averages con diferentes windows sizes. Para ello utilizamos la función `suaviza_cronos` (código aquí: [./script/R/suaviza\_cronos.R](/script/R/suaviza_cronos.R))
    -   Posteriormente se calcula la correlación entre chronos para cada suavizado.
    -   Con boosptrap se obtienen niveles de significación :red\_circle: ASK to Guillermo and Isabel.

#### Salidas gráficas (ver `./out/fig/chronos/`)

-   correlación High-Low por sitio: `correla_boot_sitesHL.pdf`
-   correlación SJ, CAL, CAH: `correla_boot_sitesSJCALH.pdf`

Disturbance chronologies
------------------------

Se han construido cronologías de perturbaciones siguiendo la aproximación de (Nowacki and Abrams 1997): método *Percent Increase* (varios ejemplos se pueden ver en Gea-Izquierdo and Cañellas (2014), Dorado-Liñán et al. (2017)). Con éste método, utilizando una ventana temporal de longitud suficiente (~10 años) se filtran (se ignoran) las respuestas a cambios short-term en temperatura y precipitación (Fraver and White 2005).

Para su cómputo hemos utilizado la función `computeGC` (código aquí: [./script/R/computeGC.R](/script/R/computeGC.R)). En concreto hemos llevado a cabo lo siguiente:

-   Computamos medias (o medianas) de RW series (por árbol) en una ventana de 10 años. G.Gea utiliza medias, aunque en otros trabajos utilizan medianas (las medianas son estimadores mas robustos de la tendencia central que la media (Rubino and McCarthy 2004, Camarero et al. 2011)). Las medianas son menos sensibles a los valores extremos (son mas conservadores. G. Gea *com. per.*). No obstante la función calcula ambos (medias y medianas)
-   La formula es:

    -   PGC: \[(M2 - M1)/M1\]\*100
    -   NGC: \[(M2 - M1)/M2\]\*100

siendo *M1* la media (o mediana) del crecimiento (media de RW) en los 10 años precedentes (incluye el año target); mientras que *M2* es la media del crecimiento en los 10 años subsecuentes (excluyendo el año target).

-   Aquí también hay varias aproximaciones. Yo sigo las indicaciones de G. Gea y utilizamos ésta opción.
-   En la aproximación de (Nowacki and Abrams 1997), además se establecen dos tresholds:

    -   25 % GC implica una liberación moderada
    -   50 % GC implica una liberación intensa (major)
-   Ventajas del método de (Nowacki and Abrams 1997):

    -   Se puede aplicar aun con pequeños tamaños de muestra (Altman et al. 2014)
    -   No es necesaria información sobre la autoecología de la especie (Altman et al. 2014)
-   Algunos inconvenientes:

    -   La generalización del promedio de crecimiento radial puede conducir tanto a la detección de falsas liberaciones como a la exclusión de liberaciones verdaderas (Altman et al. 2014)
    -   Excesivamente sensitivo a bajas tasas de crecimiento (acepta false positive releases) asi como excesivamente estricto a altas tasas de crecimiento (produciendo false negative releases) (Fraver and White 2005)
    -   Subjetividad en la elección del umbral minimo para considerar una perturbación. Cambios en el porcentaje elegido implican cambios en la detección de perturbaciones (Rubino and McCarthy 2004)
    -   La variación en la longitud de la ventana temporal, tiene un gran impacto en la detección de liberaciones (Rubino and McCarthy 2004).

En una revisión sobre métodos para detectar disturbance events, (Rubino and McCarthy 2004) encontró que el método mas común es el de *running mean*, es decir, la comparación la tasa de crecimiento de grupos de anillos adyacentes. Comparando diferentes tipos de métodos para detectar perturbaciones (5 tipos de métodos: *static releases*; *detrending o estandarización*; *tasa de crecimiento medio*; *running means*; y *event response*), vieron que el método de *running means* es el que produce resultados que mejor concuerdan con perturbaciones antrópicas bien documentadas.

Existe una aproximación llamada *boundary-line method* (Black and Abrams 2003) que escala el porcentaje de cambio de (Nowacki and Abrams 1997) utilizando la tasa de crecimiento previa a la perturbación. Se considera liberación menor y mayor aquellas que caen dentro del 20 - 49.9 % y del 50 - 100 % de la boundary-line respectivamente. La ventaja del método es la estandarización, ya que escalar el porcentaje de crecimiento respecto a la tase de crecimiento previa considera las relaciones entre la edad, el tamaño y el canopy class, que influencian en algun modo la tasa de crecimiento radial. Una de las desventajas es la gran cantidad de medidas de anillos necesarias para su computo, que está en torno a 50000 para una determinada especie (Altman et al. 2014).

He llevado a cabo una comparación de métodos con el pkg `trader` (Altman et al. 2014) (siendo `XXX` cada sitio, i.e.: `sj`, `caL`, `caH`):

-   Método de percentage growth (Nowacki and Abrams 1997): `/analysis/trader_chronos/XXX/`
-   Método de boundary-line (Black and Abrams 2003): `/analysis/trader_chronos/boundary_XXX/`
-   Método de absolute increment (Fraver and White 2005): `/analysis/trader_chronos/absoluteI_XXX/`

Posteriormente he analizado los años en los que ocurren liberaciones detectadas con los diferentes métodos y en diferentes sitios.

Resilience Analysis
===================

-   Utilizamos BAI por árbol
-   Computamos índices de resiliencia de (Lloret et al. 2011): Resistance (rt), Recovery (rc), Resilience (rs) y Relative Resilience (rrs).
-   Computamos para 3 eventos de sequía (:red\_circle: Mirar esto y decidir que años): 1995, 2005 y 2012
-   Utilizo la la función `baiResilience` (código aquí: [./script/R/baiResilience.R](/script/R/baiResilience.R)).
-   Utilizamos diferentes tamaños ventana para los crecimientos previo y posterior (2, 3 y 4) (ver aproximación de (Gazol et al. 2017)) y computamos correlaciones entre resultados de cada métrica. Los resultados de las correlaciones se guardan [aquí](/out/correla_resilience/correla_window_size.csv)

### (Gazol et al. 2017)

-   Para cada año seco y en cada sitio se calculó la resiliencia del crecimiento de los árboles utilizando tres indices propuestos por (Lloret et al. 2011), en los cuales, la respuesta del crecimiento del árbol a las condiciones secas se descompone en:
    -   Resistance (Rt): quantifies the difference between tree growth in the dry year and the years before it. Rt = Gd / Gprev. It quantifies the capacity of trees to buffer the drought stress and continue growth during drought
    -   Recovery (Rc): quantifies the difference in growth between the dry year and a subsequent period. Rc = Gpost / Gd
    -   Resilience (Rs): quantifies the difference in tree growth before and after the dry year. Rs = Gpost / Gprev. It measures the capacity of trees to recover the growth rates observed before the drought stress
-   Gd = crecimiento durante el periodo de sequía (mean tree-ring width)
-   Gprev y Gpost = crecimiento medio durante los tres años antes y despues del periodo de sequía

-   Cada año seco lo consideraron como un evento de sequía
-   Utilizaron una ventana de 3 años, porque obtuvieron resultados similares 2, 3 y 4 años (ver correlaciones del material suplementario de ese trabajo)

### (Cavin and Jump 2017)

-   Utilizan los cuatro índices de (Lloret et al. 2011) (los anteriores mas la Relative Resilience)
-   Evaluan tree growth usando BAI
-   Determinan el año seco, utilizando una aproximación de pointer year.
-   Relative Resilience (Gpost - Gd) / Gprev. Se trata de la resiliencia ponderada por la severidad del evento de sequía

### (<span class="citeproc-not-found" data-reference-id="Sanguesa2015">**???**</span>)

-   Seleccionan tres años de sequía basándose en Spei de agosto de 4 meses (ver material suplemtario de su trabajo). Valores mas bajos de los últimos 25 años.
-   Definen dos métricas para la respuesta del BAI a la sequía: Drougth Sensitivity (DS) y Drought Recovery (DR)

    -   Drougth Sensitivity (DS): \[(BAId - BAId-3) / (BAId-3)\]\*100
    -   Drought Recovery (DR): \[(BAId+3 - BAId-3) / (BAId-3)\]\*100
-   Selección de ventana de 3 años, basado en

### notas sueltas de correos

-   Puedes probar los pointer years y lo de Lloret, efectivamente la idea era comparar los años de sequía de las cronos con tus análisis en imágenes. Lo bueno es que en las cronos puedes comparar con años secos antes de 2005, ya sabes.

-   Me resulta raro que no se parezcan en nada en la alta frecuencia (lag 0) ninguna de las cronos, pero bueno, si te sale así es cuestión de pensar bien si hay información útil en ese gráfico. La baja frecuencia en SJ y CL es opuesta, no sé, habría que discutir si tiene sentido presentar esa figura.

-   Para los GC: yo siempre he usado medias porque creo recordar que es lo que había en el artículo original. Hay gente que usa medianas… usa el que creas más conveniente, la técnica tiene sus debilidades (por ejemplo, puede haber “liberaciones” en cronos muy sensibles durante períodos muy húmedos, por ejemplo, y a efectos de crecimiento parecen lo mismo que una liberación por competencia). Las medianas son menos sensibles a valores extremos, en este sentido pueden ser más conservadoras, pero bueno, presentando intervalos de confianza y/o mezclando gráficos de medias con gráficos de % de pies que presentan liberaciones/supresiones se debería llegar a los mismos resultados.

-   Las NGC: lo suyo es (M2-M1)/M2, es decir, poner en el denominador siempre el período teóricamente más pequeño. De algún modo así se aumenta la probabilidad de que salga significativo, pero bueno. Creo recordar que en los que yo usé de referencia usaban esa fórmula. Son pequeños matices, y como hemos hablado, la técnica tiene sus limitaciones, así que de una u otra manera, cuando son claras deberían salir igual (picos en esa época). Pero vamos, yo he usado la última que dices tú.

-   se contabilizan ese año los que superen el umbral, efectivamente, y para los PGC se computan sólo los positivos, y para el NGC sólo los negativos. Es decir, independientemente (entiendo, así pensándolo rápido que hace un tiempo que no hago un cálculo de éstos) por un lado se calculan los PGC y los NGC, y luego se componen (los cálculos independientes) en el gráfico.
-   El gráfico de SJ me parece coherente con el gráfico de crecimiento medio. Se ve la liberación en los años 40-50 que debió ser de la última corta para leñas. Queda bonito y tiene sentido, lo que no sé es cuántos árboles tienes antes y después del pico, pero es coherente con la historia que estuvimos discutiendo. En cuanto a Cáñar, habrá que pensar bien qué son esas supresiones: podrían ser épocas de estrés climático, o épocas en las que había más competencia (entonces deberían salir luego liberaciones… pero todo esto es especulativo). En cualquier caso, la de SJ me parece interesante, bonita y coherente con lo que estuvimos discutiendo.

------------------------------------------------------------------------

### Planteamiento del análisis

-   2 sitios y dos cotas por sitio
-   Comparación formal entre crecimientos entre sitios
-   4 cronos separadas y dos cronos promedio

References
==========

Altman, J., P. Fibich, J. Dolezal, and T. Aakala. 2014. TRADER: A package for tree ring analysis of disturbance events in r. Dendrochronologia 32:107–112.

Black, B. A., and M. D. Abrams. 2003. Use of boundary-line growth patterns as a basis for dendroecological release criteria. Ecological Applications 13:1733–1749.

Camarero, J. J., C. Bigler, J. C. Linares, and E. Gil-Pelegrín. 2011. Synergistic effects of past historical logging and drought on the decline of pyrenean silver fir forests. Forest Ecology and Management 262:759–769.

Cavin, L., and A. S. Jump. 2017. Highest drought sensitivity and lowest resistance to growth suppression are found in the range core of the tree fagus sylvatica l. not the equatorial range edge. Global Change Biology 23:362–379.

Cook, E., and L. Kairukstis. 1990. Methods of dendrochronology: Applications in the environmental sciences. Kluwer Academic, Doredrecht.

Dorado-Liñán, I., I. Cañellas, M. Valbuena-Carabaña, L. Gil, and G. Gea-Izquierdo. 2017. Coexistence in the mediterranean-temperate transitional border: Multi-century dynamics of a mixed old-growth forest under global change. Dendrochronologia 44:48–57.

Fraver, S., and A. S. White. 2005. Identifying growth releases in dendrochronological studies of forest disturbance. Canadian Journal of Forest Research 35:1648–1656.

Gazol, A., J. J. Camarero, W. R. L. Anderegg, and S. M. Vicente-Serrano. 2017. Impacts of droughts on the growth resilience of northern hemisphere forests. Global Ecology and Biogeography 26:166–176.

Gea-Izquierdo, G., and I. Cañellas. 2014. Local climate forces instability in long-term productivity of a mediterranean oak along climatic gradients. Ecosystems 17:228–241.

Holmes, R. L. 1983. Computer-assisted quality control in tree-ring dating and measurement. Tree-Ring Bulletin 43:69–78.

Lloret, F., E. G. Keeling, and A. Sala. 2011. Components of tree resilience: Effects of successive low-growth episodes in old ponderosa pine forests. Oikos 120:1909–1920.

Nowacki, G. J., and M. D. Abrams. 1997. Radial-growth averaging criteria for reconstructing disturbance histories from presettlement-origing oaks. Ecological Monographs 67:225–249.

Piovesa, G., F. Biondi, A. D. Filippo, A. Alessandrini, and M. Maugeri. 2008. Drought-driven growth reduction in old beech (fagus sylvatica l.) forests of the central apennines, italy. Global Change Biology 14:1265–1281.

Rubino, D., and B. McCarthy. 2004. Comparative analysis of dendroecological methods used to assess disturbance events. Dendrochronologia 21:97–115.
