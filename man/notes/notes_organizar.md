
```{r echo=FALSE, results='asis', eval=show_text}
cat("

")
```


# Notas

## Sequias 

In the Iberian Peninsula, major drought episodies were recorded in 1943, 1981, 1995, 2000 and 2005 [@VicenteSerrano2014; @Guerreiro2017]. The 2004/2005 and 2011/2012 hydrological years are considered two of the worst drought periods recorded in the Iberian Peninsula, particularly in the southern sector [@GarciaHerrera2007; @Gouveia2015; @Trigo2013; @Guerreiro2017; @Pascoa2017]. These events were extreme in both its magnitude and spatial extent [@Gouveia2014].

These climatic alterations are likely to have important consequences for tree species dynamics at local and regional scales ( Peñuelas and Boada 2003 , Van Mantgem et al. 2009 , Matías and Jump 2015 ).


* the drought events have been longest and most severe in the period 1991-2010 for mediterranean are of Southern Europe  
* Seasonally, drought frequency is projected to increase everywhere in Europe for both scenarios in spring and summer, especially over southern Europe, and less intensely in autumn [@Spinoni2017a]
Aumento de la frecuencia de sequías en spring and summer desde 1950 hasta 2014 [@Spinoni2017b]
Both for frequency and severity, the evolution towards drier conditions is more relevant in the last three decades over Mediterranean area in summer, 
> an increase in the drought severity in the Iberian Peninsula has been observed in the last decades [@VicenteSerrano2014]. 

Althought several works have reported these two years as some of the worst drought events, we characterised the drought at several spatio-temporal scales in the study area. From a long-term perspective, we compare the accumulated monthly precipitation at a meteorological station (Granada, Base Aérea) during the hydrological years 2004-2005 and 2011-2012 with the average of accumulated monthly precipitation for the period 1950-2015.

### Extreme sequias y ecologia 

No solo efectos aislados, sino también en conjunción con otros factores, sobre todo en el mediterráneo donde convergen muchos de los factores que pueden interaccionar: 

* La sequía es un factor crucial a tener en cuenta, ya que es además de los efectos que puede tener de forma aislada, se ha visto que además presenta muchas interacciones con otros factores, siendo por tanto un factor crucial (`$IMPROVE$` ver [@DoblasMiranda2017]):
* Some interactions alter the effects of a single factor, as drought enhances or decreases the effects of atmospheric components on plant ecophysiology
* Drought and land use changes, among others, alter water resources and lead to land degradation, vegetation regeneration decline, and expansion of forest diseases.
* Climate change, and especially drought, emerges as a crucial factor in most of the reviewed interactions and therefore it should be considered when it comes to designing and applying international management policies
* Drought should be considered when designing and applying management policies.


Además la sequía se espera que tengan ...Droughts are most likely to have the largest and most long-lasting impacts globally due to large indirect and lagged impacts and long recovery especially for forest ecosystems (ver  18 en @Ummenhofer2017). Así por ejemplo se ha visto que todos los biomas presentan una vulnerabilidad similar ...
En una revision sobre la vulnerabilidad del sistema de trasnporte en plantas al embolismo inducido por sequía, ha mostrado que una convergencia de la vulnerabilidad de los bosques a la sequía, mostrando que todos los biomas son igualmente vulnerables a los fallos hidráulicos independientemente del régimen de precipitación (Choat et al. 2012, doi:10.1038/nature11688)


* Ver ejemplo Gazol et al 2017 Plan Ecology
* un apartado llamado Drought episodes (similar a esto https://www.nature.com/articles/srep28269)

# EVI
We used EVI instead of NDVI (*Normalized Difference Vegetation Index*; another of the most common greenness vegetation indices) because EVI is more sensitive to changes in high-biomass areas (a serious shortcoming of NDVI); EVI reduces the influence of atmospheric conditions on vegetation index values, and EVI corrects for canopy background signals [@Huete2002; @Krapivin2015; @Cabello2012]. 

Each 1 × 1 km2 16-day composite EVI value is considered valid when (a) EVI data is produced—'MODLAND_QA' equals 0 (good quality) or 1 (check other QA), (b) VI usefulness is between 0 and 11, (c) clouds are absent—'adjacent cloud detected' (0), 'mixed clouds' (0) and 'possible shadow' (0), and (d) aerosol content is low or average—'aerosol quantity' (1 or 2). Note that 'MODLAND_QA' checks whether EVI is produced or not, and if produced, its quality is good or whether other quality flags should also be checked. Besides, VI usefulness indices between 0 to 11 essentially include all EVI data. Thus, these two conditions serve as additional checks.



and then a quality assessment was carried out to filter the ... [@Reyes2015] 

    * According to @Reyes2015 we must consider the shadow in the mountain, but we can discard the filter of adjacent clouds. On the other hand, the use of EVI mean is highly stable under the use of any filter [@Reyes2015]


The presence of clouds (adjacent clouds, mixed clouds and shadows) 'obscures' the surface in a radiometric sense, thus corrupting inferred EVI values. In addition, two types of aerosol loadings typically corrupt EVI—climatology and high aerosols. Use of aerosol climatology 


The EVI data are geometrically and atmospherically corrected and include information about the quality ass.... 

These data are geometrically and atmospherically corrected, and include an index of data quality (reliability, which range from 0 – good quality data – to 4 – raw data or absent for different reasons) based on the environmental conditions in which the data was recorded

We first used the Quality Assesment (QA band) information of this product to filter out those values affected by high content of aerosols, clouds, shadows, snow or water; and then a quality assessment was carried out to filter the ... [@Reyes2015] 

:red_circle: reescribir esto de la calidad. Ver Samanta et al 2012 y como describe el proceso de calidad

(:red_circle: Hemos seleccionado EVI medio, además de por los consejos que me ha dicho Domingo, porque he comprobado que existe una correlación entre el evi medio y el evi estacional, sobre todo el de verano. Ver esto: [https://github.com/ajpelu/qpyr_modis_resilience/blob/master/analysis/prepare_modis_qa.md](https://github.com/ajpelu/qpyr_modis_resilience/blob/master/analysis/prepare_modis_qa.md). Además presenta alta correlaciones significativas con el EVI de verano: 0.88; de primavera: 0.76 y anual: 0.81)


> Procedimiento de Filtrado de datos (ver [https://github.com/ajpelu/qpyr_modis_resilience/blob/master/analysis/prepare_modis_qa.md](https://github.com/ajpelu/qpyr_modis_resilience/blob/master/analysis/prepare_modis_qa.md))

* Información contenida en banda QA. 

    * Nos quedamos con pixeles marcados como Good Data (57.89 %)
    * Filter out los marcados como Snow/Ice y/o Cloudy (2.57 + 7.08 = 9.65 %)
    * Pixeles marcados como Marginal Data (32.33 %) (ver siguiente paso)

* Explorar distribución temporal y analizar banda QA Detailed y llevar a cabo un filtrado siguiendo las especificaciones de @Reyes2015.  

    * Vemos los composites marcados con Aerosoles, Adjacent cluods, y Shadow.  
    * According to @Reyes2015 we must consider the shadow in the mountain, but we can discard the filter of adjacent clouds. On the other hand, the use of EVI mean is highly stable under the use of any filter [@Reyes2015]
    
* Finalmente nos hemos quedado con las siguientes cifras. De un total de 360064 images composites for the study zone were downloaded (928 x 20 x 1 + 928 x 23 x 16 = 360064), tras el filtrado, nos quedamos con 286825 (79.65 %)

## SPEI 
SPEI values between 1 and −1 are considered normal, whereas values <−1 indicate drought and values <−1.5 indicate severe drought47. We defined a drought as a period where SPEI12 decreased to ≤−1.5. 

* Para obtener los datos de SPEI, hemos ido bajado los datos desde http://sac.csic.es/spei/map/maps.html 
* sanjuan: 37.133, -3.382 = spei_-3.25_37.25.csv 
* canar: 36.957, -3.4284 = spei_-3.25_36.75.csv

OJO ver http://monitordesequia.csic.es/

## Growth changes
### Disturbances 
This approach minimizes the long-term growth trends and interannual growth variations usually driven by climate, while enhances decadal abrupt and sustained radial-growth changes characteristic of forest disturbances. 

Disturbance chronologies were built using tree-ring width to identify historical abrupt positive (releases) or negative (suppressions) changes in growth in each species (Nowacki and Abrams, 1997). This approach minimizes the long-term growth trends and interannual growth variations usually driven by climate, while enhances decadal abrupt and sustained radial-growth changes characteristic of forest disturbances.

# Dendrocronology
To obtain ring-width series of each individual and species (species chronology) the cross-dated ring-width series were standardized and detrended using the dplR library (Bunn 2010) in the R statistical language (R Development Core Team 2015). First, we fitted a spline through the ring-width series of each measured radius. We used a spline where the frequency response is 0.5 at a wavelength of 0.67 multiplied by the length of the series in years (Bunn 2010). Then, the ring-width data were divided by the fitted lines to obtain residual ring-width indices (RWI) that were subjected to autoregressive modelling (pre-whitening) and then averaged for each year using a biweight robust estimation of the mean (Fritts 1976). Calculating RWIs using subtraction instead of division rendered similar results as those here presented. Thus, we obtained mean residual chronologies for each species of prewhitened growth indices.

 * BAI represents a more accurate indicator of growth than ring-width, since it reduces the variation caused by adding volume to a circular stem 
 * BAI is a more meaningful indicator of growth than ring width because it removes variation in growth attributale to increasing circumference. 
 * BAI is more closely related to biomass increment 
 * BAI removes variation in growth attributatle to increasing stem circumference and captures changes in growth better than linear measures as tree-ring width [@Biondi2008]
 
  To explore similarity within locality, each site chronology was smoothed using centred moving averages with different window sizes, and then Pearson's correlation coefficient between the two chronologies of the same locality (higher and lower elevation) were calculated. Significance was tested using 1000 boostrap replicates and with 95 % confidence intervals built using the R packgae `boot` [@Canty2016]
  
  
# Resilience
The Relative Resilience (*RRs*) is the resilience weighted by the severity of the disturbance, and it is estimated as: 

Relative Resilience (*RRs*) = (Postdrought - Drought) / Predrought


# Results 
The analysis of greenness time trends showed that 78.9 % of the pixels of *Quercus pyrenaica* forests experienced an EVI positive trend for the 2000-2016 period, of which 31.67 % were significant trends. The strongest trends were observed in southwestern populations (Figure S2), in which the Cañar site are included Vegetation greenness of *Q. pyrenaica* forests were lower during both the 2005 and 2012 years than the greenness observed for the reference period (Figure 2a). The lowest values for EVI standardized anomalies were recorded in 2005 being singnificantly lower (-2.285 ± 0.029) than those in 2012 (-0.418 ± 0.029) (LSMEANS, t.ratio = -45.358; p_value < 0.0001), particularly for northern populations (Figure 2b). Reduction in annual EVI mean was considerably higher in northern populations than in southern ones during the 2005 drought (Figure 2b). 

According to the standardized anomalies, *Q. pyrenaica* forests suffered a browning episode during 2005 drought event (99.36 % and 79.37 % of the pixels for northern and southern populations respectively), yet no changes in greenness were observed in response to the 2012 drought (Figure S3). 

> Cuando exploramos las anomalías (brutas, estandarizadas y normalizadas) observamos valores muy negativos para el año 2005. Sin embargo vemos valores menos negativos para 2005. Tukey posthoc testing (lsmeans package CITAR) was conducted for pairwise comparisons among the slopes and the disturbance years 

> Las anomalías (sa) fueron significativamente menores en 2005 (-2.285 masmenos 0.029) que para 2012 (-0.418 masmenos 0.029), (LSMEANS, t.ratio = -45.358; p_value < 0.0001)

## Greenness resilience to drought events

*Q. pyrenaica* forest showed significantly lower resistance (*Rt*) to the 2005 drought event than to that in 2012 (Table 3; Figure 3). Southern populations showed significantly higher values of resistance to drought than northern ones (Table 3), except for 2012 where non-significant differences were recorded (Table S1; Figure 3). 

Recovery (*Rc*) of greenness was significnatly different bewteen drought events and sites (Tables 3). In the 3-year period after the 2005 drought, greenness achieved was 112 % (Rc = 1.12) and after 2012 was 105.7 % (Rc = 1.057) (Table S1). For southern populations, a similar recovery after the 2005 and 2012 drought event was observed (p = 0.2453; Figure 3; Table S1). 

Resilience (*Rs*) was significantly higher for the 2012 drought event than for 2005 (Tables S1, 3), although both values were close to 1 indicating that greenness level was rather similar after each disturbance event (Table S1). The southern populations showed higher resilience values than the northern ones, although these differences were not significant for the 2005 drought event (p = 0.036; Figure 3). 

> Resistencia
> 
> * Los robledales mostraron menor resistencia a la sequía de 2005 que a la de 2012 [2005: 0.858 (0.853-0.863); 2012: 0.943 (0.939 - 0.947); p <0.0001]
> * Menor resistencia de las poblaciones del Norte a los eventos de sequía que las del Sur [N: 0.883 (0.877-0.889); S: 0.921 (0.918 - 0.925); p <0.0001]
> * La resistencia varió en función de la sequía y de la población. Las poblaciones mostraron una resistencia similar al evento de sequía de 2012 (padj = 0.172), sin embargo las poblaciones del N fueron mucho menos resistentes que las del Sur durante la sequía de 2005  [N: 0.819 (0.814-0.824); S: 0.902 (0.896 - 0.907); p <0.0001]
> * notas:  La sequía de 2005 redujo el EVI medio hasta el 85.8%, mientras que la de 2012 la redujo hasta el 94.3%. La sequía de 2005 redujo el evi medio hasta el 81.9 % en las poblaciones del N, y hasta el 90.2 % en las del S. ... drought reduced growth to xx% of the preceding reference period (ver Pretzsch et al 2013 Plant Biology)

> Recovery 
> 
> * La recuperación de los robledales fue mayor tras la sequía de 2005 que tras la de 2012 [2005: 1.120 (1.113-1.126); 2012: 1.057 (1.054 - 1.060); p <0.0001]
> * Los robledales de la cara sur mostraron una menor recuperación que los de la cara norte [N: 1.102 (1.096-1.108); S: 1.069 (1.065 - 1.073); p <0.0001]
> * Las poblaciones del sur mostraron una recuperación similar ante la sequía de 2005 y 2012 (p = 0.186), cosa que no ocurrió para las poblaciones N (p < 0.0001), que mostró una recuperación mayor para la sequía de 2005 que para la de 2012 [2005: 1.169 (1.161-1.177); 2012: 1.042 (1.036 - 1.047); p <0.0001]. En 2005, las poblaciones del S mostraron menor recuperación; mientras que en 2012 ocurrión un patrón inverso, mostrando un patron mayor que las del norte. 

> * La resiliencia de los robledales fue mayor para la sequía de 2012 que para la de 2005 [2005: 0.958 (0.955-0.962); 2012: 0.995 (0.991 - 0.998); p <0.0001]  
> * Los robledales del sur mostraron mayor resiliencia que los del norte [N: 0.970 (0.966-0.974); S: 0.983 (0.980 - 0.986); p <0.0001], aunque para 2005 ambas poblaciones no mostraron diferencias en la resiliencia (padj = 0.152). En 2012 se observó mayor resiliencia en las del S que en la del N (p<0.0001)

> Relative Resilience (De esto no he dicho nada)

  * Los robledales mostraron mayor resiliencia relativa a la sequía de 2005 que a la de 2012 [2005: 0.099 (0.095-0.105); 2012: 0.053 (0.050 - 0.056); p <0.0001]  
  * Las poblaciones del sur mostraron menor resiliencia relativa que las del norte [N: 0.086 (0.082-0.092); S: 0.063 (0.060 - 0.066); p <0.0001], debido sobre todo a la diferencia en la resiliencia relativa para las poblaciones del norte entre los dos eventos de sequía (mucha mayor resiliencia relativa en 2012 que en 2005 para las poblaciones del N)
  * Las poblaciones del sur no mostraron diferencias en cuanto a la resiliencia relativa entre los dos eventos de sequía (padj = 0.152)


Sorprende que en los sitios del sur (caH y caL), en los últimos años ha habido crecimientos muy grandes. Por ejemplo, en 2010 se observó uno de los mayores valores de RWI de toda la cronología tanto en caH como en caL. Algo similar ocurrió en sj para los años 2003 y 2013. 


En las poblaciones del norte osbervamos dos eventos de PGC por encima del 25 e incluso el 50 %. El primero de ellos desde 1940 hasta 1950, mientras que el segundo entre 1994 y 2001. Estos periodos se alternan con periodos de NGC: previo 1940, 1960 - 1991, y quizá aunque no lo vemos en al actualidad (?? duda. Esto es especular un poco). Esto responde creo que a: 

(i) actividad minera y tratamientos forestales. La actividad minera en la zona fue intensa (aunque a veces intermitente, entre 1890 y 1957 (cuando se clausuró); y previamente desde 1858 tras los trabajos de Amalio Maestre). Hay costancia de la existencia de hornos de fundición de mineral en alguna de las minas (La Probadora).
(ii) actividades forestales:
* Se conoce la existencia de un proyecto redactado en 1943 de repoblación forestal de la cabecera del río Genil (he pedido los mapas).
* Ver actividades forestales (bd proyectos de gestión)

En el trabajo de [@GeaIzquierdo2014] se observa una liberación posterior a 1950 (QPUY9) (entre 1950 y 1960 aprox.) y luego una supresión hasta mediados de 1990. Esto coincide con lo que hemos observado en nuestra chrono. 

Respecto a las poblaciones del sur, destaca en la caH una primera liberación en torno a 1829-1830 y 1837-1840; y luego predominan los eventos de supresión que se alternan con algunos de liberación (muy débiles) hastas 1950. Posteriormente se alternan liberaciones-supresiones débiles. Destaca una liberación en torno a 2000-2003 (relación con clima??? posterior a sequía 1999???)

En caL, observamos un periodod de limitación hasta 1885 aprox. Luego se alternan al igual que antes periodos de liberación con otos de supresión con señales más fuertes que en caL, y al igual que antes destaca con mas intensidad si cabe, una liberación entre 2000 y 2003 (antrópico o climática ??)

Duda: ocurre en los dos sitios caL y caH, entonces, es aumento de crecimiento debido a actuación forestal? o debido a clima?? 

[@GeaIzquierdo2014] encontró un pico de disturbance en torno a 1860 en QUPY10 (cañar) sugiriendo que la baja densidad en esos sitios fue presumible el resultado de un thinning (aclareo). El patrón de supresión que observa para este sitio va en la linea de lo que nosotros encontramos (supresiones que alcanzan a veces el 25 % y otras no)


En cuanto a la señal a nivel de sitio, para el Norte, vemos que tanto las supresiones como las liberaciones se observan para mas del 50 % de los árboles. En el caso del sur, vemos que algunas supresiones se observan para mas del 50 % de los árboles, mientras que las liberaciones observadas en torno a los 2000 se observan para mas del 50 % de los árboles 

> Resistance: 

Although no significant differences were observed in the resistance (*Rt*) of oak radial growth between the two drought events (Table 3), the 2005 drought reduced growth more than that of 2012 (Rt = 0.721 and 0.819 respectively) (Table S2). Similar to results for greenness, the northern site, which is under a drier climate, showed resistance values lower than those of the southern site, especially for the 2005 drought event where the growth was reduced to 44.5 % respect to that of the preceding period (Figure 3). 
  
* No diferencias significativas entre la resistencia mostrada por los robledales a los eventos de sequía de 2005 y 2012 (F = 6.0189; p = 0.019). Valores de resistencia menor al evento de 2005. [2005: 0.721 (0.6437-0.7984); 2012: 0.8193 (0.7758 - 0.8628); p = 0.025; trimmed-p = 0.019]

* Diferentes resistencias a los eventos de sequía en función del sitio (p <0.0001). Las localidades del sur (CaLow y CAHigh no mostraron diferencias en cuanto a la resistencia p.adjust = 0.012) mostraron una resistencia mayor a los eventos de sequía que la observada a la localidad del norte [caH: 0.8157 (0.7549 - 0.8764) (a); caL: 0.9209 (0.8834 - 0.9584) (a); SJ: 0.6116 (0.5387 - 0.6846) (b)].

* La interacción también fue significativa. De hecho, si miramos las gráfica, observamos como la resistencia a la sequía de 2005 fue significativamente menor en SJ que la resistancia mostrada, tanto por las otras poblaciones para 2005, como la mostrada por SJ para el año 2012 --¿¿¿ Podemos decir que la sequía de 2005 afectó mucho mas a la población de SJ??? 

> Recovery 
> * Mayor recuperación del crecimiento de los robledales tras la sequía de 2005 que tras la de 2012 [2005: 0.9462 (0.8794-1.013); 2012: 1.161 (1.081 - 1.24); p < 0.001]
> * Las poblacionees del sur (caH y caL; no diferencias entre ellas) mostraron una menor recuperación que las poblaciones del norte, es decir, las del norte se recuperaron mas rápidamente que las del sur que no llegaron incluso a valores de Rc = 1. 

Similar pattern of resilience (*Rs*) values was found for growth than for greenness respect to drought event: significantly higher values of *Rs* for the 2012 drought event than for the 2005 (Table S2; Figure 3). However, no differences were observed between sites (Table 3). For 2005 drought event, *Rs* value of SJ (northern site) was lower than that of southern ones (CA-High and CA-Low), but opposite pattern was found for the 2012 drought event. All valu`es of *Rs* for growth were below 1, except for the SJ site in 2012 (Rs = 1.031). 


YA ESTOY DESESPERADO CON ESTE PAPER
*Q. pyrenaica* forest showed significantly lower resistance values (*Rt*) to the 2005 drought event than to that in 2012 for greenness and for radial growth (Table 3; Figure 7). The 2005 drought reduced greenees and growth more than that of 2012 (Tables S1 and S2). Resistance values to drought for greenness and tree-growth varied between sites (Table 3). Southern populations showed significantly higher values of resistance than northern ones (Tables S1 and S2). It was particularly important for the 2005 drought event where the growth was reduced to 44.5 % respect to that of the preceding period (Figure 7). 

Recovery (*Rc*) of greenness and growth were significantly different bewteen drought events and sites (Table 3). In the 3-year period after the 2005 drought, greenness was 112 % (Rc = 1.12) and after 2012 was 105.7 % (Rc = 1.057) (Table S1). An opposite pattern was found for tree-growth, with significantly lower values of recovery after the 2005 drought, staying at levels of *Rc* < 1 (Figure 7, Table S2).


Northern populations showed significantly higher values of recovery than southern sites for greenness and tree-growth (Table S2). For southern populations, no significant differences were found for recovery of greenness after the 2005 and 2012 drought event (p = 0.2453; Figure 7; Table S1). Recovery values for tree-growth of southern populations were below or close to 1 (Figure 7, Table S2).   

Significantly higher values of resilience (*Rs*) were observed for the 2012 drought event than for the 2005 in both variables (greenness and tree-growth) (Tables S1-S2; Figure 7). Resilience values varied significantly between sites for greenness, but not for tree-growth (Table 3). Southern populations showed higher resilience values (*Rs*) than the northern ones (Tables S1-S2). For greenness, the differences of resilience between sites were not significant for the 2005 drought event (p = 0.036; Figure 7). For tree-growth, opposites resilience values were found for the interaction between sites and drought event: higher values of resilience for northern populations than southern ones (CA-High and CA-Low) during the 2012 drought event but opposite pattern during the 2005 (Table S2). 



Similar to the long-term observed pattern, 

was greater after more severe drought event (2012). Opposite pattern was observed for greenness with 

Lower resistance values (*Rt*) were observed to the 2005 drought event than to that in 2012 for both variables. The 2005 drought reduced greenees and growth more than that of 2012 (Tables S1 and S2). Resistance values to drought for greenness and tree-growth varied between sites (Table 3). Southern populations showed significantly higher values of resistance than northern ones (Tables S1 and S2). It was particularly important for the 2005 drought event where the growth was reduced to 44.5 % respect to that of the preceding period (Figure 7). 





OOOOOOOOOOOJOOOOOOOOOOO CON ESTO 

Esto último se ve reforzado por el hecho de que Sierra Nevada is considered a glacial refugia for deciduous *Quercus* species [@Brewer2002; @Olalde2002; @RodriguezSanchez2010]; además las poblaciones de *Q. pyrenaica* en Sierra Nevada presentan una alta resiliencia genética [@Valbuena2013; @Valbuena2017]


Por un lado la dependencia del agua. Sabemos que esta especie es mas sensitive a la humedad del suelo que otras especies arbóreas mediterráneas (GeaFEM). En Sie

A plausible explanation could be 

--> Ver y resumir páginas 18-19 Notas Naturkunde 

---> Nota 

Para la discussion: 
- Resilience values of RW for 2005 was the lowest of the drought events analized even not being the moste severe drought event 
- 2005 reduced greenness and bai more than 2012 

Our findings show that recent severe drought events, such as 2005 and 2012, provoked a reduction both in greenness (*i.e.* primary growth) and in secondary growth of *Q. pyrenaica*. 


During the 2005 drought, one of the worst drought events recorded in the Iberian Peninsula [@GarciaHerrera2007], we found a browning of the *Q. pyrenaica* forests, but no changes in EVI standardized anomalies were recorded for 2012, which can be explained because 2012 drought event was a winter-drought [@Trigo2013]. 


Tree-growth was also affected by drought as evidenced by the reduction in detrended tree-rings (RWI) during the most severe drought events (Figure S3). The decline in growth observed in our study sites is consistent with several works reporting tree-growth reductions for Mediterranean tree species during severe droughts, particularly for 2005 [*e.g.* @SanchezSalguero2013; @Camarero2018; @Gazol2018]. 

Although 2005 and 2012 were two severe droughts recorded for the south of the Iberian Peninsula [@GarciaHerrera2007; @Trigo2013; @VicenteSerrano2014] (Table S3), we found a positive trend for vegetation greenness of the forests of *Q. pyrenaica* located in their rear edge. Our results agree with those obtained by previous works using other remote-sensing vegetation indices [@PerezLuque2015onto; @Alcaraz2016obsnev_ndvi], which suggests an increase in primary productivity during the last years for rear-edge populations of this species. 


For tree-growth, a similar positive trend was observed in the last decades, particularly for the southern high-elevation site (CA-High, Figure 4). This result differs from those previous reported for *Q. pyrenaica* along their distribution range [@GeaIzquierdo2013; @GeaIzquierdo2014]. @GeaIzquierdo2014 found a general decline in the growth of this species since the 1970s, particularly sharp for populations located in their dry-edge. This decline trend in growth have also been oberved for other tree species located in their rear-edges [*e.g.* @SanchezSalguero2012; @SanchezSalguero2017; @Dorado2017]. Furthermore, growth projections have forecasted a decrease in productivity for *Q. pyrenaica* that would increase vulnerability of this species to climate warming at the dry edges locations [@GeaIzquierdo2013]. However, our results for similar locations have revealed a recovery in tree-growth for the last years (Figure 4). In addition, a similar positive trend in BAI for the last years, has been reported for another *Q. pyrenaica* population of the Sierra Nevada [@RubioCuadrado2018]. 

Aunque los valores de resiliencia (*Rs*) para el greenness y el tree-growth fueron inferiores o muy cercanos a 1, observamos en ambas variables, una mayor resiliencia tras la sequía de 2012 (Figure 7). La sequía de 2012, que fue mas severa e intensa que la registrada en 2005 (Table S3), ocurrió durante el invierno de 2012 [@Trigo2013], lo cual puede explicar un menor efecto, sobre todo en el greenness de *Q. pyrenaica*. Por otro lado, al analizar la resiliencia del tree-growth para otros eventos de sequía (long-term perspective), observamos como estas poblaciones presentan altos valores de resiliencia. Como muestran nuestros resultados, los mayores valores de resiliencia fueron registrados para dos de los eventos mas severos de sequía (1995 y 1999), con valores de resiliencia por encima de 1.2 en ambos eventos (Figure 6). 

Hemos observado como las sequías severas, sobre todo la de 2005, provoca una reducción en el greenness y pero sobre todo en el crecimiento de *Q. pyrenaica*. Los datos de anomalías estandarizadas de EVI mostraron un browning para la mayoría de los robledales de Sierra Nevada durante la sequía de 2005. 

La sequía de 2005 ha sido una de las mas severas de los últimos años, afectando significativamente al crecimiento

#--------------------------------------------
# Sequías 

### 2005 frente a 2012 

* Analizando los datos de precipitación acumulada de las estaciones alrededor de SN, observamos como 2005 fue el año mas seco desde 1950. 
* Datos de SPEI (0.5 º Grid) 
    * 2005 fue peor que 2012, pero no peor que 1995 o que 1999 (ver figura S2)
    * Tabla S4. Severidad sequías, la de 2005 fue menos severa y menos intensa y de menor duración que la de 2005 (de donde vienen estos datos???)

* La sequía de 2005 fue una de las mas severas afectando significativamente al crecimiento. Esto se ha observado también en otras especies en el sur de la P. Ibérica (p.ej. P. nigra en Andalusia [@SanchezSalguero2013], ... INCLUIR otras especies y citas).


### 2005 en contexto 
  
* Algunos trabajos hablan que los peores años de sequía en la P. Iberica durante la segunda mitad del siglo XX fueron 1986, 1994-1995, 1999, 2005 y 2012

* An analysis of the long term series from meteorological stations (n=54) of Iberian Peninsula (1961-2011) reveals that major drought episodes in the Iberian Peninsula were recorded in 1981, 1995, 2000 and 2005 [@VicenteSerrano2014].


### Reducción en el crecimiento de algunas especies 
El efecto de la sequía de 2005 en el crecimiento también se ha visto en otras especies en el sur de la P. Ibérica 
La sequía de 2005 fue una de las mas severas afectando significativamente al crecimiento. Esto se ha observado también en otras especies en el sur de la P. Ibérica (p.ej. P. nigra en Andalusia [@SanchezSalguero2013], ... INCLUIR otras especies y citas).

* P. nigra: Se observó una gran reducción de crecimiento en 1994-1995, 1999 y 2005 para Pinus nigra en el SE de Andalusia [@SanchezSalguero2013] coincidiendo con años de sequía para esa zona. La máxima reducción en crecimiento fue observada para 2005, siendo significativamente mayor que para el resto de años [@SanchezSalguero2013].


No obstante, a pesar de que 2005 y 2012 fueron dos de las sequías mas severas registradas para el sur de la P. Ibérica [@GarciaHerrera2007; @VicenteSerrano2014] (Appendix S3), nuestros resultados muestran que los robledales de *Q. pyrenaica* en su rear-edge presentan una tendencia positiva tanto en el greenness (78.9 % pixeles con greeness) como en el crecimiento (tendencias positivas del BAI). 


### La resiliencia de las poblaciones de roble de Sierra Nevada. 

El greennness de los robledades en Sierra Nevada ha mostrado una tendencia positiva hacia mas verdor en los ultimos años, que coincide con lo que ya observamos con datos de NDVI [@PerezLuque2015onto], sobre todo para las poblaciones del sur. Esta tendencia positiva, obtenida de variables derivadas de remote sensing (EVI y NDVI), parece que también se observa en el crecimiento. Por ejemplo en las poblaciones del sur (CaHigh y CaLow) observamos en los últimos años una ligera tendencia de crecimiento. 


Aún habiendo pasado varios periodos de sequía severa (sobre todo 2005, el crecimiento -BAI- en el N, se redujo hasta el 45 %), estos robledales han mostrado una alta resiliencia. Por ejemplo para las poblaciones del norte, los valores de EVI durante la sequía de 2005 descendieron hasta el 81 %, mientras que el BAI (sitio SJ) lo hizo hasta el 45 %. Sin embargo, la recuperación fue rápida, así los valores de Recovery (Rc) para el EVI tras la sequía de 2005 (en las poblaciones del norte) fue de 1.17, mientras que para el BAI el Rc fue de 1.112. En definitiva, estamos observando altos valores de resiliencia en estos robledales.


Despite the resilience values (*Rs*) of growth for 2005 and 2012 were close or below 1, we observed high resilience of these forests from a long-term perspective. As our results indicate, the highest resilience values for growth were recorded for two of the most severe drought events (1995 and 1999), with resilience values above 1.2 in both events (Appendix S5).

genetica 

Los robledales de SN estén situadas en su borde rear-edge donde se supone que sufren mas estrés climático. Hemos observado un aumento en el greenness en los últimos años. Por otro lado, hemos encontrado que son poblaciones resilientes a la sequía, tanto para el crecimiento como para el greenness. Además, estos robledales tienen una alta resiliencia genética  ¿Sierra Nevada (regiones de montaña) como refugio?? quizá este rear-edge esté actuando como refugio?? (esto es muy especulativo)


Las zonas rear edge son zonas que se supone son mas vulnerables al cambio climático por sus estrechos márgenes. De hecho como han visto algunos trabajos, las especies situadas en su rear edge son mas vulnerables. No obstante tambiéh habría que considerar que algunos trabajos apuntan a que la vulnerabilidad dentro del rear edge es mas sitio dependiente (dorado). Además habría que introducir aqui lo que M. Villalta habla de la consideración de rear edge de.


* Otro punto de interés a introducir aquí es que frecuentemente se asume una alta vulnerabilidad a la sequía de las poblaciones situadas en su dry rear-edge [@MartinezVilalta2018], sin embargo algunos estudios están demostrando esto no es siempre así (ver por ejemplo [@Cavin2017; @Granda2017]). Nuestros resultados creo que van en esta línea creo. Esto, como apunta [@MartinezVilalta2018]m tiene que ver con la que consideramos como habitat marginal de la especie (... When the focus is on marginal, rear-edge populations, proper consideration should be given to the different ways in which marginality can be defined (stressing geographical, climatic or other ecological factors). 

¿Casos parecidos?

Existen trabajos que han analizado los efectos de la sequía en especies situadas en su rear edge (Asier, por ejemplo; Matias) y algunos de ellos se han centrado en ver como responde el crecimiento de las especies en el rear edge utilizando dendro (Herrero Rigling.. // dorado-liñan // sanchez salguero  

trabajos rear edge: 
 * sanchez salguero Is drought the main decline factor at the rear edge of Europe? The case of southern Iberian pine plantations 
 * sanchez salguero Assessing forest vulnerability to climate warming using a process-based model of tree growth: bad prospects for rear-edges
 * dorado-liñán: Climate threats on growth of rear-edge European beech peripheral populations in Spain.
 * herrero rigling: Varying climate sensitivity at the dry distribution edge of Pinus sylvestris and P. nigra
 * dorado-liñan: Large-scale atmospheric circulation enhances the Mediterranean East-West tree growth contrast at rear-edge deciduous forests. 
buscar otros 

... Varios trabajos han apuntado la existencia de vulnerabilidad local al aumento de temperaturas en los sitios del sur de distribución de esta especie [@GeaIzquierdo2013; @GeaIzquierdo2014] así como una strong response to moisture availability...; Además teniendo en cuenta que en los últimos años estamos viendo un aumento en las sequías (menor disponibilidad de agua) --> por ello queremos analizar como están respondiendo esta especie, sobre todo en esas zonas dry-egde, y analizar su resiliencia... 

## refugio?? 

Los robledales de SN estén situadas en su borde rear-edge donde se supone que sufren mas estrés climático. Hemos observado un aumento en el greenness en los últimos años. Por otro lado, hemos encontrado que son poblaciones resilientes a la sequía, tanto para el crecimiento como para el greenness. Además, estos robledales tienen una alta resiliencia genética [@Valbuena2013; @Valbuena2017]. ¿Sierra Nevada (regiones de montaña) como refugio?? quizá este rear-edge esté actuando como refugio?? (esto es muy especulativo)

pero ojo, quizá el problema es que no estamos definiendo bien el rear edge --> ver martinez vilalta et al.  




Las poblaciones situadas en su rear edge viven en estrechos márgenes ambientales y pequeños variaciones en las condiciones ambientales pueden provocar que las restricciones ambientales sean mas severas [@Hampe2005]. Así, frecuentemente se asume una alta vulnerabilidad a la sequía de las poblaciones situadas en su dry rear-edge [@MartinezVilalta2018], tal y como se ha visto para *Q.pyrenaica* [@GeaIzquierdo2014] y para otras especies (citas). Sin embargo, algunos estudios están demostrando que esto no es siempre así [ver por ejemplo @Cavin2017; @Granda2017], tal y como sugieren nuestros resultados, con altos valores de resiliencia para poblaciones de *Q. pyrenaica* situadas en su rear-edge. 

Algunos autores han apuntando que cuando se estudian poblaciones del rear-edge, hay que poner atención a la forma en la que se define la marginalidad, esto es, si se define atendiendo a criterios geográficos, climáticos, o según otros factores ecológicos [@MartinezVilalta2018]. En este sentido, los altos valores de resiliencia a los eventos de sequía que hemos observado, podrían sugerir que las poblaciones de *Q. pyrenaica* en Sierra Nevada están situados en un rear-edge geográfico, pero no climático. Esto último se ve reforzado por el hecho de que Sierra Nevada is considered a glacial refugia for deciduous *Quercus* species [@Brewer2002; @Olalde2002; @RodriguezSanchez2010]; además las poblaciones de *Q. pyrenaica* en Sierra Nevada presentan una alta resiliencia genética [@Valbuena2013; @Valbuena2017].

Podríamos complementarlo con lo que le pasa a otras especies en su borde de distribución: por ejemplo en Baza, Herrero et al. 2013, encontraron para Pinus nigra y sylvestris que la temperatura tenía mas peso que la disponibilidad de agua). O también ver algunos de los trabajos de Camarero et al 2013 para el P. nigra en su borde de distribución u otros similares (el de Sanchez-Salguero et al. 2013, 2015) 


Para *Q. pyrenaica* moisture availability was reported to be the most limiting factor driving radial growth in Iberian Q. pyrenaica populations [@GeaIzquierdo2014] (Prec hidrológica y SPEI) (ver también Gea-Izquierdo et al. 2015 European Journal of Forest Research). Lo que hemos obtenido aqui (analizando solo el rear edge) también van en esa línea. 


. Para  *Q. pyrenaica* se ha visto que moisture availability es el factor limitante que determina el crecimiento en las poblaciones situadas en su rear edge [@GeaIzquierdo2014], pero para otras especies (*i.e.* *Pinus nigra*, *P. sylvestris*) la temperatura tiene mas peso que la disponibilidad de agua  [@Herrero2013; @Matias2017]. Pero es importante considerar además la historia de manejo que han tenido esos bosques a la hora de la forest management [@Penuelas2017; @DoblasMiranda2017], ya que, como observamos en nuestros resultados puede condicionar el crecimiento y la resiliencia de las especies. 

* Vicente-Serrano: 
    * We found that some forests from cold and humid areas respond to shorter drought time-scales than forests from dry areas, which usually respond to longer time-scales
    * Growth and responses to drought are modulated by site conditions such as soil type, specific functional traits and the intensity of competition among neighbouring trees (Orwig & Abrams, 1997; McDowell et al., 2008; Linares et al., 2010; Pasho et al., 2011).
    * Our findings provide evidence that the patterns of growth response to drought do not follow a general geographical structure and that these patterns are driven by the biogeographical, topographic and climatic conditions of each site, showing that forests located in different continents have the same pattern of response to drought time-scales.


-----------

Despite similar value of competence in our study sites, we obtained higher values of growth for the highest elevation site (CA-High, Figure 4). 

------ 


En un estudio a escala continental, [@Bhuyan2017] encontraron que para la misma especie (estudiaron 850 sites: Fagus sylvatica, Abies alba, Picea abies, Larix decidua, Pinus cembra, P sylvestris, P nigra, Quercus petraea y Q robur) los stands situados a mayores elevaciones fueron menos sensibles a la sequía que los situados a elevaciones inferiores (stands were less drought sensitive at higher elevations compared to lower elevations). 
The effect of elevation was seen clearly in the case of several species where high elevation sites showed greater drought resistance compared to stands at lower elevation in the same climate zone.

## Rear-edge 

* Se asume una alta vulnerabilidad de las especies a la sequía en su límite inferior, sin embargo esta vulnerabilidad no necesariamente se mantiene: The results of Granda et al. 2018 are consistent with recent studies showing that the frequently assumed higher vulnerability of dry, rear-edge populations to drought does not necessarily hold (e.g. Cavin and Jump 2017) (from: Martinez-Vilalta 2018)

* Definición de *marginal* populations. [@MartinezVilalta2018] indica que a veces no está claro la definición de marginal populations. When the focus is on marginal, rear-edge populations, proper consideration should be given to the different ways in which marginality can be defined (stressing geographical, climatic or other ecological factors). 

* Quizá estamos asumiendo que es una población marginal, pero sin embargo lo es solamente geográficamente

----- 

No obstante tambiéh habría que considerar que algunos trabajos apuntan a que la vulnerabilidad dentro del rear edge es mas sitio dependiente (dorado).
 
### Diferencias entre sitios

Llama la atención que en el rear-edge de la distribución de la especie, en el sitio mas meridional dentro de este rear edge, y en la parte mas alta (estas parcelas están en el treeline de la especie en SN (en torno a 1900)), es donde encontramos mayores crecimientos. Parece que los robles estuvieran mejor en esta zona. Algunas reflexiones sobre esto: 

* Quizá están creciendo donde les están dejando (menor impacto antrópico en las zonas mas altas, al menos en los últimos años??)
* ¿Diferentes niveles de compentencia?. Parece que la competencia es similar en los tres sitios: no diferencias sig. para valores de Stand density ySize ratio proportional to distance (ver table 1). 
* ¿Diferencias entre suelos?? En principio no. [@CoboDiaz2017] en un trabajo sobre microbiota del suelo, explora diferencias en un gradiente altitudinal en Cáñar. Analiza 3 sitios: por encima del treline (XZF, el piornal), low altitudinal oak forest (LAF, en la zona baja del robledal) and high altitudinal oak forest (HAF). En su trabajo, LAF está mucho mas bajo, pero HAF está cerca de las parcelas caHigh. Restulados:  
    * tipo de suelo: LAF es Sandy-loam, HAF es loam
    * HAF tuvo los valores mayores de disponibilidad hídrica (% available water tabla s1 en [@CoboDiaz2017]) --> Esto es importante, creo
    * Los tres sitios eran pobres en materia orgánica, pero el HAF dobló los valores de los otros dos sitios
    * No diferencias en contenido de N, C/N ratio similares en HAF, y LAF

* ¿Menor estrés hídrico en zonas mas altas? Puede ser que tengamos menor estrés hídrico en esta zona?? Este robledal, está en la cara sur de SN, y en una ladera con bastante insolación. Algunos trabajos antiguos (de fitosociólogos) hablan de que su presencia aquí se debe a que reciben un aporte extra de humedad procedente de las brisas del mediterráneo, para suplir el mínimo de humedad que necesitan en verano. Quizá también tendríamos que incluir el papel de las acequias. La zona caHigh tiene una acequia muy cerca (y por encima) de donde muestreamos (recordad el roble mas grande, y el mas alto, esta justo en una acequia). No se si es interesante que lo comentemos. 






In addition, despite southern sites are very close to each other, we obtained higher values of BAI for the high-elevation site than for the low-elevation site. 


#### Climate and tree relationship 

Frase de resultados que tenemos que poner en discussion: 
Precipitation of previous december was also positively correlated with tree growth in the northern population and in the highest location of the southern population. Hydrological, Spring and Summer SPEI showed a strong positive correlation with tree-growth (Figure 7b), specially for the northern population (r > 0.6), ... **which can be interpreted as higher sensitivity to drought of a drier site [@GeaIzquierdo2014]**.

### ¿Que factor es mas limitante para el crecimiento en el rear-edge de Q. pyrenaica? 
Aquí pueder ser interesante comentar algo de el peso de las variables climáticas en el crecimiento para poblaciones situadas en el borde de distribución (pesa mas la temperatura o la disponibilidad de agua?). 

Para *Q. pyrenaica* moisture availability was reported to be the most limiting factor driving radial growth in Iberian Q. pyrenaica populations [@GeaIzquierdo2014] (Prec hidrológica y SPEI) (ver también Gea-Izquierdo et al. 2015 European Journal of Forest Research). Lo que hemos obtenido aqui (analizando solo el rear edge) también van en esa línea. 

Podríamos complementarlo con lo que le pasa a otras especies en su borde de distribución: por ejemplo en Baza, Herrero et al. 2013, encontraron para Pinus nigra y sylvestris que la temperatura tenía mas peso que la disponibilidad de agua). O también ver algunos de los trabajos de Camarero et al 2013 para el P. nigra en su borde de distribución u otros similares (el de Sanchez-Salguero et al. 2013, 2015) … 

## MAs cosas diferentes 
Otras especies: rear edge 

Evaluar el crecimiento en el rear edge de F. sylvatica 
https://link.springer.com/article/10.1007/s10342-016-0982-7?wt_mc=Internal.Event.1.SEM.ArticleAuthorOnlineFirst 

¿Que limita al crecimiento en el borde sur de su distribucion? --> Ver esto 
http://onlinelibrary.wiley.com/doi/10.1111/j.1365-2486.2006.01250.x/abstract 

Pinus sylvestris (Baza) (Matias et al 2017)
Radial growth was maximal at medium altitude and treeline of the southernmost populations. Temperature was the main factor controlling growth variability along the gradients, although the timing and strength of climatic variables affecting growth shifted with latitude and altitude. 

http://onlinelibrary.wiley.com/doi/10.1111/gcb.13627/full

Idea --> algunos autores comentan que puede existir una alteración en el balance competitivo entre especies en mixed stands. Por ejemplo en Montseny, borde equatorial para F. sylvatica, se está viendo que el F. sylvatica está siendo reemplazado por Q. ilex. ... En SN, el artículo de B. Benito (Climatic Change) habla del remplazo que existirá de Q. pyrenaica por Q. ilex, sin embargo, estamos viendo que los crecimientos son muy grandes y que Q. pyrenaica tiene mucha resiliencia --> entonces que pasa con las predicciones de dichos modelos ???


The presence of *Q. pyrenaica* forests on the southern slopes of Sierra Nevada is partly explained by the additional contribution of humid air from the Mediterranean sea [@Prieto1975]


### ORDENAR ??? 



.. ver [@VicenteSerrano2013] impacto de las sequías en diferentes zonas (i.e montañas) 
 

# Otras notas: 
* To guide sustainable forest management, forest researchers are asked to provide concrete answers about forest resilience in response to expected climatic trends, and extreme climatic events (Lindner et al., 2014) https://www.sciencedirect.com/science/article/pii/S030147971400379X?via%3Dihub







* Proyeccciones de crecimeinto de para *Q. pyrenaica* sugieren un declive en el crecimiento en las proximas decadas a lo largo de su rango de distribución en la P. Iberica, en diferentes escenarios climáticos [@GeaIzquierdo2013]: Predictions suggest that QUPY productivity would decline in the next decades all along its distributional range in the Iberian Peninsula for all the climate scenarios studied. Este declive debería ser mas dramático en las baja altitudes de las zonas mas calientes del sur de su distribución 

--> vulnerabilidad local (related to rear-edge)
La tendencia de reducción drástica sugerida por el modelo para el dry-edge de la distribución de la especie podría expresar una aumentada vulnerabilidad de los árboles al incremento del estrés hídrico forzado por un clima mas cálido [@GeaIzquierdo2013]. 

Negative trends over recent years and the greater response to moisture availability found at warmer and drier low elevations in the south suggest vulnerability to warming at the local low elevation dry edge of the species's range (e.g. QUPY9). Otros estudios en la zona Mediterranea reportaron un descenso similar en la productividad con un incremento en la vulterabilidad a la sequía ()



Muchos trabajos han analizado la respuesta de la vegetación a las sequías (eg. @Allen2010; @VicenteSerrano2013; @MartinezVilalta2016; @Norman2016), y algunos de ellos han mostrado el efecto de las sequías en especies Mediterráneas (ver por ejemplo Pasho et al. https://www.sciencedirect.com/science/article/pii/S016819231100253X#fig0020; @Camarero2011 combina uso y sequía; añadir alguno mas de GGI). Algunos Some of these species represent southernmost populations in the Mediterranean ambit, which explains their vulnerability to the warmer conditions (Andreu et al., 2007; Sánchez-Salguero et al., 2016).



Case studies that focus on multiple scales - including local scales - and also valuables (Dale et al. 2018 Frontiers) --> Se necesitan casos de estudio que se enfoquen en escalas multiples (incluyendo las locales) y que combinen varias metodologías (Jump et al. ...)


3) rear edge 

 

* Existen evidencias que sugieren que muchos bosques son vulnerables a eventos climáticos extremos ... (Zhang) y esto puede ser especialmente relevante para especies situadas en el rear edge (completar) ... 




### Estudios que utilizan RS y TR

* Wu et al. 2017. 
	* En un estudio sobre el efecto de la sequía sobre el crecimiento en bosques, grass y shrub del hemisferio norte, encontraron que los bosques (Deep-rooted forest) exhibit a drought legacy response with reduced growth during up to 4 years despues de un evento extremo de sequía. 

	* Además vieron que los bosques mostraron una stronger drought resilience in forest (i.e. smaller growth reduction after severe drought) (Gazol el al. 2017; Wu et al. 2017). 

	* Esto se puede deber a que acceden a reservas de agua mas profundas (los pastos y los matorrales no pueden acceder a ese agua)




### 


@Gazol2018 encontró La resiliencia está relacionada con la severidad de la sequía y con la composición del bosque


Rt-NDVI and Rt-TR were positively related with drought intensity 




## 
@Gazol2018 Resistencia a la sequía mayor en la zona norte de españa que en las zonas secas del sur 


Qpyr 
* Valores de Rt-TR aumentaron a lo largo del tiempo, sin embargo Rt-NDVI dismiuyó con el tiempo
* Valores Rc-NDVI tendencia positiva 


# Notas Jump 2010 
Limitación de NDVI. La escala espacial del NDVI limita su uso para estudiar cambios en poblaciones situadas en su rear edge (ver 34 en Jump 2009)

NDVI (o EVI) time series are sufficiently robust to allow comparison of forest growth at seasonal and/or interannual scales. 

Ojo se ha visto que el NDVI responde de forma diferente a la sequía, no solo entre diferentes tipos de bosques, sino también entre poblaciones que difieren en historia de sequía y en riqueza de especies dentro de bosques (ver  26 dentro de Jump 2009) --> Por eso nosotros lo combinamos con el uso de dendro!!

Otra idea --> Limitación de NDVI. La escala espacial del NDVI limita su uso para estudiar cambios en poblaciones situadas en su rear edge (ver 34 en Jump 2009)

NDVI (o EVI) time series are sufficiently robust to allow comparison of forest growth at seasonal and/or interannual scales. 

Ojo se ha visto que el NDVI responde de forma diferente a la sequía, no solo entre diferentes tipos de bosques, sino también entre poblaciones que difieren en historia de sequía y en riqueza de especies dentro de bosques (ver  26 dentro de Jump 2009) --> Por eso nosotros lo combinamos con el uso de dendro!!

El NDVI se ha utilizado para monitorizar la respuesta de bosques frente a sequía (ej.: 24,26,32, 44 en Jump2009 )

Necesidad de Ground-based assessment (p 1974 Jump 2009) -> Aunque utilizemos datos de satélite, siempre es necesario utilizar aproximaciones combinda

Para rear edge poblations es recomendable utilizar aproximaciones combinadas (Jump 2009) donde además de los datos de satélite, se utilicen datos groun based assessment (como por ejemplo la dendro), ya que éstos últimos, además de ser componentes esenciales del forest monitoring, son necesarios para estimar ... (ver esto y completar)

El problema de los datos ground-based assessment, existe un trade-off entre el área total cubierta por una red de monitoreo y su resolución local. --Por tanto también existen limitaciones de las ground-based para estudiar poblaciones en su rear edge. 
