``` r
machine <- 'ajpelu'
# machine <- 'ajpeluLap'
di <- paste0('/Users/', machine, '/Dropbox/phd/phd_repos/qpyr_dendro/', sep = '')
```

Utilizamos como fuente de datos el dataset E-OBS (Besselaar et al. 2011). Se trata de un dataset de datos climáticos de alta resolución de toda Europa. Se pueden descargar para varias resoluciones. Hemos descargado los datos de 0.25º de resolución, de temperatura media, máxima y mínima; y precipitación. Son datos diarios a partir de estaciones y tienen desde 1950. Ver mas info en <http://www.ecad.eu/download/ensembles/download.php>

Una vez descargados, hemos utilizado varios paquetes desarrollados por el [grupo de Meteorología Santander](http://www.meteo.unican.es/climate4r), en concreto:

-   loadeR: <https://github.com/SantanderMetGroup/loadeR>
-   transformeR: <https://github.com/SantanderMetGroup/transformeR/>
-   visualizeR: <https://github.com/SantanderMetGroup/visualizeR/>

Para mas informacion ver (Cofiño et al. 2018, Frías et al. (2018)).

Tuve problemas con JAVA y tuve que hacer la descarga y el post-procesado para seleccionar los datos en windows. En el script [`./data_raw/eobs/download_and_process_EOBS.R`](/data_raw/eobs/download_and_process_EOBS.R) está el procedimiento. Ojo no están los datos originales (ocupan 17 Gb. Ir a la web <http://www.ecad.eu/download/ensembles/download.php> para descargarlos). Una vez seleccionadas las celdas, obtuve un conjunto de datos llamado `eobs_data_robles.csv` que es el que vamos a utilizar.

Prepare data
============

``` r
eobs <- read.csv(file=paste0(di, 'data_raw/eobs/eobs_data_robles.csv'), header=TRUE, sep=',')



eobs_wide <- eobs %>% 
  mutate(date = as.Date(str_sub(startDate, 1, 11), format="%Y-%m-%d"), 
         year = lubridate::year(date), 
         month = lubridate::month(date),
         var_clima = case_when(
           variable == "rr" ~ "prec",
           variable == "tg" ~ "tmean",
           variable == "tn" ~ "tmin",
           variable == "tx" ~ "tmax")
         ) %>% 
  dplyr::select(value, loc, date, year, month, var_clima) %>% 
  spread(var_clima, value)

write.csv(eobs_wide, file=paste0(di, "data/eobs/eobs_formatted.csv"), row.names = FALSE) 
```

References
==========

Besselaar, E. J. M. van den, M. R. Haylock, G. van der Schrier, and A. M. G. Klein Tank. 2011. A european daily high-resolution observational gridded data set of sea level pressure. Journal of Geophysical Research: Atmospheres 116:D11110.

Cofiño, A., J. Bedia, M. Iturbide, M. Vega, S. Herrera, J. Fernández, M. Frías, R. Manzanas, and J. Gutiérrez. 2018. The ecoms user data gateway: Towards seasonal forecast data provision and research reproducibility in the era of climate services. Climate Services.

Frías, M., M. Iturbide, R. Manzanas, J. Bedia, J. Fernández, S. Herrera, A. Cofiño, and J. Gutiérrez. 2018. An r package to visualize and communicate uncertainty in seasonal climate prediction. Environmental Modelling & Software 99:101–110.
