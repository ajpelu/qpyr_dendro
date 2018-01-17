-   [Materials and methods](#materials-and-methods)
    -   [Species and study site](#species-and-study-site)
    -   [Datos de sequía.](#datos-de-sequia.)
        -   [Greenness data](#greenness-data)
    -   [Field sampling and dendrochronological methods](#field-sampling-and-dendrochronological-methods)
        -   [Tree sampling](#tree-sampling)
        -   [Dendroecological analyses](#dendroecological-analyses)
        -   [Climate and growth](#climate-and-growth)
        -   [Disturbance analyses](#disturbance-analyses)
    -   [Resilience](#resilience)
    -   [Statistical analysis](#statistical-analysis)
    -   [References](#references)

Materials and methods
=====================

Species and study site
----------------------

The Pyrenean oak (*Quercus pyrenaica* Willd.) forests extend through south-western France and the Iberian Peninsula (Franco 1990) reaching its southern limit in north of Morocco. In the Iberian Peninsula these forests live under meso-supramediterranean and mesotemperate areas and subhumid, humid and hyperhumid ombroclimate (Rivas-Martínez et al. 2002) living on siliceous soils, or soils poor in basic ions (Vilches de la Serna 2014). *Q. pyrenaica* requires between 650 and 1200 mm of annual precipitation and a summer minimal precipitation between 100 and 200 mm (Martínez-Parras and Molero-Mesa 1982, García and Jiménez 2009), with summer rainfall being a key factor in the distribution of the species (Gavilán et al. 2007, Río et al. 2007).

This species reaches its southernmost European limit at Sierra Nevada, a high-mountain range located in southern Spain (37°N, 3°W) with elevations of between 860 m and 3482 m *a.s.l.*. The climate is Mediterranean, characterized by cold winters and hot summers, with pronounced summer drought (July-August). There are eight oak patches (2400 Has) identified (**Figure 1**) in this mountain range, ranging between 1100 and 2000 m *a.s.l.* and generally associated to major river valleys. Sierra Nevada is considered a glacial refugia for deciduous *Quercus* species during glaciation (Brewer et al. 2002, Olalde et al. 2002, Rodríguez-Sánchez et al. 2010) and these populations are considered as a rear edge of the habitat distribution, which is important in determining habitat responses to expected climate change (Hampe and Petit 2005).

The populations of Pyrenean oak forests at Sierra Nevada are considered relict forests (Melendo and Valle 2000, Vivero et al. 2000), undergoing intensive anthropic use in the last few decades (Camacho-Olmedo et al. 2002, Valbuena-Carabaña et al. 2010). In fact, the status of conservation of this species for southern Spain is "Vulnerable" (Vivero et al. 2000). The relict presence of this species in Sierra Nevada is related both to its genetic resilience as well as to its high intraspecific genetic diversity (Valbuena-Carabaña and Gil 2013). However, they are also expected to suffer the impact of climate change, due to their climate requirements (wet summers). Thus, simulations of the climate change effects on this habitat forecast a reduction in suitable habitats for Sierra Nevada (Benito et al. 2011).

Datos de sequía.
----------------

-   :red\_circle: Meter aquí algunos datos de sequia, similar a lo planteado por Gazol

:red\_circle: `duda aqui` Varias referencias hablan de los años 2005 y 2012 como extremadamente secos. Pero habría que hacer alguna referencia y/o análisis. Tengo dudas de si hemos de analizar (e incluir) que efectivamente los años 2005 y 2012 fueron caracterizados por un extrema sequía, por lo que habría que incluyendo referencia a apéndice

-   O quizá un apartado llamado Drought episodes (similar a esto <https://www.nature.com/articles/srep28269>)

### Greenness data

To characterize the vegetation greenness of *Q. pyrenaica* we used the *Enhanced Vegetation Index* (EVI) derived from MOD13Q1 product obtained by the *Moderate Resolution Imaging Spectroradiometer* (MODIS) sensor (Didan 2015). EVI and NDVI (*Normalized Difference Vegetation Index*) are the most common greenness vegetation indices. We used EVI instead of NDVI because EVI is more sensitive to changes in high-biomass areas (a serious shortcoming of NDVI); EVI reduces the influence of atmospheric conditions on vegetation index values, and EVI corrects for canopy background signals (Huete et al. 2002, Cabello et al. 2012, Krapivin et al. 2015).

EVI data consits of 16-day maximun value composite images (23 per year) of the EVI value with a spatial resolution of 250 m x 250 m. We selected the pixels covering the distribution of *Q. pyrenaica* forests in Sierra Nevada (*n* = 928 pixels). MODIS EVI Data from Collection 6 were obtanied using Google Earth Engine platform for the period 2000 - 2016. A data filtering was applied to select EVI valid values. The filtering was done using quality flags and VI Usefulness Indices accompanying the EVI data. We filter out those values affected by high content of aerosols, clouds, shadows, snow or water.

Each 1 × 1 km2 16-day composite EVI value is considered valid when (a) EVI data is produced—'MODLAND\_QA' equals 0 (good quality) or 1 (check other QA), (b) VI usefulness is between 0 and 11, (c) clouds are absent—'adjacent cloud detected' (0), 'mixed clouds' (0) and 'possible shadow' (0), and (d) aerosol content is low or average—'aerosol quantity' (1 or 2). Note that 'MODLAND\_QA' checks whether EVI is produced or not, and if produced, its quality is good or whether other quality flags should also be checked. Besides, VI usefulness indices between 0 to 11 essentially include all EVI data. Thus, these two conditions serve as additional checks.

and then a quality assessment was carried out to filter the ... (Reyes-Díez et al. 2015)

    * According to @Reyes2015 we must consider the shadow in the mountain, but we can discard the filter of adjacent clouds. On the other hand, the use of EVI mean is highly stable under the use of any filter [@Reyes2015]

The presence of clouds (adjacent clouds, mixed clouds and shadows) 'obscures' the surface in a radiometric sense, thus corrupting inferred EVI values. In addition, two types of aerosol loadings typically corrupt EVI—climatology and high aerosols. Use of aerosol climatology

The EVI data are geometrically and atmospherically corrected and include information about the quality ass....

`$NOTA$`: NDVI sirve para estimar la producción primaria neta. Existen diferentes estudio que han evaluado el efecto de la sequía sobre la producción primaria neta utilizando NDVI.

These data are geometrically and atmospherically corrected, and include an index of data quality (reliability, which range from 0 – good quality data – to 4 – raw data or absent for different reasons) based on the environmental conditions in which the data was recorded

We first used the Quality Assesment (QA band) information of this product to filter out those values affected by high content of aerosols, clouds, shadows, snow or water; and then a quality assessment was carried out to filter the ... (Reyes-Díez et al. 2015)

:red\_circle: reescribir esto de la calidad. Ver Samanta et al 2012 y como describe el proceso de calidad

OJITO---------- reescribir esto de arriba

After the filter out process, we built the annual EVI profile for each pixel and then computed the EVI's annual mean values and the EVI anomaly for each pixel for the period 2000 - 2015. (:red\_circle: Hemos seleccionado EVI medio, además de por los consejos que me ha dicho Domingo, porque he comprobado que existe una correlación entre el evi medio y el evi estacional, sobre todo el de verano. Ver esto: <https://github.com/ajpelu/qpyr_modis_resilience/blob/master/analysis/prepare_modis_qa.md>. Además presenta alta correlaciones significativas con el EVI de verano: 0.88; de primavera: 0.76 y anual: 0.81)

> Procedimiento de Filtrado de datos (ver <https://github.com/ajpelu/qpyr_modis_resilience/blob/master/analysis/prepare_modis_qa.md>)

-   Información contenida en banda QA.

    -   Nos quedamos con pixeles marcados como Good Data (57.89 %)
    -   Filter out los marcados como Snow/Ice y/o Cloudy (2.57 + 7.08 = 9.65 %)
    -   Pixeles marcados como Marginal Data (32.33 %) (ver siguiente paso)
-   Explorar distribución temporal y analizar banda QA Detailed y llevar a cabo un filtrado siguiendo las especificaciones de Reyes-Díez et al. (2015).

    -   Vemos los composites marcados con Aerosoles, Adjacent cluods, y Shadow.
    -   According to Reyes-Díez et al. (2015) we must consider the shadow in the mountain, but we can discard the filter of adjacent clouds. On the other hand, the use of EVI mean is highly stable under the use of any filter (Reyes-Díez et al. 2015)
-   Finalmente nos hemos quedado con las siguientes cifras. De un total de 360064 images composites for the study zone were downloaded (928 x 20 x 1 + 928 x 23 x 16 = 360064), tras el filtrado, nos quedamos con 286825 (79.65 %)

To explore the effect of drought events on greenness we calculated the EVI standardized anomaly (*E**V**I* *s**a*) pixel-by-pixel, since it minimizes biases in the evaluation of anomalies, providing more information about the magnitude of the anomalies (Samanta et al. 2012, Gao et al. (2016)). For each pixel we averaged all the EVI valid values within a year (:red\_filter: see quality filter), and then the standardized anomaly was computed as:

$$\\mathrm{EVI\_{sa,\\mathit{i}}}= \\frac{\\mathrm{EVI\_{mean,\\mathit{i}}-EVI\_{mean,ref}}}{\\sigma\_{\\mathrm{ref}}}$$
 where *E**V**I*<sub>*s**a*, *i*</sub> is the EVI standardized anomaly for the year *i*; *E**V**I*<sub>*m**e**a**n*, *i*</sub> the annual mean value of EVI for the year *i*; *E**V**I*<sub>*m**e**a**n*, *r**e**f*</sub> the average of the annual EVI values for the period of reference (all except *i* year), and *σ*<sub>*r**e**f*</sub> the standard deviation for the reference period.

Each pixel was categorized according the EVI standardized anomalies as "greening" (EVI standardized anomalies greater than + 1), "browning" (EVI standardized anomalies less than - 1) or "no changes" (EVI standardized anomalies between − 1 and + 1)

Field sampling and dendrochronological methods
----------------------------------------------

### Tree sampling

Sampling was carried during autumn of 2016. Trees were sampled at two locations in contrasting slopes of Sierra Nevada: San Juan (SJ; northern site) and Cáñar (CA; southern site) (Figure 1; Table 1). For the southern site two elevations were sampled: CA-Low and CA-High. All the sites were oak monospecific and representatives of two of the three the population's cluster identified for the specie in this mountain range (:red\_circle: mejorar; citar Pérz-Luque et al..). In each site between 15 and 20 dominant trees were randomly selected. Two cores of 5 mm of diameter were taken from each at breast heigth (1.3 m) using an increment borer. Diameter at breast height (DBH) and total height were measured using a girth tape and a Vertex IV ultrasonic hypsometer (Haglöf, Sweden) respectively. We assessed stand competition of the target tree by recording all neighboring living trees with dbh &gt; 7.5 cm in a circle of 10 m radi. The species, dbh and total height were annotated. We also measured distance and azimuth to the target tree. (:red\_circle: indices competencia??)

### Dendroecological analyses

Tree cores were air dried, glued onto wooden mounts and sanded. Annual radial growth (ring width, RW) were measured with a LINTAB measuring device (Rinntech, Heidelberg, Germany) coupled to a stereomicroscope, with an accuracy of 0.01 mm. Individual ring series were visually and statistically cross-dated with TSAP software (Rinntech, Heidelberg, Germany), using the statistics Gleichläufigkeit (GLK), t-value and the crossdating index (CDI). Validation of the cross-dating was done using COFECHA software (Holmes 1983).

The growth trends were analyzed at different time scales. To study the response of growth to the inter-annual variability of climate (short-term response) we used pre-whitened residual chronologies calculated from ratios between raw growth measurements and individual cubic splines with a 50 % frequency cutoff at 30 years (Fritts 1976). Tree-ring width series were standardized and detrended using the `dplR` (Bunn 2008, 2010) package. Residual site chronologies were obtained computing the biweight robust mean of all prewhitened growth indices for the trees of the same site (Cook and Kairukstis 1990). The statistical quality of each chronology was checked via expressed population signal (Wigley et al. 1984). A threshold value of EPS &gt; 0.85 was used to determine the cutoff year of the time span that could be considered reliable.

The long-term growth response was analyzed using basal area increment (hereafter BAI, *c**m*<sup>2</sup> ⋅ *y**e**a**r*<sup>−1</sup>). BAI represents a more accurate indicator of growth than ring-width, since it removes variation in growth attributable to increasing stem circumference (Biondi and Qeadan 2008). We used measured dbh and raw nondetrened ring-widths to compute BAI by subtracting twice the annual ring width from the annual diameter, starting from the measured diameter outside the bark (Piovesa et al. 2008). We used the following equation:

*B**A**I* = *π*(*r*<sub>*t*</sub><sup>2</sup> − *r*<sub>*t* − 1</sub><sup>2</sup>)
 where *r* is the radius of the tree and *t* is the year of tree-ring formation. We calculated a mean BAI serie for each individual tree. Site BAI chronologies were obtained by averaging individual tree BAI time series.

una frase conectora We also explored the climate-growth relationships and the disturbance ...

### Climate and growth

Climate data were obtained from the European Daily High-Resolution Observational Gridded Dataset (E-OBS v16) (Haylock et al. 2008). Monthly precipitation and mean, minimum and maximum temperatures were obtained at a 0.25 x 0.25 º resolution for the 1950-2016 period. We selected grid cells covering each sampled sites. Data were downloaded and preprocess using the climate4R bundle (<http://www.meteo.unican.es/en/climate4R>) (Cofiño et al. 2018, Frías et al. (2018)). We also used the Standardized Precipitation-Evapotranspiration Index (SPEI), a multiscalar drought index that incorporates both precipitation and temperature (Vicente-Serrano et al. 2010, Beguería et al. 2014). SPEI values for the period 1961-2014 were obtained with a spatial resolution of 1.1 km from the Drought indices dataset for Spain database (<http://monitordesequia.csic.es/>), a high resolution database of drought indices for Spain (Vicente-Serrano et al. 2017). We select a temporal scale of 6 months.

The relationships between residual site chronologies and the climatic variables were assessed by a bootstrapped Pearson's correlation estimate using the `treeclim` package (Zang and Biondi 2015). The bootstrapped confidence intervals were used to estimate the significance (p &lt; 0.05) of the correlation coefficients.

### Disturbance analyses

Disturbance chronologies were built using tree-ring width to identify abrupt and sustained increases (releases) or decreases (supressions) in radial growth (Nowacki and Abrams 1997). ... This approach minimizes the long-term growth trends and interannual growth variations usually driven by climate, while enhances decadal abrupt and sustained radial-growth changes characteristic of forest disturbances. By using a temporal window of reasonable length, this method filters out the response to short-term changes in temperature and precipitation (Nowacki and Abrams 1997, Fraver and White (2005)).

Growth changes (GC) were calculated for the individual tree-ring series using a 10-year running window as either positive (PGC) or negative (NGC) growth changes:

$$\\mathrm{\\% GC} = \\left \[ \\frac{\\left ( M1 - M2 \\right )}{M2}\\right\] \\times 100 $$
 where *M*1 is preceding 10-year median and *M*2 is subsequent 10-year median. We used medians since they are mores robust estimator of central tendency than means (Rubino and McCarthy 2004, Camarero et al. 2011). Site disturbance chronologies were constructed by averaging the individual disturbances series annually. A

To separate growth periods produced by disturbance events from those by climate, we considered a threshold of 25 % of GC for consi

A minimum *G**C* of 25% was established to depict canopy disturbances. Furthermore, more than 50% of the individual trees displaying the same growth changes was considered a stand-wise disturbance.

This approach filters out

We used the percentage Growth-change filter (GC).

, calculated annually using 10-year windows

Disturbance chronologies were built using tree-ring width to identify historical abrupt positive (releases) or negative (suppressions) changes in growth in each species (Nowacki and Abrams, 1997). This approach minimizes the long-term growth trends and interannual growth variations usually driven by climate, while enhances decadal abrupt and sustained radial-growth changes characteristic of forest disturbances.

Statistical descriptive parameters (Fritts, 2001), including the mean, standard deviation, first-order autocorrelation of raw series, the mean sensitivity (a measure of the year-to-year variability) and the mean correlation between individual series of residual ring-width indices, were also calculated for each site chronology considering the common 1950–2013 period.

The chronologies were computed as bi-weight robust mean to reduce the bias caused by extreme values and an autoregressive model was applied to remove the autocorrelation of the series (Cook and Kairiukstis 1990).

To explore similarity within locality, each site chronology was smoothed using centred moving averages with different window sizes, and then Pearson's correlation coefficient between the two chronologies of the same locality (higher and lower elevation) were calculated. Significance was tested using 1000 boostrap replicates and with 95 % confidence intervals built using the R packgae `boot` (Canty and Ripley 2016)

-   GC Nowacki??

Resilience
----------

To evaluate the effects of the disturbance events on greeennes and tree growth we used four resilience indices proposed by Lloret et al. (2011): resilience (*Rs*), resistance (*Rt*), recovery (*Rc*) and relative resilience (*RRs*).

The resistance index (*Rt*) quantifies the severity of the impact of the disturbance in the year it occurred. It is estimated as the ratio between the performance during and befor the disturbance:

Resistance (*Rt*) = Drought / Predrought

The Recovery index (*Rc*) is the ability to recover from disturbance relative to its severity, and it is estimated as the ratio between performance after and during disturbance:

Recovery (*Rc*) = Postdrought / Drought

The Resilience index (*Rs*) is the capacity to reach pre-disturbance performance levels, and it is estimated as the ratio between the performance after and before disturbance:

Resilience (*Rs*) = Postdrought / Predrought

The Relative Resilience (*RRs*) is the resilience weighted by the severity of the disturbance, and it is estimated as:

Relative Resilience (*RRs*) = (Postdrought - Drought) / Predrought

We computed the values of these indices for tree growth and greenness during each drought event. We considered 2005 and 2012 as singles drought events. The predrought and postdrought values of each target variable (i.e.: tree growth or EVI) we computed as the mean value during a period of three years before and after the disturbance events respectively. A period of three years was chosen because we found similar results comparing periods of two, three and four years (:red\_circle: incluir tabla de coeficientes y/o gráfica?? como suplement, see Gazol 2017)

Statistical analysis
--------------------

-   Explore anomalies EVI
-   Explore long and short term trends in RW :red\_circle: ver correo Guillermo
-   ANOVA analysis EVI events and populations

We tested for significant differences between drought events (2005 and 2012) and oak population (northern and southern slopes) for each of the resilience indices. Robust two-way ANOVAs were used beacuse original and log-transformed data both did not match the assumptions of normality and homogeneity of variance (Wilcox 2012). Robust measures of central tendency (M-estimator based on Huber's Psi) were used since they were close to mean value in all cases (Wilcox 2012). When running the robust ANOVA test, data were boostrapped 3000 times and trimmed automatically to control the potential influence of outliers (Field et al. 2012, Wilcox (2012)). Post-hoc differences were assessed pairwise using a similar boostrap test. All the robust ANOVA and post-hoc tests were carried out using the WRS2 (Mair et al. 2017) and rcompanion (Mangiafico 2017) R packages. The level of significance was set at 0.05 and adjusted for multiple comparisons.

All analyses were carried out in R software (ver. 2.11.1), using library dplR to standardize data, library nlme to fit the mixed models and vegan to run the PCA. All tests were at α = 0.05, except when indicated.

References
----------

Beguería, S., S. M. Vicente-Serrano, F. Reig, and B. Latorre. 2014. Standardized precipitation evapotranspiration index (spei) revisited: Parameter fitting, evapotranspiration models, tools, datasets and drought monitoring. International Journal of Climatology 34:3001–3023.

Biondi, F., and F. Qeadan. 2008. A theory-driven approach to tree-ring standardization: Defining the biological trend from expected basal area increment. Tree-Ring Research 64:81–96.

Bunn, A. G. 2008. A dendrochronology program library in r (dplR). Dendrochronologia 26:115–124.

Bunn, A. G. 2010. Statistical and visual crossdating in r using the dplR library. Dendrochronologia 28:251–258.

Cabello, J., D. Alcaraz-Segura, R. Ferrero, A. Castro, and E. Liras. 2012. The role of vegetation and lithology in the spatial and inter-annual response of {evi} to climate in drylands of southeastern spain. Journal of Arid Environments 79:76–83.

Camarero, J. J., C. Bigler, J. C. Linares, and E. Gil-Pelegrín. 2011. Synergistic effects of past historical logging and drought on the decline of pyrenean silver fir forests. Forest Ecology and Management 262:759–769.

Canty, A., and B. D. Ripley. 2016. Boot: Bootstrap r (s-plus) functions.

Cofiño, A., J. Bedia, M. Iturbide, M. Vega, S. Herrera, J. Fernández, M. Frías, R. Manzanas, and J. Gutiérrez. 2018. The ecoms user data gateway: Towards seasonal forecast data provision and research reproducibility in the era of climate services. Climate Services.

Cook, E., and L. Kairukstis. 1990. Methods of dendrochronology: Applications in the environmental sciences. Springer, Doredrecht.

Didan, K. 2015. MOD13Q1 MODIS/Terra Vegetation Indices 16-Day L3 Global 250m SIN Grid V006. NASA EOSDIS Land Processes DAAC.

Field, A., J. Miles, and Z. Field. 2012. Discovering statistics using r. Page 1426. SAGE.

Franco, A. 1990. Quercus l. Pages 15–36 *in* A. Castroviejo, M. Laínz, G. López-González, P. Montserrat, F. Muñoz-Garmendia, J. Paiva, and L. Villar, editors. Flora ibérica. Real Jardín Botánico, CSIC, Madrid.

Fraver, S., and A. S. White. 2005. Identifying growth releases in dendrochronological studies of forest disturbance. Canadian Journal of Forest Research 35:1648–1656.

Fritts, H. C. 1976. Tree rings and climate. Academic Press, London.

Frías, M., M. Iturbide, R. Manzanas, J. Bedia, J. Fernández, S. Herrera, A. Cofiño, and J. Gutiérrez. 2018. An r package to visualize and communicate uncertainty in seasonal climate prediction. Environmental Modelling & Software 99:101–110.

Gao, Q., W. Zhu, M. W. Schwartz, H. Ganjurjav, Y. Wan, X. Qin, X. Ma, M. A. Williamson, and Y. Li. 2016. Climatic change controls productivity variation in global grasslands. Scientific Reports:26958.

Haylock, M. R., N. Hofstra, A. M. G. Klein Tank, E. J. Klok, P. D. Jones, and M. New. 2008. A european daily high-resolution gridded data set of surface temperature and precipitation for 1950–2006. Journal of Geophysical Research 113:D20119.

Holmes, R. L. 1983. Computer-assisted quality control in tree-ring dating and measurement. Tree-Ring Bulletin 43:69–78.

Huete, A., K. Didan, T. Miura, E. Rodriguez, X. Gao, and L. Ferreira. 2002. Overview of the radiometric and biophysical performance of the {modis} vegetation indices. Remote Sensing of Environment 83:195–213.

Krapivin, V. F., C. A. Varotsos, and V. Y. Soldatov. 2015. Remote-sensing technologies and data processing algorithms. Pages 119–219 *in* New ecoinformatics tools in environmental science: Applications and decision-making. Springer International Publishing.

Lloret, F., E. G. Keeling, and A. Sala. 2011. Components of tree resilience: Effects of successive low-growth episodes in old ponderosa pine forests. Oikos 120:1909–1920.

Mair, P., F. Schoenbrodt, and R. Wilcox. 2017. WRS2: Wilcox robust estimation and testing.

Mangiafico, S. 2017. Rcompanion: Functions to support extension education program evaluation.

Nowacki, G. J., and M. D. Abrams. 1997. Radial-growth averaging criteria for reconstructing disturbance histories from presettlement-origing oaks. Ecological Monographs 67:225–249.

Piovesa, G., F. Biondi, A. D. Filippo, A. Alessandrini, and M. Maugeri. 2008. Drought-driven growth reduction in old beech (fagus sylvatica l.) forests of the central apennines, italy. Global Change Biology 14:1265–1281.

Reyes-Díez, A., D. Alcaraz-Segura, and J. Cabello-Piñar. 2015. Implicaciones del filtrado de calidad del índice de vegetación evi para el seguimiento funcional de ecosistemas. Revista de Teledeteccion 2015:11–29.

Rivas-Martínez, S., T. Díaz, F. Fernández-González, J. Izco, J. Loidi, and M. Lousã. 2002. Vascular plant communities of spain and portugal. addenda to the syntaxonomical checklist of 2001. part ii. Itinera Geobotanica 15:5–922.

Rubino, D., and B. McCarthy. 2004. Comparative analysis of dendroecological methods used to assess disturbance events. Dendrochronologia 21:97–115.

Samanta, A., S. Ganguly, E. Vermote, R. R. Nemani, and R. B. Myneni. 2012. Interpretation of variations in modis-measured greenness levels of amazon forests during 2000 to 2009. Environmental Research Letters 7:024018.

Vicente-Serrano, S. M., S. Beguería, and J. I. López-Moreno. 2010. A multiscalar drought index sensitive to global warming: The standardized precipitation evapotranspiration index. Journal of Climate 23:1696–1718.

Vicente-Serrano, S. M., M. Tomas-Burguera, S. Beguería, F. Reig, B. Latorre, M. Peña-Gallardo, M. Y. Luna, A. Morata, and J. C. González-Hidalgo. 2017. A high resolution dataset of drought indices for spain. Data 2.

Vilches de la Serna, B. 2014. Comprehensive study of “quercus pyrenaica” willd. forests at iberian peninsula: Indicator species, bioclimatic, and syntaxonomical characteristics. PhD thesis, Complutense University of Madrid, Madrid.

Wigley, T. M. L., K. R. Briffa, and P. D. Jones. 1984. On the average value of correlated time series, with applications in dendroclimatology and hydrometeorology. Journal of Climate and Applied Meteorology 23:201–213.

Wilcox, R. 2012. Introduction to robust estimation and hypothesis testing (third edition). Page 608. Third Edition. Academic Press.

Zang, C., and F. Biondi. 2015. Treeclim: An r package for the numerical calibration of proxy-climate relationships. Ecography 38:431–436.
