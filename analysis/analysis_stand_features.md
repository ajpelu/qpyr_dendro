-   [Prepare Data](#prepare-data)
-   [General Variables](#general-variables)
-   [Spatial Info](#spatial-info)
-   [Competition data](#competition-data)
    -   [Distance-Independet Indices](#distance-independet-indices)
        -   [Basal Area](#basal-area)
        -   [Stand Density](#stand-density)
        -   [Plot Density](#plot-density)
        -   [Number of competitors within *r* meters (10 m)](#number-of-competitors-within-r-meters-10-m)
        -   [Number of competitors within *r* meters (10 m) such that $ dbh\_j &gt; dbh\_i $](#number-of-competitors-within-r-meters-10-m-such-that-dbh_j-dbh_i)
        -   [Sum of size of trees within *r* meters (10 m)](#sum-of-size-of-trees-within-r-meters-10-m)
    -   [Size ratio](#size-ratio)
    -   [Distance-Dependet Indices](#distance-dependet-indices)
        -   [Distance to nearest tree](#distance-to-nearest-tree)
        -   [Crowding](#crowding)
        -   [Lorimer](#lorimer)
        -   [Negative Exponential size ratio](#negative-exponential-size-ratio)
        -   [Negative Exponential Weighted size ratio](#negative-exponential-weighted-size-ratio)
        -   [Size ratio proportional to distance](#size-ratio-proportional-to-distance)
        -   [Size difference proportional to distance](#size-difference-proportional-to-distance)
-   [Topographic data](#topographic-data)
    -   [Elevation](#elevation)
    -   [Slope](#slope)
-   [Focal tree summary](#focal-tree-summary)
    -   [dn Focal tree](#dn-focal-tree)
    -   [height Focal tree](#height-focal-tree)
-   [General topo of the sites](#general-topo-of-the-sites)

Prepare Data
============

-   Two datasets: focal tree and competence

``` r
# Compute diameter (mm)
tree <- tree %>% 
  mutate(dn_mm = (perim_mm / pi))
         
### - old code 4 sites 
# Set levels of eleveation 
# sj_lowcode  <- paste0('A', str_pad(1:10, 2, pad='0'))
# sj_highcode <- paste0('A', 11:20)
# ca_lowcode <- c(paste0('B', str_pad(1:10, 2, pad='0')),
#             paste0('B', 26:30))
# ca_highcode <- paste0('B', 11:25)
# 
# tree <- tree %>% 
#   mutate(elevF = ifelse(id_focal %in% sj_lowcode, 'Low',
#                        ifelse(id_focal %in% sj_highcode, 'High',
#                               ifelse(id_focal %in% ca_lowcode, 'Low', 'High')))) %>%
#   mutate(site = paste0(loc, '_', elevF))
# 
# 


sj_code  <- paste0('A', str_pad(1:20, 2, pad='0'))
ca_lowcode <- c(paste0('B', str_pad(1:10, 2, pad='0')), paste0('B', 26:30))
ca_highcode <- paste0('B', 11:25)

tree <- tree %>% mutate(
  site = as.factor(case_when(
    id_focal %in% sj_code ~ "sj", 
    id_focal %in% ca_highcode ~ "caH", 
    id_focal %in% ca_lowcode ~ "caL")))
    
# Get only focal trees  
ft <- tree %>% 
  filter(sp=='Focal') %>% 
  filter(id_focal!='Fresno') 

# Get only no focal trees 
nft <- tree %>% 
  filter(sp!='Focal') 
```

General Variables
=================

Numbers of focal trees by site

``` r
general_var <- ft %>% group_by(site) %>% count() 

general_var %>% kable
```

| site |    n|
|:-----|----:|
| caH  |   15|
| caL  |   15|
| sj   |   20|

Spatial Info
============

Coordinates of the centroid for each site

``` r
## Get coordinates of spatial data  
sp_ca <- as.data.frame(field_work_ca) %>% 
  dplyr::select(ele, name, lat = coords.x2, long = coords.x1) 

sp_sj <- as.data.frame(field_work_sj) %>% 
  dplyr::select(ele, name, lat = coords.x2, long = coords.x1) 

sp_sites <- rbind(sp_sj, sp_ca) %>% 
  mutate(site = as.factor(case_when(
    name %in% sj_code ~ "sj", 
    name %in% ca_highcode ~ "caH", 
    name %in% ca_lowcode ~ "caL")))


coord_sites <- sp_sites %>% 
  group_by(site) %>%
  dplyr::summarise(lat_m = mean(lat), long_m = mean(long))
  
coord_sites %>% kable()
```

| site |    lat\_m|    long\_m|
|:-----|---------:|----------:|
| caH  |  36.96613|  -3.420703|
| caL  |  36.95645|  -3.424107|
| sj   |  37.13121|  -3.374908|

``` r
# old code 
# 
# 
# 
# ## Add code site and get centroid (see # http://rspatial.org/analysis/rst/8-pointpat.html)
# sp_ca <- sp_ca %>% 
#   mutate(loc = 'CA', 
#          
#          
#          elevF = ifelse(name %in% ca_lowcode, 'Low', 'High'),
#          site = paste0(loc, '_', elevF)) 
# 
# coord_ca <- sp_ca %>% 
#   group_by(site) %>%
#   summarise(lat_m = mean(lat),
#             long_m = mean(long))
# 
# # plot(sp_ca$long, sp_ca$lat, pch=19, col='gray')
# # points(coord_ca$long_m, coord_ca$lat_m, pch=19, col='blue')
#   
# sp_sj <- sp_sj %>% 
#   mutate(loc = 'SJ', 
#          elevF = ifelse(name %in% sj_lowcode, 'Low', 'High'),
#          site = paste0(loc, '_', elevF))        
# coord_sj <- sp_sj %>% 
#   group_by(site) %>%
#   summarise(lat_m = mean(lat),
#             long_m = mean(long))
# 
# coords_sites <- coord_sj %>% rbind(coord_ca)
# 
# #plot(sp_sj$long, sp_sj$lat, pch=19, col='gray')
# #points(coord_sj$long_m, coord_sj$lat_m, pch=19, col='blue')
# 
# coords_sites %>% kable()
```

Competition data
================

-   Read data

-   Create a custom function to compare between sites (aov & post hoc)

-   Export data into text files (see `/out/anovas_competition/`)

Distance-Independet Indices
---------------------------

### Basal Area

<table style="width:83%;">
<caption>Mean values (ba)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">1.229</td>
<td align="center">0.7637</td>
<td align="center">0.1972</td>
<td align="center">0.0118</td>
<td align="center">2.817</td>
<td align="center">b</td>
<td align="center">ba</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">0.5661</td>
<td align="center">0.2235</td>
<td align="center">0.0577</td>
<td align="center">0.2512</td>
<td align="center">0.8633</td>
<td align="center">a</td>
<td align="center">ba</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">0.3658</td>
<td align="center">0.1717</td>
<td align="center">0.0384</td>
<td align="center">0.1205</td>
<td align="center">0.7658</td>
<td align="center">a</td>
<td align="center">ba</td>
</tr>
</tbody>
</table>

<table style="width:74%;">
<caption>ANOVA table (ba)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">6.696</td>
<td align="center">3.348</td>
<td align="center">16.7</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">9.424</td>
<td align="center">0.2005</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Stand Density

<table style="width:78%;">
<caption>Mean values (std)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="8%" />
<col width="8%" />
<col width="8%" />
<col width="8%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">348</td>
<td align="center">147.1</td>
<td align="center">37.98</td>
<td align="center">63.66</td>
<td align="center">541.1</td>
<td align="center">a</td>
<td align="center">std</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">409.6</td>
<td align="center">226</td>
<td align="center">58.35</td>
<td align="center">159.2</td>
<td align="center">1050</td>
<td align="center">a</td>
<td align="center">std</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">339</td>
<td align="center">130.3</td>
<td align="center">29.14</td>
<td align="center">127.3</td>
<td align="center">636.6</td>
<td align="center">a</td>
<td align="center">std</td>
</tr>
</tbody>
</table>

<table style="width:74%;">
<caption>ANOVA table (std)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">47401</td>
<td align="center">23701</td>
<td align="center">0.8309</td>
<td align="center">0.442</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">1340699</td>
<td align="center">28526</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Plot Density

<table style="width:83%;">
<caption>Mean values (pd)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">0.0348</td>
<td align="center">0.0147</td>
<td align="center">0.0038</td>
<td align="center">0.0064</td>
<td align="center">0.0541</td>
<td align="center">a</td>
<td align="center">pd</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">0.041</td>
<td align="center">0.0226</td>
<td align="center">0.0058</td>
<td align="center">0.0159</td>
<td align="center">0.105</td>
<td align="center">a</td>
<td align="center">pd</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">0.0339</td>
<td align="center">0.013</td>
<td align="center">0.0029</td>
<td align="center">0.0127</td>
<td align="center">0.0637</td>
<td align="center">a</td>
<td align="center">pd</td>
</tr>
</tbody>
</table>

<table style="width:74%;">
<caption>ANOVA table (pd)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">0.00047</td>
<td align="center">0.00024</td>
<td align="center">0.8309</td>
<td align="center">0.442</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">0.01341</td>
<td align="center">0.00029</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Number of competitors within *r* meters (10 m)

<table style="width:83%;">
<caption>Mean values (n_competitors)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="8%" />
<col width="9%" />
<col width="8%" />
<col width="8%" />
<col width="11%" />
<col width="18%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">10.93</td>
<td align="center">4.621</td>
<td align="center">1.193</td>
<td align="center">2</td>
<td align="center">17</td>
<td align="center">a</td>
<td align="center">n_competitors</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">12.87</td>
<td align="center">7.1</td>
<td align="center">1.833</td>
<td align="center">5</td>
<td align="center">33</td>
<td align="center">a</td>
<td align="center">n_competitors</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">10.65</td>
<td align="center">4.095</td>
<td align="center">0.9156</td>
<td align="center">4</td>
<td align="center">20</td>
<td align="center">a</td>
<td align="center">n_competitors</td>
</tr>
</tbody>
</table>

<table style="width:74%;">
<caption>ANOVA table (n_competitors)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">46.78</td>
<td align="center">23.39</td>
<td align="center">0.8309</td>
<td align="center">0.442</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">1323</td>
<td align="center">28.15</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Number of competitors within *r* meters (10 m) such that $ dbh\_j &gt; dbh\_i $

<table style="width:94%;">
<caption>Mean values (n_competitors_higher)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="8%" />
<col width="8%" />
<col width="11%" />
<col width="27%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">1.2</td>
<td align="center">1.474</td>
<td align="center">0.3805</td>
<td align="center">0</td>
<td align="center">4</td>
<td align="center">a</td>
<td align="center">n_competitors_higher</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">0.6667</td>
<td align="center">0.8165</td>
<td align="center">0.2108</td>
<td align="center">0</td>
<td align="center">2</td>
<td align="center">a</td>
<td align="center">n_competitors_higher</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">0.5</td>
<td align="center">0.6882</td>
<td align="center">0.1539</td>
<td align="center">0</td>
<td align="center">2</td>
<td align="center">a</td>
<td align="center">n_competitors_higher</td>
</tr>
</tbody>
</table>

<table style="width:74%;">
<caption>ANOVA table (n_competitors_higher)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">4.387</td>
<td align="center">2.193</td>
<td align="center">2.115</td>
<td align="center">0.1319</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">48.73</td>
<td align="center">1.037</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Sum of size of trees within *r* meters (10 m)

<table style="width:82%;">
<caption>Mean values (sum_sizes)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="8%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">3.374</td>
<td align="center">1.444</td>
<td align="center">0.373</td>
<td align="center">0.1735</td>
<td align="center">6.201</td>
<td align="center">b</td>
<td align="center">sum_sizes</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">2.549</td>
<td align="center">1.073</td>
<td align="center">0.2771</td>
<td align="center">1.275</td>
<td align="center">5.28</td>
<td align="center">ab</td>
<td align="center">sum_sizes</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">2.077</td>
<td align="center">0.8657</td>
<td align="center">0.1936</td>
<td align="center">0.8324</td>
<td align="center">4.269</td>
<td align="center">a</td>
<td align="center">sum_sizes</td>
</tr>
</tbody>
</table>

<table style="width:78%;">
<caption>ANOVA table (sum_sizes)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">14.5</td>
<td align="center">7.249</td>
<td align="center">5.718</td>
<td align="center"><strong>0.00599</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">59.58</td>
<td align="center">1.268</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

Size ratio
----------

<table style="width:83%;">
<caption>Mean values (sr)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">0.2153</td>
<td align="center">0.1957</td>
<td align="center">0.0505</td>
<td align="center">0.0794</td>
<td align="center">0.876</td>
<td align="center">a</td>
<td align="center">sr</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">0.1705</td>
<td align="center">0.0682</td>
<td align="center">0.0176</td>
<td align="center">0.0648</td>
<td align="center">0.3309</td>
<td align="center">a</td>
<td align="center">sr</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">0.1512</td>
<td align="center">0.0643</td>
<td align="center">0.0144</td>
<td align="center">0.0662</td>
<td align="center">0.2961</td>
<td align="center">a</td>
<td align="center">sr</td>
</tr>
</tbody>
</table>

<table style="width:74%;">
<caption>ANOVA table (sr)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">0.03592</td>
<td align="center">0.01796</td>
<td align="center">1.242</td>
<td align="center">0.2982</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">0.6797</td>
<td align="center">0.01446</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

Distance-Dependet Indices
-------------------------

### Distance to nearest tree

<table style="width:79%;">
<caption>Mean values (dnn)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="8%" />
<col width="9%" />
<col width="8%" />
<col width="8%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">3.412</td>
<td align="center">1.859</td>
<td align="center">0.4801</td>
<td align="center">0.88</td>
<td align="center">6.75</td>
<td align="center">a</td>
<td align="center">dnn</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">3.123</td>
<td align="center">1.308</td>
<td align="center">0.3377</td>
<td align="center">1.44</td>
<td align="center">5.53</td>
<td align="center">a</td>
<td align="center">dnn</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">2.4</td>
<td align="center">1.328</td>
<td align="center">0.2969</td>
<td align="center">0.67</td>
<td align="center">4.99</td>
<td align="center">a</td>
<td align="center">dnn</td>
</tr>
</tbody>
</table>

<table style="width:74%;">
<caption>ANOVA table (dnn)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">9.665</td>
<td align="center">4.833</td>
<td align="center">2.146</td>
<td align="center">0.1283</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">105.8</td>
<td align="center">2.252</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Crowding

<table style="width:83%;">
<caption>Mean values (crowding)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">0.7169</td>
<td align="center">0.4719</td>
<td align="center">0.1219</td>
<td align="center">0.0215</td>
<td align="center">1.64</td>
<td align="center">a</td>
<td align="center">crowding</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">0.4818</td>
<td align="center">0.1844</td>
<td align="center">0.0476</td>
<td align="center">0.2535</td>
<td align="center">0.9069</td>
<td align="center">a</td>
<td align="center">crowding</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">0.4681</td>
<td align="center">0.2521</td>
<td align="center">0.0564</td>
<td align="center">0.1922</td>
<td align="center">1.026</td>
<td align="center">a</td>
<td align="center">crowding</td>
</tr>
</tbody>
</table>

<table style="width:78%;">
<caption>ANOVA table (crowding)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">0.6212</td>
<td align="center">0.3106</td>
<td align="center">3.04</td>
<td align="center"><strong>0.05732</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">4.802</td>
<td align="center">0.1022</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Lorimer

<table style="width:79%;">
<caption>Mean values (lorimer)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="8%" />
<col width="8%" />
<col width="9%" />
<col width="8%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">7.664</td>
<td align="center">4.711</td>
<td align="center">1.216</td>
<td align="center">0.1569</td>
<td align="center">18.62</td>
<td align="center">a</td>
<td align="center">lorimer</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">7.779</td>
<td align="center">3.937</td>
<td align="center">1.017</td>
<td align="center">2.749</td>
<td align="center">18.51</td>
<td align="center">a</td>
<td align="center">lorimer</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">9.345</td>
<td align="center">4.069</td>
<td align="center">0.91</td>
<td align="center">3.796</td>
<td align="center">19.29</td>
<td align="center">a</td>
<td align="center">lorimer</td>
</tr>
</tbody>
</table>

<table style="width:74%;">
<caption>ANOVA table (lorimer)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">31.72</td>
<td align="center">15.86</td>
<td align="center">0.8849</td>
<td align="center">0.4195</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">842.3</td>
<td align="center">17.92</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Negative Exponential size ratio

<table style="width:83%;">
<caption>Mean values (nesr)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">0.0586</td>
<td align="center">0.085</td>
<td align="center">0.0219</td>
<td align="center">0</td>
<td align="center">0.2509</td>
<td align="center">a</td>
<td align="center">nesr</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">0.0348</td>
<td align="center">0.0325</td>
<td align="center">0.0084</td>
<td align="center">0.0013</td>
<td align="center">0.1035</td>
<td align="center">a</td>
<td align="center">nesr</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">0.0771</td>
<td align="center">0.0946</td>
<td align="center">0.0211</td>
<td align="center">0.0034</td>
<td align="center">0.3422</td>
<td align="center">a</td>
<td align="center">nesr</td>
</tr>
</tbody>
</table>

<table style="width:74%;">
<caption>ANOVA table (nesr)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">0.01534</td>
<td align="center">0.00767</td>
<td align="center">1.261</td>
<td align="center">0.2927</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">0.2858</td>
<td align="center">0.00608</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Negative Exponential Weighted size ratio

<table style="width:82%;">
<caption>Mean values (newsr)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="8%" />
<col width="9%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">0.4838</td>
<td align="center">0.6224</td>
<td align="center">0.1607</td>
<td align="center">9e-04</td>
<td align="center">1.681</td>
<td align="center">a</td>
<td align="center">newsr</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">0.1792</td>
<td align="center">0.2233</td>
<td align="center">0.0576</td>
<td align="center">2e-04</td>
<td align="center">0.7879</td>
<td align="center">a</td>
<td align="center">newsr</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">0.3965</td>
<td align="center">0.6886</td>
<td align="center">0.154</td>
<td align="center">5e-04</td>
<td align="center">2.57</td>
<td align="center">a</td>
<td align="center">newsr</td>
</tr>
</tbody>
</table>

<table style="width:74%;">
<caption>ANOVA table (newsr)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">0.7463</td>
<td align="center">0.3731</td>
<td align="center">1.159</td>
<td align="center">0.3226</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">15.13</td>
<td align="center">0.3219</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Size ratio proportional to distance

<table style="width:82%;">
<caption>Mean values (srd)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
<col width="8%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">0.9085</td>
<td align="center">0.629</td>
<td align="center">0.1624</td>
<td align="center">0.0156</td>
<td align="center">2.379</td>
<td align="center">a</td>
<td align="center">srd</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">0.8896</td>
<td align="center">0.4385</td>
<td align="center">0.1132</td>
<td align="center">0.3213</td>
<td align="center">2.06</td>
<td align="center">a</td>
<td align="center">srd</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">1.111</td>
<td align="center">0.5199</td>
<td align="center">0.1163</td>
<td align="center">0.4794</td>
<td align="center">2.247</td>
<td align="center">a</td>
<td align="center">srd</td>
</tr>
</tbody>
</table>

<table style="width:74%;">
<caption>ANOVA table (srd)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">0.5441</td>
<td align="center">0.272</td>
<td align="center">0.9565</td>
<td align="center">0.3916</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">13.37</td>
<td align="center">0.2844</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Size difference proportional to distance

<table style="width:88%;">
<caption>Mean values (sdd)</caption>
<colgroup>
<col width="9%" />
<col width="11%" />
<col width="9%" />
<col width="9%" />
<col width="11%" />
<col width="11%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">-0.4931</td>
<td align="center">0.4018</td>
<td align="center">0.1037</td>
<td align="center">-1.226</td>
<td align="center">-0.0625</td>
<td align="center">a</td>
<td align="center">sdd</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">-0.4143</td>
<td align="center">0.2291</td>
<td align="center">0.0592</td>
<td align="center">-1.022</td>
<td align="center">-0.0853</td>
<td align="center">ab</td>
<td align="center">sdd</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">-0.2091</td>
<td align="center">0.0972</td>
<td align="center">0.0217</td>
<td align="center">-0.4064</td>
<td align="center">-0.0826</td>
<td align="center">b</td>
<td align="center">sdd</td>
</tr>
</tbody>
</table>

<table style="width:78%;">
<caption>ANOVA table (sdd)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">0.7649</td>
<td align="center">0.3825</td>
<td align="center">5.662</td>
<td align="center"><strong>0.00626</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">3.175</td>
<td align="center">0.06755</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

Topographic data
================

-   Read data

``` r
# Read topo data 
topo <- read.csv(file=paste(di, "/data/topo/topo.csv", sep=""), header=TRUE, sep=',')

# topo <- topo %>% 
#   mutate(loc = ifelse(str_detect(name, "A"), 'SJ', 'CA'),
#          elevF = ifelse(name %in% sj_lowcode, 'Low',
#                         ifelse(name %in% sj_highcode, 'High',
#                               ifelse(name %in% ca_lowcode, 'Low', 'High')))) %>%
#   mutate(site = paste0(loc, '_', elevF)) %>% 
#   mutate(site = as.factor(site),
#          loc = as.factor(loc),
#          elevF = as.factor(elevF))

topo <- topo %>% 
  mutate(site = as.factor(case_when(
    name %in% sj_code ~ "sj", 
    name %in% ca_highcode ~ "caH", 
    name %in% ca_lowcode ~ "caL")))
```

-   Compare data and export data into text files (see `/out/anovas_topo/`)

### Elevation

<table style="width:78%;">
<caption>Mean values (mde)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="8%" />
<col width="8%" />
<col width="8%" />
<col width="8%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">1865</td>
<td align="center">12.14</td>
<td align="center">3.135</td>
<td align="center">1846</td>
<td align="center">1884</td>
<td align="center">c</td>
<td align="center">mde</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">1719</td>
<td align="center">21.9</td>
<td align="center">5.655</td>
<td align="center">1691</td>
<td align="center">1751</td>
<td align="center">b</td>
<td align="center">mde</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">1395</td>
<td align="center">59.68</td>
<td align="center">13.35</td>
<td align="center">1322</td>
<td align="center">1474</td>
<td align="center">a</td>
<td align="center">mde</td>
</tr>
</tbody>
</table>

<table style="width:74%;">
<caption>ANOVA table (mde)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">2044877</td>
<td align="center">1022439</td>
<td align="center">628.5</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">76459</td>
<td align="center">1627</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Slope

<table style="width:79%;">
<caption>Mean values (slope)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="8%" />
<col width="9%" />
<col width="8%" />
<col width="8%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">12.11</td>
<td align="center">3.275</td>
<td align="center">0.8457</td>
<td align="center">6.853</td>
<td align="center">18.23</td>
<td align="center">a</td>
<td align="center">slope</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">12.86</td>
<td align="center">2.984</td>
<td align="center">0.7705</td>
<td align="center">8.669</td>
<td align="center">18.04</td>
<td align="center">a</td>
<td align="center">slope</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">27.33</td>
<td align="center">5.593</td>
<td align="center">1.251</td>
<td align="center">16.88</td>
<td align="center">34.27</td>
<td align="center">b</td>
<td align="center">slope</td>
</tr>
</tbody>
</table>

<table style="width:74%;">
<caption>ANOVA table (slope)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">2647</td>
<td align="center">1323</td>
<td align="center">71.57</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">869.1</td>
<td align="center">18.49</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

Focal tree summary
==================

``` r
## Comparison 
# Select only variables to compare 
ft_sel <- ft %>%
  mutate(dn = dn_mm / 10, 
         h = height_cm / 100) %>% 
  dplyr::select(dn, h, site) 

  
# Get vector with variables 
variables <- c('dn','h')

for (i in variables){ 
  
  # apply comparison
  out_compara <- compara(df=ft_sel, mivariable = i)
  
  out_name  <- paste0('aov_', i)
  assign(out_name, out_compara)

}


# Loop to export into txt files (see ./out/anovas_ft ... )
for (i in variables){ 
 
  out <- get(paste0('aov_', i))
  
  file_out <- file(paste0(di,'out/anovas_ft/aov_', i, '.txt'), "w")
  sink(file_out)

  cat("MODEL \n")
  print(out$mymodel) 
  cat("\n")
  
  cat("MODEL pretty \n")
  print(out$tm) 
  cat("\n")
  
  cat("POST HOC \n")
  print(out$mymult) 
  cat("\n")
  
  cat("SUMMARY VALUES \n")
  print(as.data.frame(out$summ_comparison))
  cat("\n")
  
  while (sink.number()>0) sink()
  # close(file_out)

}

while (sink.number()>0) sink()
```

### dn Focal tree

<table style="width:79%;">
<caption>Mean values (dn)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="8%" />
<col width="9%" />
<col width="8%" />
<col width="8%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">69.75</td>
<td align="center">20.51</td>
<td align="center">5.297</td>
<td align="center">44.56</td>
<td align="center">122.5</td>
<td align="center">c</td>
<td align="center">dn</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">45.9</td>
<td align="center">8.6</td>
<td align="center">2.221</td>
<td align="center">35.97</td>
<td align="center">63.66</td>
<td align="center">b</td>
<td align="center">dn</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">31.86</td>
<td align="center">3.728</td>
<td align="center">0.8335</td>
<td align="center">26.42</td>
<td align="center">39.79</td>
<td align="center">a</td>
<td align="center">dn</td>
</tr>
</tbody>
</table>

<table style="width:74%;">
<caption>ANOVA table (dn)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">12356</td>
<td align="center">6178</td>
<td align="center">40.38</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">7191</td>
<td align="center">153</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### height Focal tree

<table style="width:79%;">
<caption>Mean values (h)</caption>
<colgroup>
<col width="9%" />
<col width="9%" />
<col width="8%" />
<col width="9%" />
<col width="8%" />
<col width="8%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">min</th>
<th align="center">max</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">15.42</td>
<td align="center">1.784</td>
<td align="center">0.4606</td>
<td align="center">11.9</td>
<td align="center">18</td>
<td align="center">b</td>
<td align="center">h</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">12.61</td>
<td align="center">1.575</td>
<td align="center">0.4065</td>
<td align="center">9.5</td>
<td align="center">14.7</td>
<td align="center">a</td>
<td align="center">h</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">11.81</td>
<td align="center">2.304</td>
<td align="center">0.5153</td>
<td align="center">5.7</td>
<td align="center">16.2</td>
<td align="center">a</td>
<td align="center">h</td>
</tr>
</tbody>
</table>

<table style="width:74%;">
<caption>ANOVA table (h)</caption>
<colgroup>
<col width="13%" />
<col width="6%" />
<col width="11%" />
<col width="12%" />
<col width="16%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">term</th>
<th align="center">df</th>
<th align="center">sumsq</th>
<th align="center">meansq</th>
<th align="center">statistic</th>
<th align="center">p.value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">117.4</td>
<td align="center">58.68</td>
<td align="center">15.31</td>
<td align="center"><strong>1e-05</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">47</td>
<td align="center">180.1</td>
<td align="center">3.833</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

``` r
# Join all data and export as table

# Get name of variables 
variables <- compe %>% dplyr::select(ba:dnn) %>% names() %>% rbind()
# Add topo and focal tree variables 
nombres <- c(variables, 'mde','slope', 'dn', 'h')

out <- c()

for (i in nombres){ 
  # name of aov object
  aov_name <- paste0('aov_',i)
  # get aov_object 
  aux <- get(aov_name)
  # get summ comparison dataframe 
  aux2 <- aux$summ_comparison
  out <- rbind(out, aux2)
}

out2 <- out %>% dplyr::select(site, mean, sd, tukey, mivar = variable)
                              

# See this solution 
# http://stackoverflow.com/questions/39066811/long-to-wide-with-dplyr
# http://garrettgman.github.io/tidying/
out3 <- gather(out2, variable, value, mean, sd, tukey) %>% 
  unite(var, variable, site) %>% 
  spread(var, value, convert=TRUE) 
  

# out4 <- out3 %>% 
#   transmute(variables = mivar,
#             CA_High_m = round(mean_CA_High, 3),
#             CA_High_sd = round(sd_CA_High, 3),
#             CA_High_l = tukey_CA_High,
#             CA_Low_m = round(mean_CA_Low, 3),
#             CA_Low_sd = round(sd_CA_Low, 3),
#             CA_Low_l = tukey_CA_Low,
#             SJ_High_m = round(mean_SJ_High, 3),
#             SJ_High_sd = round(sd_SJ_High, 3),
#             SJ_High_l = tukey_SJ_High,
#             SJ_Low_m = round(mean_SJ_Low, 3),
#             SJ_Low_sd = round(sd_SJ_Low, 3),
#             SJ_Low_l = tukey_SJ_Low)

out4 <- out3 %>% 
  transmute(variables = mivar,
            caH_m = round(mean_caH, 3),
            caH_sd = round(sd_caH, 3),
            caH_l = tukey_caH,
            caL_m = round(mean_caL, 3),
            caL_sd = round(sd_caL, 3),
            caL_l = tukey_caL,
            sj_m = round(mean_sj, 3),
            sj_sd = round(sd_sj, 3),
            sj_l = tukey_sj)
            

# Export data 
# write.csv(out4, file=paste(di, "data/proto_tables/site_features.csv", sep=""), row.names = FALSE)
write.csv(out4, file=paste(di, "data/competence/resumen_medias_indices_competencia.csv", sep=""), row.names = FALSE)

pander(out4, caption='Summary Values')
```

<table>
<caption>Summary Values (continued below)</caption>
<colgroup>
<col width="26%" />
<col width="10%" />
<col width="11%" />
<col width="10%" />
<col width="10%" />
<col width="11%" />
<col width="10%" />
<col width="10%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">variables</th>
<th align="center">caH_m</th>
<th align="center">caH_sd</th>
<th align="center">caH_l</th>
<th align="center">caL_m</th>
<th align="center">caL_sd</th>
<th align="center">caL_l</th>
<th align="center">sj_m</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">ba</td>
<td align="center">1.229</td>
<td align="center">0.764</td>
<td align="center">b</td>
<td align="center">0.566</td>
<td align="center">0.223</td>
<td align="center">a</td>
<td align="center">0.366</td>
</tr>
<tr class="even">
<td align="center">crowding</td>
<td align="center">0.717</td>
<td align="center">0.472</td>
<td align="center">a</td>
<td align="center">0.482</td>
<td align="center">0.184</td>
<td align="center">a</td>
<td align="center">0.468</td>
</tr>
<tr class="odd">
<td align="center">dn</td>
<td align="center">69.75</td>
<td align="center">20.51</td>
<td align="center">c</td>
<td align="center">45.9</td>
<td align="center">8.6</td>
<td align="center">b</td>
<td align="center">31.86</td>
</tr>
<tr class="even">
<td align="center">dnn</td>
<td align="center">3.412</td>
<td align="center">1.859</td>
<td align="center">a</td>
<td align="center">3.123</td>
<td align="center">1.308</td>
<td align="center">a</td>
<td align="center">2.4</td>
</tr>
<tr class="odd">
<td align="center">h</td>
<td align="center">15.42</td>
<td align="center">1.784</td>
<td align="center">b</td>
<td align="center">12.61</td>
<td align="center">1.575</td>
<td align="center">a</td>
<td align="center">11.81</td>
</tr>
<tr class="even">
<td align="center">lorimer</td>
<td align="center">7.664</td>
<td align="center">4.711</td>
<td align="center">a</td>
<td align="center">7.779</td>
<td align="center">3.937</td>
<td align="center">a</td>
<td align="center">9.345</td>
</tr>
<tr class="odd">
<td align="center">mde</td>
<td align="center">1865</td>
<td align="center">12.14</td>
<td align="center">c</td>
<td align="center">1719</td>
<td align="center">21.9</td>
<td align="center">b</td>
<td align="center">1395</td>
</tr>
<tr class="even">
<td align="center">n_competitors</td>
<td align="center">10.93</td>
<td align="center">4.621</td>
<td align="center">a</td>
<td align="center">12.87</td>
<td align="center">7.1</td>
<td align="center">a</td>
<td align="center">10.65</td>
</tr>
<tr class="odd">
<td align="center">n_competitors_higher</td>
<td align="center">1.2</td>
<td align="center">1.474</td>
<td align="center">a</td>
<td align="center">0.667</td>
<td align="center">0.816</td>
<td align="center">a</td>
<td align="center">0.5</td>
</tr>
<tr class="even">
<td align="center">nesr</td>
<td align="center">0.059</td>
<td align="center">0.085</td>
<td align="center">a</td>
<td align="center">0.035</td>
<td align="center">0.032</td>
<td align="center">a</td>
<td align="center">0.077</td>
</tr>
<tr class="odd">
<td align="center">newsr</td>
<td align="center">0.484</td>
<td align="center">0.622</td>
<td align="center">a</td>
<td align="center">0.179</td>
<td align="center">0.223</td>
<td align="center">a</td>
<td align="center">0.397</td>
</tr>
<tr class="even">
<td align="center">pd</td>
<td align="center">0.035</td>
<td align="center">0.015</td>
<td align="center">a</td>
<td align="center">0.041</td>
<td align="center">0.023</td>
<td align="center">a</td>
<td align="center">0.034</td>
</tr>
<tr class="odd">
<td align="center">sdd</td>
<td align="center">-0.493</td>
<td align="center">0.402</td>
<td align="center">a</td>
<td align="center">-0.414</td>
<td align="center">0.229</td>
<td align="center">ab</td>
<td align="center">-0.209</td>
</tr>
<tr class="even">
<td align="center">slope</td>
<td align="center">12.11</td>
<td align="center">3.275</td>
<td align="center">a</td>
<td align="center">12.86</td>
<td align="center">2.984</td>
<td align="center">a</td>
<td align="center">27.32</td>
</tr>
<tr class="odd">
<td align="center">sr</td>
<td align="center">0.215</td>
<td align="center">0.196</td>
<td align="center">a</td>
<td align="center">0.171</td>
<td align="center">0.068</td>
<td align="center">a</td>
<td align="center">0.151</td>
</tr>
<tr class="even">
<td align="center">srd</td>
<td align="center">0.908</td>
<td align="center">0.629</td>
<td align="center">a</td>
<td align="center">0.89</td>
<td align="center">0.438</td>
<td align="center">a</td>
<td align="center">1.111</td>
</tr>
<tr class="odd">
<td align="center">std</td>
<td align="center">348</td>
<td align="center">147.1</td>
<td align="center">a</td>
<td align="center">409.6</td>
<td align="center">226</td>
<td align="center">a</td>
<td align="center">339</td>
</tr>
<tr class="even">
<td align="center">sum_sizes</td>
<td align="center">3.374</td>
<td align="center">1.444</td>
<td align="center">b</td>
<td align="center">2.549</td>
<td align="center">1.073</td>
<td align="center">ab</td>
<td align="center">2.077</td>
</tr>
</tbody>
</table>

<table style="width:22%;">
<colgroup>
<col width="11%" />
<col width="11%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">sj_sd</th>
<th align="center">sj_l</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">0.172</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">0.252</td>
<td align="center">a</td>
</tr>
<tr class="odd">
<td align="center">3.728</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">1.328</td>
<td align="center">a</td>
</tr>
<tr class="odd">
<td align="center">2.304</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">4.07</td>
<td align="center">a</td>
</tr>
<tr class="odd">
<td align="center">59.68</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">4.095</td>
<td align="center">a</td>
</tr>
<tr class="odd">
<td align="center">0.688</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">0.095</td>
<td align="center">a</td>
</tr>
<tr class="odd">
<td align="center">0.689</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">0.013</td>
<td align="center">a</td>
</tr>
<tr class="odd">
<td align="center">0.097</td>
<td align="center">b</td>
</tr>
<tr class="even">
<td align="center">5.593</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">0.064</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">0.52</td>
<td align="center">a</td>
</tr>
<tr class="odd">
<td align="center">130.3</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">0.866</td>
<td align="center">a</td>
</tr>
</tbody>
</table>

General topo of the sites
=========================

``` r
topo_site <- topo %>% group_by(site) %>% summarise(
  elev_mean = mean(mde), 
  elev_min = min(mde), 
  elev_max = max(mde), 
  slope_mean = mean(slope)
)


site_general <- general_var %>% 
  left_join(coord_sites, by='site') %>% 
  left_join(topo_site, by='site') 

write.csv(site_general, file=paste(di, "data/sites_summary/site_general.csv", sep=""), row.names = FALSE)
```
