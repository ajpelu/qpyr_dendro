# README Drought 

## REGIONAL Scale 
* Explore drought at regional scales using SPEI data from [SPEI Global Drought Monitor](http://sac.csic.es/spei/database.html) for Sierra Nevada (spatial resolution of 0.5º) 
   * See [`./analysis/drought/explore_drought_spei_regional.md`](/analysis/drought/explore_drought_spei_regional.md)
   
## LOCAL Scale
* Explore drought computing SPEI for three stations from [RIA network](http://www.juntadeandalucia.es/agriculturaypesca/ifapa/ria/servlet/FrontController) located in Sierra Nevada: [Cadiar](http://www.juntadeandalucia.es/agriculturaypesca/ifapa/ria/servlet/FrontController?action=Static&url=coordenadas.jsp&c_provincia=18&c_estacion=7), [Padul](http://www.juntadeandalucia.es/agriculturaypesca/ifapa/ria/servlet/FrontController?action=Static&url=coordenadas.jsp&c_provincia=18&c_estacion=10) and [Jerez del Marquesado](http://www.juntadeandalucia.es/agriculturaypesca/ifapa/ria/servlet/FrontController?action=Static&url=coordenadas.jsp&c_provincia=18&c_estacion=6)
  * See [`./analysis/drought/explore_drought_station.md`](/analysis/drought/explore_drought_station.md)
  * Compute the accumulated monthly precipitation for these three stations

* Explore a long term series of meteo data to se how the bad is the two drought episodies. We use official data from REDIAM. We also have analyzed the data coming from Linaria (the same station), but the serie is 1997-2005. For the REDIAM dataset, we compute the accumulated monhtly precipitation using two temporal windows (comparing 2004-2005 and 2012-2013 events with): 
  * Average from 1950-2015 period
  * Averege from 2000-2015 period 
  

## Visualization and notes about drought
* All drought analysis can be visualizated [here](https://rawgit.com/ajpelu/qpyr_dendro/master/analysis/drought/drought_dashboard.html)
* See also [`/man/notes_drought.md`](/man/notes_drought.md)

