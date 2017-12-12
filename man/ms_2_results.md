-   [Results](#results)
    -   [Vegetation Greenness](#vegetation-greenness)
        -   [ Temporal trend EVI values](#temporal-trend-evi-values)
        -   [Resilience metrics](#resilience-metrics)
    -   [Resiliencia BAI](#resiliencia-bai)
    -   [References](#references)

``` r
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

``` r
library(here)
```

    ## here() starts at /Users/ajpelu/Dropbox/phd/phd_repos/qpyr_dendro

``` r
library(pander)
library(kableExtra)
library(knitr)
```

Results
=======

Vegetation Greenness
--------------------

Vegetation greenness of *Quercus pyrenaica* forests were lower during the 2005 and 2012 year than the greenness observed for the reference period (Fig. R1 Profile EVI). The lowest values for EVI standardized anomalies were recorded in 2005 being singnificantly lower (-2.285 ± 0.029) than 2012 (-0.418 ± 0.029) (LSMEANS, t.ratio = -45.358; p\_value &lt; 0.0001), particularly for northern populations (Fig. R2 y R3).

Esta disminución para 2005 sin embargo fue heterogénea (ver plot de trajectorias)

Durante 2005 la mayoría de los pixeles mostraron browning (99.36 % y 79.37 % para las poblaciones del norte y del sur respectivamente), sin embargo en 2012 la mayoría de los pixeles se clasificaron como no changes en las poblaciones del norte (89.60 %) y en las del sur (70.07 %) (Tabla supplementaria??)

-   Si atendemos a las sa (standardized anomalíes) y aplicamos el criterio de Gao, podemos decir que en 2005 se observó un bronwing en los bosques de Q. pyrenaica, sobre todo en las situadas en el northern slopes.

####  Temporal trend EVI values

El 78.95 % de los pixeles mostraron una tendencia positiva en cuanto al EVI medio anual (siendo significativa para el 31.67 % de los pixeles). Esta tendencia positiva fué sobre todo mayor en algunas de las poblaciones del suroeste. La

--&gt; referencia a las tendencias en EVI (lo hemos vuelto a calcular y además en el trabajo de ontologías también nos sale)

Aproximadamete el x% de los robledales mostraron un incremento en los valores de productividad (greenees) ... (relacionar con tendencias EVI y ontologias).

Si analizamos el plot de trajectorias (evi medio anual), vemos como en 2005 y 2012 se observó un browning para los valores medios de EVI. En ambos casos, se observó un patrón homogéneo de browing, aunque en 2012 el browning fue mucho menor.

#### Resilience metrics

Pyrenean oak forests showed significantly lower resistance to 2005 drought event than to 2012 one \[2005: 0.858 (0.853-0.863); 2012: 0.943 (0.939 - 0.947); table R1; Figura R4a, F = 799.86, p &lt;0.0001\]. The 2005 drought reduced the greenness of oak to 85.8 % while the 2012 reduced 94.3 %. Southern populations showed significantly higher values of resistance to drought than northern ones, except for 2012 where non-significant differences were recorded (table R1, Figure R4a).

The oak forests recovered their greenness more rapidly after the 2005 drought than after 2012. In the period after 2005 drought, greeness achieved was 112 % (Rc = 1.12) and after 2012 105.7 % (Rc = 1.057). A similar recovery after the 2005 and 2012 drought event was observed for southern populations (p = 0.2453; Figure R4), whilst the northern populations showed a significantly greater recovery after the 2005 drought than after the 2012 drought.

Resilience values were significantly higher for the 2012 drought event than for 2005, although both values were close to 1 indicating that greenness level was rather similar after each disturbance event. The southern populations showed higher resilience values than the northern ones, although they were not significantly different for 2005 drought (p = 0.036).

\begin{tabular}{lrrrrrrrr}
\toprule
 & F & p & F & p & F & p & F & p\\
\midrule
Disturb & 311.99 & 0.001 & 245.25 & 0.001 & 207.18 & 0.001 & 799.87 & 0.001\\
Site & 105.41 & 0.001 & 71.39 & 0.001 & 29.82 & 0.001 & 153.22 & 0.001\\
Disturb X Site & 364.31 & 0.001 & 341.03 & 0.001 & 6.14 & 0.014 & 234.70 & 0.001\\
\bottomrule
\end{tabular}
-----&gt; POR AQUI POLLITO

table R1. Robust anovas con F-Values Figura R4. Interaction plot resilience metrics

> Relative Resilience (De esto no he dicho nada)

-   Los robledales mostraron mayor resiliencia relativa a la sequía de 2005 que a la de 2012 \[2005: 0.099 (0.095-0.105); 2012: 0.053 (0.050 - 0.056); p &lt;0.0001\]
-   Las poblaciones del sur mostraron menor resiliencia relativa que las del norte \[N: 0.086 (0.082-0.092); S: 0.063 (0.060 - 0.066); p &lt;0.0001\], debido sobre todo a la diferencia en la resiliencia relativa para las poblaciones del norte entre los dos eventos de sequía (mucha mayor resiliencia relativa en 2012 que en 2005 para las poblaciones del N)
-   Las poblaciones del sur no mostraron diferencias en cuanto a la resiliencia relativa entre los dos eventos de sequía (padj = 0.152)

Resiliencia BAI
---------------

-   Resistance:
-   No diferencias significativas entre la resistencia mostrada por los robledales a los eventos de sequía de 2005 y 2012. Valores de resistencia menor al evento de 2005. \[2005: 0.721 (0.6437-0.7984); 2012: 0.8193 (0.7758 - 0.8628); p = 0.03\]
-   Diferentes resistencias a los eventos de sequía en función del sitio (p &lt;0.0001). Las localidades del sur (CaLow y CAHigh no mostraron diferencias en cuanto a la resistencia p.adjust = 0.012) mostraron una resistencia mayor a los eventos de sequía que la observada a la localidad del norte \[caH: 0.8157 (0.7549 - 0.8764) (a); caL: 0.9209 (0.8834 - 0.9584) (a); SJ: 0.6116 (0.5387 - 0.6846) (b)\].
-   La interacción también fue significativa. De hecho, si miramos las gráfica, observamos como la resistencia a la sequía de 2005 fue significativamente menor en SJ que la resistancia mostrada, tanto por las otras poblaciones para 2005, como la mostrada por SJ para el año 2012 --¿¿¿ Podemos decir que la sequía de 2005 afectó mucho mas a la población de SJ???

-   Recovery
    -   En general mayor recuperación para el evento de 2012 que para el evento de 2005 \[2005: 0.9462 (0.8794-1.013); 2012: 1.161 (1.081 - 1.24); p &lt; 0.001\]

References
----------
