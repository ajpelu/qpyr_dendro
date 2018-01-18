-   [Notas sobre EVI](#notas-sobre-evi)
    -   [MODIS Vegetation Indices](#modis-vegetation-indices)
-   [Filtrado de datos](#filtrado-de-datos)
-   [References](#references)

Notas sobre EVI
===============

MODIS Vegetation Indices
------------------------

***Aim***: To obtain vegetation indices for Quercus pyrenaica forests in Sierra Nevada from 2000 to 2016.

Technical info: \* MODIS IV:

-   Collection `MODIS 006`
-   Temporal range: 2000 - 2016
-   Pixel approach

-   Distribution of Pyrenan oak forest in Sierra Nevada:

-   Derived from Ecosystems map of Sierra Nevada
-   Datum: `epsg:4326`
-   See this [link](https://rawgit.com/ajpelu/qpyr_distribution/master/analysis/distribution_map_sn.html)

-   Pixels covering Pyrenan oak forest in Sierra Nevada: `./github/ajpelu/qpyr_distribution/data_raw/geoinfo/iv_malla_modis_qp_centroid.shp`
-   *n* pixels = 927 pixels
-   See this [link](https://rawgit.com/ajpelu/qpyr_distribution/master/analysis/distribution_map_sn.html)

The script to download MODIS data is at: `./script/GEE/get_iv_modis_qp.js`

Filtrado de datos
=================

Para el filtrado de datos ver el siguiente link [`./analysis/prepare_modis_qa.md`](/analysis/prepare_modis_qa.md)

References
==========
