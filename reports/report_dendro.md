-   [BAI](#bai)
    -   [Cronologias](#cronologias)
        -   [Figura 1. Cronologías por sitio](#figura-1.-cronologias-por-sitio)
        -   [Comparación cronologías](#comparacion-cronologias)

BAI
===

Cronologias
-----------

-   Para cada sitio construimos una cronología utilizando las series de BAI de cada árbol
-   Hemos utilizado la media aritmética

En los siguientes gráficos se muestran las cronologías medias para cada sitio (mean ± se)

#### Figura 1. Cronologías por sitio

![](../analysis/chronos/analysis_chronologies_files/figure-markdown_github/chronos_4_sites-1.png)

### Comparación cronologías

Las cronologías de la cara norte (SJ) (SJ-High y SJ-Low)s son muy similares. Además en cada sitio de SJ, muestreamos solamente 15 árboles, frente a los 20 de cad sitio de Cáñar (sur). Por tanto consideramos incluir solamente dos sitios en cara sur (CA-Low y CA-High) y un solo sitio en cara norte. Adicionalmente a la comparación visual de chronos se realizó el siguiente análisis:

-   Se estudió la similitud de las series de cada sitio dentro de cada localidad, es decir, CA-High vs. CA-Low y SJ-High vs. SJ-Low.
-   Cada cronología se suavizó utilizando centred moving averages con diferentes tamaño de ventana (entre 1 y 40)
-   Posteriormente se calculó la correlación entre las cronologías de cada sitio suavizadas con una misma ventana temporal, por ejemplo: SJ-High suavidaza con window size 5 años vs. SJ-Low suavidaza con window size de 5 años.
-   Además se obtuvieron los intervalos de confianza de dichos coeficientes de correlación mediante boostrap.