-   [Materials and methods](#materials-and-methods)
    -   [Species and study site](#species-and-study-site)
    -   [Datos de sequía.](#datos-de-sequia.)
        -   [Greenness data](#greenness-data)
    -   [Field sampling and dendrochronological methods](#field-sampling-and-dendrochronological-methods)
        -   [Tree sampling](#tree-sampling)
    -   [Dendrochronological methods](#dendrochronological-methods)
    -   [Resilience](#resilience)
    -   [Statistical analysis](#statistical-analysis)
    -   [References](#references)

Materials and methods
=====================

Species and study site
----------------------

The Pyrenean oak (*Quercus pyrenaica* Willd.) forests extend through south-western France and the Iberian Peninsula (Franco, 1990) reaching its southern limit in north of Morocco. In the Iberian Peninsula these forests live under meso-supramediterranean and mesotemperate areas and subhumid, humid and hyperhumid ombroclimate (S, 2002) living on siliceous soils, or soils poor in basic ions (Serna, 2014). *Q. pyrenaica* requires between 650 and 1200 mm of annual precipitation and a summer minimal precipitation between 100 and 200 mm (Martínez-Parras and Molero-Mesa 1982, García and Jiménez 2009), with summer rainfall being a key factor in the distribution of the species (Gavilán et al. 2007, Río et al. 2007).

This species reaches its southernmost European limit at Sierra Nevada, a high-mountain range located in southern Spain (37°N, 3°W) with elevations of between 860 m and 3482 m a.s.l. The climate is Mediterranean, characterized by cold winters and hot summers, with pronounced summer drought (July-August). There are eight oak patches (2400 Has) identified (:red\_circle: FIGURE) in this mountain range, ranging between 1100 and 2000 *m a.s.l.* and generally associated to major river valleys. Sierra Nevada is considered a glacial refugia for deciduous *Quercus* species during glaciation (Brewer et al. 2002, Olalde et al. 2002, Rodríguez-Sánchez et al. 2010) and these populations are considered as a rear edge of the habitat distribution, which is important in determining habitat responses to expected climate change (Hampe and Petit 2005).

<table style="width:8%;">
<colgroup>
<col width="8%" />
</colgroup>
<tbody>
<tr class="odd">
<td>:red_circle: <code>duda aqui</code> Varias referencias hablan de los años 2005 y 2012 como extremadamente secos. Pero habría que hacer alguna referencia y/o análisis. Tengo dudas de si hemos de analizar (e incluir) que efectivamente los años 2005 y 2012 fueron caracterizados por un extrema sequía, por lo que habría que incluyendo referencia a apéndice</td>
</tr>
<tr class="even">
<td>* O quizá un apartado llamado Drought episodes (similar a esto <a href="https://www.nature.com/articles/srep28269" class="uri">https://www.nature.com/articles/srep28269</a>)</td>
</tr>
</tbody>
</table>

The populations of Pyrenean oak forests at Sierra Nevada are considered relict forests (Melendo and Valle 2000, Vivero et al. 2000), undergoing intensive anthropic use in the last few decades (Camacho-Olmedo et al. 2002, Valbuena-Carabaña et al. 2010). In fact, the status of conservation of this species for southern Spain is "Vulnerable" (Vivero et al. 2000). The relict presence of this species in Sierra Nevada is related both to its genetic resilience as well as to its high intraspecific genetic diversity (Valbuena-Carabaña and Gil 2013). However, they are also expected to suffer the impact of climate change, due to their climate requirements (wet summers). Thus, simulations of the climate change effects on this habitat forecast a reduction in suitable habitats for Sierra Nevada (Benito et al. 2011).

:red\_circle: La figura 1 puede tener un mapa de localización de SN, otro de las poblaciones de roble (clasificadas por colores: cluster; y señalando las dos poblaciones muestradas en dendro). Ver MIGRAME dataset

Datos de sequía.
----------------

-   :red\_circle: Meter aquí algunos datos de sequia, similar a lo planteado por Gazol

### Greenness data

To characterize the vegetation greeness of *Quercus pyrenaica* we used the Enhanced Vegetation Index (EVI) derived from MOD13Q1 product obtained by the Moderate Resolution Imaging Spectroradiometer (MODIS) sensor (Didan, 2015). EVI and NDVI (Normalized Difference Vegetation Index) are the most common greenness vegetation indices. We used EVI instead of NDVI (Normalized Difference Vegetation Index) because EVI is more sensitive to changes in high-biomass areas (a serious shortcoming of NDVI); EVI reduces the influence of atmospheric conditions on vegetation index values, and EVI corrects for canopy background signals (Huete *et al.*, 2002, Krapivin *et al.* (2015), Cabello *et al.* (2012)).

EVI product consits of 16-day maximun value composite images (23 per year) of the EVI value with a spatial resolution of 231 m x 231 m. Data were obtained using a Google Earth Engine script (:red\_circle: cite gists) for the 2000 - 2016 period. We selected the pixels covering the distribution of Quercus pyrenaica forests in Sierra Nevada (*n* = 928 pixels). The EVI data are geometrically and atmospherically corrected and include information about the quality ass.... :red\_circle:

`$NOTA$`: NDVI sirve para estimar la producción primaria neta. Existen diferentes estudio que han evaluado el efecto de la sequía sobre la producción primaria neta utilizando NDVI.

These data are geometrically and atmospherically corrected, and include an index of data quality (reliability, which range from 0 – good quality data – to 4 – raw data or absent for different reasons) based on the environmental conditions in which the data was recorded

We first used the Quality Assesment (QA band) information of this product to filter out those values affected by high content of aerosols, clouds, shadows, snow or water; and then a quality assessment was carried out to filter the ... (Reyes-Díez *et al.*, 2015)

:red\_circle: reescribir esto de la calidad.

After the filter out process, we built the annual EVI profile for each pixel and then computed the EVI's annual mean values and the EVI anomaly for each pixel for the period 2000 - 2015. (:red\_circle: Hemos seleccionado EVI medio, además de por los consejos que me ha dicho Domingo, porque he comprobado que existe una correlación entre el evi medio y el evi estacional, sobre todo el de verano. Ver esto: <https://github.com/ajpelu/qpyr_modis_resilience/blob/master/analysis/prepare_modis_qa.md>. Además presenta alta correlaciones significativas con el EVI de verano: 0.88; de primavera: 0.76 y anual: 0.81)

> Procedimiento de Filtrado de datos (ver <https://github.com/ajpelu/qpyr_modis_resilience/blob/master/analysis/prepare_modis_qa.md>)

-   Información contenida en banda QA.

    -   Nos quedamos con pixeles marcados como Good Data (57.89 %)
    -   Filter out los marcados como Snow/Ice y/o Cloudy (2.57 + 7.08 = 9.65 %)
    -   Pixeles marcados como Marginal Data (32.33 %) (ver siguiente paso)
-   Explorar distribución temporal y analizar banda QA Detailed y llevar a cabo un filtrado siguiendo las especificaciones de Reyes-Díez *et al.* (2015).

    -   Vemos los composites marcados con Aerosoles, Adjacent cluods, y Shadow.
    -   According to Reyes-Díez *et al.* (2015) we must consider the shadow in the mountain, but we can discard the filter of adjacent clouds. On the other hand, the use of EVI mean is highly stable under the use of any filter (Reyes-Díez *et al.*, 2015)
-   Finalmente nos hemos quedado con las siguientes cifras. De un total de 360064 images composites for the study zone were downloaded (928 x 20 x 1 + 928 x 23 x 16 = 360064), tras el filtrado, nos quedamos con 286825 (79.65 %)

To explore the effect of drought events on greenness we used the EVI standardized anomaly (EVI~sa)

calculated pixel-by-pixel. For each pixel we averaged all the EVI valid values within a year, and then the standardized anomaly was computed as:

$$\\mathrm{EVI\_{sa,\\mathit{i}}}= \\frac{\\mathrm{EVI\_{mean,\\mathit{i}}-EVI\_{mean,ref}}}{\\sigma\_{\\mathrm{ref}}}$$

(anomaly divided by the standard deviation) are calculated pixel-by-pixel

The SAs, which are also referred to as normalized anomalies, are calculated by dividing the anomalies by the standard deviation. The SAs generally provide more information about the magnitude of the anomalies, because the influences of dispersion have been removed.

En el caso de las anomalías estandarizadas, utilizamos la aproximación de Gao et al. (2016) [doi:10.1038/srep26958](https://dx.doi.org/10.1038/srep26958), donde las anomalias las dividimos por la desviación estandar de los valores de EVI medio para el periodo de referencia. Las anomalías estandarizadas generalmente proporcionan mas información referente a la magnitud de la anomalía ya que las potenciales influencias de la dispersión de los datos han sido eliminadas. Por tanto las anomalías estandarizadas se calculan como: sa = (evi\_year - evi\_ref) / sd\_ref.

Field sampling and dendrochronological methods
----------------------------------------------

### Tree sampling

Samplig was carried during autumn of 2016. Trees were sampled at two locations located in contrasting slopes of Sierra Nevada: San Juan (SJ; northern site) and Cáñar (CA; southern site) (Table 1). Both sites were oak monospecific and representatives of two of the three the population's cluster identified for the specie in this mountain range (:red\_circle: mejorar; citar Pérz-Luque et al..). In each site between 15 and 20 dominant trees were randomly selected. Two cores of 5 mm of diameter were taken per tree at 1.3 m using an increment borer. Diameter at breat height (DBH) and total height were recorded for each tree. Increment cores were air dried, glued onto wooden mounts and sanded. Annual radial growth (ring width, RW) were measured with a LINTAB measuring device (:red\_circle: Rinntech 2003) coupled to a stereomicroscope, with an accuracy of 0.01 mm. Individual ring series were visually and statistically cross-dated with TSAP software (:red\_circle: Frank Rinn, Heidelberg, Germany), using the statistics Gleichläufigkeit (GLK), t-value and the crossdating index (CDI). Validation of the croos-dating was done using COFECHA software (Holmes, 1983).

Dendrochronological methods
---------------------------

... dendro For each focal tree we measured diameter at breast height (DBH) and total height. A total of xx trees were sampled. ...

We built chronologies for each site (two)

Site chronologies were built by averaging all tree BAI measurement of the same site. To explore similarity within locality, each site chronology was smoothed using centred moving averages with different window sizes, and then Pearson's correlation coefficient between the two chronologies of the same locality (higher and lower elevation) were calculated. Significance was tested using 1000 boostrap replicates and with 95 % confidence intervals built using the R packgae `boot` (Canty & Ripley, 2016)

Resilience
----------

To evaluate the effects of the disturbance events on greeennes and tree growth we used four resilience indices proposed by Lloret *et al.* (2011): resilience (*Rs*), resistance (*Rt*), recovery (*Rc*) and relative resilience (*RRs*).

The resistance index (*Rt*) quantifies the severity of the impact of the disturbance in the year it occurred. It is estimated as the ratio between the performance during and befor the disturbance:

Resistance (*Rt*) = Drought / Predrought

The Recovery index (*Rc*) is the ability to recover from disturbance relative to its severity, and it is estimated as the ratio between performance after and during disturbance:

Recovery (*Rc*) = Postdrought / Drought

The Resilience index (*Rs*) is the capacity to reach pre-disturbance performance levels, and it is estimated as the ratio between the performance after and before disturbance:

Resilience (*Rs*) = Postdrought / Predrought

The Relative Resilience (*RRs*) is the resilience weighted by the severity of the disturbance, and it is estimated as:

Relative Resilience (*RRs*) = (Postdrought - Drought) / Predrought

We computed the values of these indices for tree growth and greenness during each drought event. We considered 2005 and 2012 as singles drought events. The Predrought and Postdrought values of each target variable (i.e.: tree growth or EVI) we computed as the mean value during a period of three years before and after the disturbance events respectively. (:red\_circle: Incluir algo de computación de ventana temporal 2,3,4 años: hacerlo tanto en dendro como en EVI)

Statistical analysis
--------------------

-   Explore anomalies EVI
-   Explore long and short term trends in RW :red\_circle: ver correo Guillermo
-   ANOVA analysis EVI events and populations

References
----------

Cabello, J., Alcaraz-Segura, D., Ferrero, R., Castro, A. & Liras, E. (2012) The role of vegetation and lithology in the spatial and inter-annual response of {evi} to climate in drylands of southeastern spain. *Journal of Arid Environments*, **79**, 76–83.

Canty, A. & Ripley, B.D. (2016) *Boot: Bootstrap r (s-plus) functions*,

Didan, K. (2015) MOD13Q1 MODIS/Terra Vegetation Indices 16-Day L3 Global 250m SIN Grid V006. NASA EOSDIS Land Processes DAAC.

Franco, A. (1990) *Quercus l.* *Flora ibérica* (ed. by A. Castroviejo), M. Laínz), G. López-González), P. Montserrat), F. Muñoz-Garmendia), J. Paiva), and L. Villar), pp. 15–36. Real Jardín Botánico, CSIC, Madrid.

Holmes, R.L. (1983) Computer-assisted quality control in tree-ring dating and measurement. *Tree-Ring Bulletin*, **43**, 69–78.

Huete, A., Didan, K., Miura, T., Rodriguez, E., Gao, X. & Ferreira, L. (2002) Overview of the radiometric and biophysical performance of the {modis} vegetation indices. *Remote Sensing of Environment*, **83**, 195–213.

Krapivin, V.F., Varotsos, C.A. & Soldatov, V.Y. (2015) *Remote-sensing technologies and data processing algorithms*. *New ecoinformatics tools in environmental science: Applications and decision-making*, pp. 119–219. Springer International Publishing.

Lloret, F., Keeling, E.G. & Sala, A. (2011) Components of tree resilience: Effects of successive low-growth episodes in old ponderosa pine forests. *Oikos*, **120**, 1909–1920.

Reyes-Díez, A., Alcaraz-Segura, D. & Cabello-Piñar, J. (2015) Implicaciones del filtrado de calidad del índice de vegetación evi para el seguimiento funcional de ecosistemas. *Revista de Teledeteccion*, **2015**, 11–29.

S, R.-M. (2002) Vascular plant communities of spain and portugal. addenda to the syntaxonomical checklist of 2001. part ii. *Itinera Geobotanica*, **15**, 5–922.

Serna, B.V. de la (2014) Comprehensive study of “quercus pyrenaica” willd. forests at iberian peninsula: Indicator species, bioclimatic, and syntaxonomical characteristics. 194.
