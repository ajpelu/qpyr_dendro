-   [Prepare Data](#prepare-data)
-   [General Variables](#general-variables)
-   [Spatial Info](#spatial-info)
-   [Topographic data](#topographic-data)
    -   [Data summary](#data-summary)
    -   [ANOVAs](#anovas)
        -   [Elevation](#elevation)
        -   [Slope](#slope)
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

Prepare Data
============

-   Two datasets: focal tree and competence

``` r
# Compute diameter (mm)
tree <- tree %>% 
  mutate(dn_mm = (perim_mm / pi))
         

# Set levels of eleveation 
sj_lowcode  <- paste0('A', str_pad(1:10, 2, pad='0'))
sj_highcode <- paste0('A', 11:20)
ca_lowcode <- c(paste0('B', str_pad(1:10, 2, pad='0')),
            paste0('B', 26:30))
ca_highcode <- paste0('B', 11:25)

tree <- tree %>% 
  mutate(elevF = ifelse(id_focal %in% sj_lowcode, 'Low',
                       ifelse(id_focal %in% sj_highcode, 'High',
                              ifelse(id_focal %in% ca_lowcode, 'Low', 'High')))) %>%
  mutate(site = paste0(loc, '_', elevF))


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
general_var <- ft %>% group_by(loc, site) %>% count() 

general_var %>% kable
```

| loc | site     |    n|
|:----|:---------|----:|
| CA  | CA\_High |   15|
| CA  | CA\_Low  |   15|
| SJ  | SJ\_High |   10|
| SJ  | SJ\_Low  |   10|

Spatial Info
============

Coordinates of the centroid for each site

``` r
## Get coordinates of spatial data  
sp_ca <- as.data.frame(field_work_ca) %>% 
  dplyr::select(ele, name, lat = coords.x2, long = coords.x1) 

sp_sj <- as.data.frame(field_work_sj) %>% 
  dplyr::select(ele, name, lat = coords.x2, long = coords.x1) 

## Add code site and get centroid (see # http://rspatial.org/analysis/rst/8-pointpat.html)
sp_ca <- sp_ca %>% 
  mutate(loc = 'CA', 
         elevF = ifelse(name %in% ca_lowcode, 'Low', 'High'),
         site = paste0(loc, '_', elevF)) 

coord_ca <- sp_ca %>% 
  group_by(site) %>%
  summarise(lat_m = mean(lat),
            long_m = mean(long))

# plot(sp_ca$long, sp_ca$lat, pch=19, col='gray')
# points(coord_ca$long_m, coord_ca$lat_m, pch=19, col='blue')
  
sp_sj <- sp_sj %>% 
  mutate(loc = 'SJ', 
         elevF = ifelse(name %in% sj_lowcode, 'Low', 'High'),
         site = paste0(loc, '_', elevF))        
coord_sj <- sp_sj %>% 
  group_by(site) %>%
  summarise(lat_m = mean(lat),
            long_m = mean(long))

coords_sites <- coord_sj %>% rbind(coord_ca)

#plot(sp_sj$long, sp_sj$lat, pch=19, col='gray')
#points(coord_sj$long_m, coord_sj$lat_m, pch=19, col='blue')

coords_sites %>% kable()
```

| site     |    lat\_m|    long\_m|
|:---------|---------:|----------:|
| SJ\_High |  37.12916|  -3.365722|
| SJ\_Low  |  37.13326|  -3.384094|
| CA\_High |  36.96613|  -3.420703|
| CA\_Low  |  36.95645|  -3.424107|

Topographic data
================

Data summary
------------

``` r
# Read topo data 
topo <- read.csv(file=paste(di, "/data/topo/topo.csv", sep=""), header=TRUE, sep=',')

topo <- topo %>% 
  mutate(loc = ifelse(str_detect(name, "A"), 'SJ', 'CA'),
         elevF = ifelse(name %in% sj_lowcode, 'Low',
                        ifelse(name %in% sj_highcode, 'High',
                              ifelse(name %in% ca_lowcode, 'Low', 'High')))) %>%
  mutate(site = paste0(loc, '_', elevF)) %>% 
  mutate(site = as.factor(site),
         loc = as.factor(loc),
         elevF = as.factor(elevF))
                      

topo_summary <- topo %>%
  group_by(site) %>%
  summarise(mde_m = mean(mde),
            mde_sd = sd(mde),
            mde_min = min(mde),
            mde_max = max(mde),
            slope_m = mean(slope),
            slope_sd = sd(slope))



# Another way to obtain summary values 
variables <- c('mde','slope','aspect')
auxdf <- data.frame() 

for (i in variables){ 
aux <- topo %>% 
  dplyr::group_by(site) %>% 
  summarise_each_(funs(mean, sd, se=sd(.)/sqrt(n())), i) %>% mutate(variable=i) 

auxdf <- rbind(auxdf, aux) }
```

ANOVAs
------

### Elevation

``` r
mivariable <- 'mde'

# Model 
myformula <- as.formula(paste0(mivariable, " ~ site"))
mymodel <- aov(myformula, data=topo)

auxdf %>% 
  dplyr::filter(variable==mivariable) %>% 
  pander(round=4, caption=paste0('Mean values (', mivariable,')'))
```

<table style="width:62%;">
<caption>Mean values (mde)</caption>
<colgroup>
<col width="11%" />
<col width="12%" />
<col width="12%" />
<col width="12%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">CA_High</td>
<td align="center">1864.649</td>
<td align="center">12.14112</td>
<td align="center">3.134824</td>
<td align="center">mde</td>
</tr>
<tr class="even">
<td align="center">CA_Low</td>
<td align="center">1718.537</td>
<td align="center">21.90183</td>
<td align="center">5.655029</td>
<td align="center">mde</td>
</tr>
<tr class="odd">
<td align="center">SJ_High</td>
<td align="center">1450.954</td>
<td align="center">22.55849</td>
<td align="center">7.133620</td>
<td align="center">mde</td>
</tr>
<tr class="even">
<td align="center">SJ_Low</td>
<td align="center">1339.607</td>
<td align="center">11.10027</td>
<td align="center">3.510213</td>
<td align="center">mde</td>
</tr>
</tbody>
</table>

``` r
## Summary model 
tm <- broom::tidy(mymodel)

# See http://my.ilstu.edu/~wjschne/444/ANOVA.html#(1) 
pander(tm, round=5,caption = "ANOVA table", missing = '', 
       emphasize.strong.cells = 
               which(tm < 0.1 & tm == tm$p.value, arr.ind = T))
```

<table style="width:74%;">
<caption>ANOVA table</caption>
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
<td align="center">3</td>
<td align="center">2106868</td>
<td align="center">702289</td>
<td align="center">2233</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">46</td>
<td align="center">14468</td>
<td align="center">314.5</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

``` r
## Multiple comparison 
tuk <- glht(mymodel, linfct = mcp(site = "Tukey"))

# Convert comparisons into letters 
df_letter <- fortify(cld(tuk)) %>%
  transmute(site = as.factor(lhs),
         tukey = letters) %>%
  mutate(variable = mivariable)

aux_name <- paste0('df_tuk_', mivariable)
assign(aux_name, df_letter)

# Get table 
mymult <- as.data.frame(table_glht(tuk))
pander(mymult, round=4,caption = "Post hoc comparison (Tukey, alpha = 0.05)", missing = '', 
       emphasize.strong.cells = 
               which(mymult < 0.05 & mymult == mymult[,4], arr.ind = T))
```

<table style="width:94%;">
<caption>Post hoc comparison (Tukey, alpha = 0.05)</caption>
<colgroup>
<col width="33%" />
<col width="15%" />
<col width="18%" />
<col width="13%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center"> </th>
<th align="center">Estimate</th>
<th align="center">Std. Error</th>
<th align="center">t value</th>
<th align="center">Pr(&gt;|t|)</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>CA_Low - CA_High</strong></td>
<td align="center">-146.1</td>
<td align="center">6.476</td>
<td align="center">-22.56</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="even">
<td align="center"><strong>SJ_High - CA_High</strong></td>
<td align="center">-413.7</td>
<td align="center">7.24</td>
<td align="center">-57.14</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="odd">
<td align="center"><strong>SJ_Low - CA_High</strong></td>
<td align="center">-525</td>
<td align="center">7.24</td>
<td align="center">-72.52</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="even">
<td align="center"><strong>SJ_High - CA_Low</strong></td>
<td align="center">-267.6</td>
<td align="center">7.24</td>
<td align="center">-36.96</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="odd">
<td align="center"><strong>SJ_Low - CA_Low</strong></td>
<td align="center">-378.9</td>
<td align="center">7.24</td>
<td align="center">-52.34</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="even">
<td align="center"><strong>SJ_Low - SJ_High</strong></td>
<td align="center">-111.3</td>
<td align="center">7.931</td>
<td align="center">-14.04</td>
<td align="center"><strong>0</strong></td>
</tr>
</tbody>
</table>

### Slope

``` r
mivariable <- 'slope'

# Model 
myformula <- as.formula(paste0(mivariable, " ~ site"))
mymodel <- aov(myformula, data=topo)

auxdf %>% 
  dplyr::filter(variable==mivariable) %>% 
  pander(round=4, caption=paste0('Mean values (', mivariable,')'))
```

<table style="width:64%;">
<caption>Mean values (slope)</caption>
<colgroup>
<col width="11%" />
<col width="12%" />
<col width="12%" />
<col width="13%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">CA_High</td>
<td align="center">12.11195</td>
<td align="center">3.275225</td>
<td align="center">0.8456595</td>
<td align="center">slope</td>
</tr>
<tr class="even">
<td align="center">CA_Low</td>
<td align="center">12.85756</td>
<td align="center">2.983954</td>
<td align="center">0.7704537</td>
<td align="center">slope</td>
</tr>
<tr class="odd">
<td align="center">SJ_High</td>
<td align="center">32.27118</td>
<td align="center">1.553920</td>
<td align="center">0.4913926</td>
<td align="center">slope</td>
</tr>
<tr class="even">
<td align="center">SJ_Low</td>
<td align="center">22.37899</td>
<td align="center">3.042151</td>
<td align="center">0.9620127</td>
<td align="center">slope</td>
</tr>
</tbody>
</table>

``` r
## Summary model 
tm <- broom::tidy(mymodel)

# See http://my.ilstu.edu/~wjschne/444/ANOVA.html#(1) 
pander(tm, round=5,caption = "ANOVA table", missing = '', 
       emphasize.strong.cells = 
               which(tm < 0.1 & tm == tm$p.value, arr.ind = T))
```

<table style="width:74%;">
<caption>ANOVA table</caption>
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
<td align="center">3</td>
<td align="center">3136</td>
<td align="center">1045</td>
<td align="center">126.6</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">46</td>
<td align="center">379.9</td>
<td align="center">8.258</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

``` r
## Multiple comparison 
tuk <- glht(mymodel, linfct = mcp(site = "Tukey"))

# Convert comparisons into letters 
df_letter <- fortify(cld(tuk)) %>%
  transmute(site = as.factor(lhs),
         tukey = letters) %>%
  mutate(variable = mivariable)

aux_name <- paste0('df_tuk_', mivariable)
assign(aux_name, df_letter)

# Get table 
mymult <- as.data.frame(table_glht(tuk))
a <- pander(mymult, round=4,caption = "Post hoc comparison (Tukey, alpha = 0.05)", missing = '', 
       emphasize.strong.cells = 
               which(mymult < 0.05 & mymult == mymult[,4], arr.ind = T))
```

Competition data
================

-   Read data

-   Create a custom function to compare between sites (aov & post hoc)

-   Export data into text files (see `/out/anovas_competition/`)

Distance-Independet Indices
---------------------------

### Basal Area

<table style="width:79%;">
<caption>Mean values (ba)</caption>
<colgroup>
<col width="11%" />
<col width="13%" />
<col width="13%" />
<col width="15%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">CA_High</td>
<td align="center">1.2293916</td>
<td align="center">0.7636880</td>
<td align="center">0.19718340</td>
<td align="center">b</td>
<td align="center">ba</td>
</tr>
<tr class="even">
<td align="center">CA_Low</td>
<td align="center">0.5661200</td>
<td align="center">0.2234657</td>
<td align="center">0.05769860</td>
<td align="center">a</td>
<td align="center">ba</td>
</tr>
<tr class="odd">
<td align="center">SJ_High</td>
<td align="center">0.4510437</td>
<td align="center">0.1808913</td>
<td align="center">0.05720286</td>
<td align="center">a</td>
<td align="center">ba</td>
</tr>
<tr class="even">
<td align="center">SJ_Low</td>
<td align="center">0.2804943</td>
<td align="center">0.1156196</td>
<td align="center">0.03656213</td>
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
<td align="center">3</td>
<td align="center">6.841</td>
<td align="center">2.28</td>
<td align="center">11.3</td>
<td align="center"><strong>1e-05</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">46</td>
<td align="center">9.279</td>
<td align="center">0.2017</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Stand Density

``` r
mivariable <- 'std'
s <- get(paste0('aov_', mivariable))

s$summ_comparison %>% 
  pander(round=4, caption=paste0('Mean values (', mivariable,')'))
```

<table style="width:74%;">
<caption>Mean values (std)</caption>
<colgroup>
<col width="11%" />
<col width="12%" />
<col width="12%" />
<col width="12%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">CA_High</td>
<td align="center">348.0188</td>
<td align="center">147.0867</td>
<td align="center">37.97761</td>
<td align="center">a</td>
<td align="center">std</td>
</tr>
<tr class="even">
<td align="center">CA_Low</td>
<td align="center">409.5587</td>
<td align="center">225.9990</td>
<td align="center">58.35268</td>
<td align="center">a</td>
<td align="center">std</td>
</tr>
<tr class="odd">
<td align="center">SJ_High</td>
<td align="center">404.2536</td>
<td align="center">119.1479</td>
<td align="center">37.67788</td>
<td align="center">a</td>
<td align="center">std</td>
</tr>
<tr class="even">
<td align="center">SJ_Low</td>
<td align="center">273.7465</td>
<td align="center">110.4698</td>
<td align="center">34.93361</td>
<td align="center">a</td>
<td align="center">std</td>
</tr>
</tbody>
</table>

``` r
tm <- s$tm

pander(tm, round=5,
       caption=paste0('ANOVA table (', mivariable,')'), 
       missing = '', emphasize.strong.cells = 
               which(tm < 0.1 & tm == tm$p.value, arr.ind = T))
```

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
<td align="center">3</td>
<td align="center">132562</td>
<td align="center">44187</td>
<td align="center">1.619</td>
<td align="center">0.1979</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">46</td>
<td align="center">1255538</td>
<td align="center">27294</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Plot Density

``` r
mivariable <- 'pd'
s <- get(paste0('aov_', mivariable))

s$summ_comparison %>% 
  pander(round=4, caption=paste0('Mean values (', mivariable,')'))
```

<table style="width:83%;">
<caption>Mean values (pd)</caption>
<colgroup>
<col width="11%" />
<col width="15%" />
<col width="15%" />
<col width="16%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">CA_High</td>
<td align="center">0.03480188</td>
<td align="center">0.01470867</td>
<td align="center">0.003797761</td>
<td align="center">a</td>
<td align="center">pd</td>
</tr>
<tr class="even">
<td align="center">CA_Low</td>
<td align="center">0.04095587</td>
<td align="center">0.02259990</td>
<td align="center">0.005835268</td>
<td align="center">a</td>
<td align="center">pd</td>
</tr>
<tr class="odd">
<td align="center">SJ_High</td>
<td align="center">0.04042536</td>
<td align="center">0.01191479</td>
<td align="center">0.003767788</td>
<td align="center">a</td>
<td align="center">pd</td>
</tr>
<tr class="even">
<td align="center">SJ_Low</td>
<td align="center">0.02737465</td>
<td align="center">0.01104698</td>
<td align="center">0.003493361</td>
<td align="center">a</td>
<td align="center">pd</td>
</tr>
</tbody>
</table>

``` r
tm <- s$tm

pander(tm, round=5,
       caption=paste0('ANOVA table (', mivariable,')'), 
       missing = '', emphasize.strong.cells = 
               which(tm < 0.1 & tm == tm$p.value, arr.ind = T))
```

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
<td align="center">3</td>
<td align="center">0.00133</td>
<td align="center">0.00044</td>
<td align="center">1.619</td>
<td align="center">0.1979</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">46</td>
<td align="center">0.01256</td>
<td align="center">0.00027</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Number of competitors within *r* meters (10 m)

``` r
mivariable <- 'n_competitors'
s <- get(paste0('aov_', mivariable))

s$summ_comparison %>% 
  pander(round=4, caption=paste0('Mean values (', mivariable,')'))
```

<table style="width:78%;">
<caption>Mean values (n_competitors)</caption>
<colgroup>
<col width="11%" />
<col width="12%" />
<col width="12%" />
<col width="12%" />
<col width="11%" />
<col width="18%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">CA_High</td>
<td align="center">10.93333</td>
<td align="center">4.620864</td>
<td align="center">1.193102</td>
<td align="center">a</td>
<td align="center">n_competitors</td>
</tr>
<tr class="even">
<td align="center">CA_Low</td>
<td align="center">12.86667</td>
<td align="center">7.099966</td>
<td align="center">1.833203</td>
<td align="center">a</td>
<td align="center">n_competitors</td>
</tr>
<tr class="odd">
<td align="center">SJ_High</td>
<td align="center">12.70000</td>
<td align="center">3.743142</td>
<td align="center">1.183685</td>
<td align="center">a</td>
<td align="center">n_competitors</td>
</tr>
<tr class="even">
<td align="center">SJ_Low</td>
<td align="center">8.60000</td>
<td align="center">3.470511</td>
<td align="center">1.097472</td>
<td align="center">a</td>
<td align="center">n_competitors</td>
</tr>
</tbody>
</table>

``` r
tm <- s$tm

pander(tm, round=5,
       caption=paste0('ANOVA table (', mivariable,')'), 
       missing = '', emphasize.strong.cells = 
               which(tm < 0.1 & tm == tm$p.value, arr.ind = T))
```

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
<td align="center">3</td>
<td align="center">130.8</td>
<td align="center">43.61</td>
<td align="center">1.619</td>
<td align="center">0.1979</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">46</td>
<td align="center">1239</td>
<td align="center">26.94</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Number of competitors within *r* meters (10 m) such that $ dbh\_j &gt; dbh\_i $

``` r
mivariable <- 'n_competitors_higher'
s <- get(paste0('aov_', mivariable))

s$summ_comparison %>% 
  pander(round=4, caption=paste0('Mean values (', mivariable,')'))
```

<table style="width:92%;">
<caption>Mean values (n_competitors_higher)</caption>
<colgroup>
<col width="11%" />
<col width="13%" />
<col width="13%" />
<col width="13%" />
<col width="11%" />
<col width="27%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">CA_High</td>
<td align="center">1.2000000</td>
<td align="center">1.4735768</td>
<td align="center">0.3804759</td>
<td align="center">a</td>
<td align="center">n_competitors_higher</td>
</tr>
<tr class="even">
<td align="center">CA_Low</td>
<td align="center">0.6666667</td>
<td align="center">0.8164966</td>
<td align="center">0.2108185</td>
<td align="center">a</td>
<td align="center">n_competitors_higher</td>
</tr>
<tr class="odd">
<td align="center">SJ_High</td>
<td align="center">0.5000000</td>
<td align="center">0.7071068</td>
<td align="center">0.2236068</td>
<td align="center">a</td>
<td align="center">n_competitors_higher</td>
</tr>
<tr class="even">
<td align="center">SJ_Low</td>
<td align="center">0.5000000</td>
<td align="center">0.7071068</td>
<td align="center">0.2236068</td>
<td align="center">a</td>
<td align="center">n_competitors_higher</td>
</tr>
</tbody>
</table>

``` r
tm <- s$tm

pander(tm, round=5,
       caption=paste0('ANOVA table (', mivariable,')'), 
       missing = '', emphasize.strong.cells = 
               which(tm < 0.1 & tm == tm$p.value, arr.ind = T))
```

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
<td align="center">3</td>
<td align="center">4.387</td>
<td align="center">1.462</td>
<td align="center">1.38</td>
<td align="center">0.2607</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">46</td>
<td align="center">48.73</td>
<td align="center">1.059</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Sum of size of trees within *r* meters (10 m)

``` r
mivariable <- 'sum_sizes'
s <- get(paste0('aov_', mivariable))

s$summ_comparison %>% 
  pander(round=4, caption=paste0('Mean values (', mivariable,')'))
```

<table style="width:76%;">
<caption>Mean values (sum_sizes)</caption>
<colgroup>
<col width="11%" />
<col width="12%" />
<col width="13%" />
<col width="13%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">CA_High</td>
<td align="center">3.374255</td>
<td align="center">1.4444380</td>
<td align="center">0.3729523</td>
<td align="center">b</td>
<td align="center">sum_sizes</td>
</tr>
<tr class="even">
<td align="center">CA_Low</td>
<td align="center">2.549089</td>
<td align="center">1.0733727</td>
<td align="center">0.2771437</td>
<td align="center">ab</td>
<td align="center">sum_sizes</td>
</tr>
<tr class="odd">
<td align="center">SJ_High</td>
<td align="center">2.524675</td>
<td align="center">0.8782956</td>
<td align="center">0.2777415</td>
<td align="center">ab</td>
<td align="center">sum_sizes</td>
</tr>
<tr class="even">
<td align="center">SJ_Low</td>
<td align="center">1.629428</td>
<td align="center">0.6046458</td>
<td align="center">0.1912058</td>
<td align="center">a</td>
<td align="center">sum_sizes</td>
</tr>
</tbody>
</table>

``` r
tm <- s$tm

pander(tm, round=5,
       caption=paste0('ANOVA table (', mivariable,')'), 
       missing = '', emphasize.strong.cells = 
               which(tm < 0.1 & tm == tm$p.value, arr.ind = T))
```

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
<td align="center">3</td>
<td align="center">18.5</td>
<td align="center">6.168</td>
<td align="center">5.106</td>
<td align="center"><strong>0.00392</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">46</td>
<td align="center">55.57</td>
<td align="center">1.208</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

Size ratio
----------

``` r
mivariable <- 'sr'
s <- get(paste0('aov_', mivariable))

s$summ_comparison %>% 
  pander(round=4, caption=paste0('Mean values (', mivariable,')'))
```

<table style="width:82%;">
<caption>Mean values (sr)</caption>
<colgroup>
<col width="11%" />
<col width="13%" />
<col width="15%" />
<col width="16%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">CA_High</td>
<td align="center">0.2153327</td>
<td align="center">0.19568030</td>
<td align="center">0.050524437</td>
<td align="center">a</td>
<td align="center">sr</td>
</tr>
<tr class="even">
<td align="center">CA_Low</td>
<td align="center">0.1705044</td>
<td align="center">0.06824190</td>
<td align="center">0.017619982</td>
<td align="center">a</td>
<td align="center">sr</td>
</tr>
<tr class="odd">
<td align="center">SJ_High</td>
<td align="center">0.1184228</td>
<td align="center">0.02789219</td>
<td align="center">0.008820286</td>
<td align="center">a</td>
<td align="center">sr</td>
</tr>
<tr class="even">
<td align="center">SJ_Low</td>
<td align="center">0.1840603</td>
<td align="center">0.07446098</td>
<td align="center">0.023546628</td>
<td align="center">a</td>
<td align="center">sr</td>
</tr>
</tbody>
</table>

``` r
tm <- s$tm

pander(tm, round=5,
       caption=paste0('ANOVA table (', mivariable,')'), 
       missing = '', emphasize.strong.cells = 
               which(tm < 0.1 & tm == tm$p.value, arr.ind = T))
```

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
<td align="center">3</td>
<td align="center">0.05746</td>
<td align="center">0.01915</td>
<td align="center">1.339</td>
<td align="center">0.2735</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">46</td>
<td align="center">0.6582</td>
<td align="center">0.01431</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

Distance-Dependet Indices
-------------------------

### Distance to nearest tree

``` r
mivariable <- 'dnn'
s <- get(paste0('aov_', mivariable))

s$summ_comparison %>% 
  pander(round=4, caption=paste0('Mean values (', mivariable,')'))
```

<table style="width:75%;">
<caption>Mean values (dnn)</caption>
<colgroup>
<col width="11%" />
<col width="12%" />
<col width="12%" />
<col width="13%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">CA_High</td>
<td align="center">3.412000</td>
<td align="center">1.859444</td>
<td align="center">0.4801063</td>
<td align="center">a</td>
<td align="center">dnn</td>
</tr>
<tr class="even">
<td align="center">CA_Low</td>
<td align="center">3.122667</td>
<td align="center">1.307792</td>
<td align="center">0.3376705</td>
<td align="center">a</td>
<td align="center">dnn</td>
</tr>
<tr class="odd">
<td align="center">SJ_High</td>
<td align="center">2.285000</td>
<td align="center">1.467971</td>
<td align="center">0.4642132</td>
<td align="center">a</td>
<td align="center">dnn</td>
</tr>
<tr class="even">
<td align="center">SJ_Low</td>
<td align="center">2.514000</td>
<td align="center">1.240100</td>
<td align="center">0.3921542</td>
<td align="center">a</td>
<td align="center">dnn</td>
</tr>
</tbody>
</table>

``` r
tm <- s$tm

pander(tm, round=5,
       caption=paste0('ANOVA table (', mivariable,')'), 
       missing = '', emphasize.strong.cells = 
               which(tm < 0.1 & tm == tm$p.value, arr.ind = T))
```

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
<td align="center">3</td>
<td align="center">9.928</td>
<td align="center">3.309</td>
<td align="center">1.442</td>
<td align="center">0.2429</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">46</td>
<td align="center">105.6</td>
<td align="center">2.295</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Crowding

``` r
mivariable <- 'crowding'
s <- get(paste0('aov_', mivariable))

s$summ_comparison %>% 
  pander(round=4, caption=paste0('Mean values (', mivariable,')'))
```

<table style="width:79%;">
<caption>Mean values (crowding)</caption>
<colgroup>
<col width="11%" />
<col width="13%" />
<col width="13%" />
<col width="15%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">CA_High</td>
<td align="center">0.7169079</td>
<td align="center">0.4719477</td>
<td align="center">0.12185637</td>
<td align="center">b</td>
<td align="center">crowding</td>
</tr>
<tr class="even">
<td align="center">CA_Low</td>
<td align="center">0.4818314</td>
<td align="center">0.1844421</td>
<td align="center">0.04762275</td>
<td align="center">ab</td>
<td align="center">crowding</td>
</tr>
<tr class="odd">
<td align="center">SJ_High</td>
<td align="center">0.6034893</td>
<td align="center">0.2735479</td>
<td align="center">0.08650345</td>
<td align="center">ab</td>
<td align="center">crowding</td>
</tr>
<tr class="even">
<td align="center">SJ_Low</td>
<td align="center">0.3327240</td>
<td align="center">0.1362680</td>
<td align="center">0.04309171</td>
<td align="center">a</td>
<td align="center">crowding</td>
</tr>
</tbody>
</table>

``` r
tm <- s$tm

pander(tm, round=5,
       caption=paste0('ANOVA table (', mivariable,')'), 
       missing = '', emphasize.strong.cells = 
               which(tm < 0.1 & tm == tm$p.value, arr.ind = T))
```

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
<td align="center">3</td>
<td align="center">0.9878</td>
<td align="center">0.3293</td>
<td align="center">3.415</td>
<td align="center"><strong>0.02501</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">46</td>
<td align="center">4.435</td>
<td align="center">0.09642</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Lorimer

``` r
mivariable <- 'lorimer'
s <- get(paste0('aov_', mivariable))

s$summ_comparison %>% 
  pander(round=4, caption=paste0('Mean values (', mivariable,')'))
```

<table style="width:76%;">
<caption>Mean values (lorimer)</caption>
<colgroup>
<col width="11%" />
<col width="13%" />
<col width="12%" />
<col width="13%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">CA_High</td>
<td align="center">7.664087</td>
<td align="center">4.710569</td>
<td align="center">1.2162638</td>
<td align="center">a</td>
<td align="center">lorimer</td>
</tr>
<tr class="even">
<td align="center">CA_Low</td>
<td align="center">7.778860</td>
<td align="center">3.937159</td>
<td align="center">1.0165702</td>
<td align="center">a</td>
<td align="center">lorimer</td>
</tr>
<tr class="odd">
<td align="center">SJ_High</td>
<td align="center">11.528850</td>
<td align="center">3.811393</td>
<td align="center">1.2052684</td>
<td align="center">a</td>
<td align="center">lorimer</td>
</tr>
<tr class="even">
<td align="center">SJ_Low</td>
<td align="center">7.160582</td>
<td align="center">3.135968</td>
<td align="center">0.9916801</td>
<td align="center">a</td>
<td align="center">lorimer</td>
</tr>
</tbody>
</table>

``` r
tm <- s$tm

pander(tm, round=5,
       caption=paste0('ANOVA table (', mivariable,')'), 
       missing = '', emphasize.strong.cells = 
               which(tm < 0.1 & tm == tm$p.value, arr.ind = T))
```

<table style="width:78%;">
<caption>ANOVA table (lorimer)</caption>
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
<td align="center">3</td>
<td align="center">127.1</td>
<td align="center">42.38</td>
<td align="center">2.61</td>
<td align="center"><strong>0.06273</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">46</td>
<td align="center">746.9</td>
<td align="center">16.24</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Negative Exponential size ratio

``` r
mivariable <- 'nesr'
s <- get(paste0('aov_', mivariable))

s$summ_comparison %>% 
  pander(round=4, caption=paste0('Mean values (', mivariable,')'))
```

<table style="width:83%;">
<caption>Mean values (nesr)</caption>
<colgroup>
<col width="11%" />
<col width="15%" />
<col width="15%" />
<col width="16%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">CA_High</td>
<td align="center">0.05864130</td>
<td align="center">0.08498713</td>
<td align="center">0.021943582</td>
<td align="center">a</td>
<td align="center">nesr</td>
</tr>
<tr class="even">
<td align="center">CA_Low</td>
<td align="center">0.03478072</td>
<td align="center">0.03247587</td>
<td align="center">0.008385235</td>
<td align="center">a</td>
<td align="center">nesr</td>
</tr>
<tr class="odd">
<td align="center">SJ_High</td>
<td align="center">0.10784464</td>
<td align="center">0.11721176</td>
<td align="center">0.037065613</td>
<td align="center">a</td>
<td align="center">nesr</td>
</tr>
<tr class="even">
<td align="center">SJ_Low</td>
<td align="center">0.04631867</td>
<td align="center">0.05507588</td>
<td align="center">0.017416522</td>
<td align="center">a</td>
<td align="center">nesr</td>
</tr>
</tbody>
</table>

``` r
tm <- s$tm

pander(tm, round=5,
       caption=paste0('ANOVA table (', mivariable,')'), 
       missing = '', emphasize.strong.cells = 
               which(tm < 0.1 & tm == tm$p.value, arr.ind = T))
```

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
<td align="center">3</td>
<td align="center">0.03427</td>
<td align="center">0.01142</td>
<td align="center">1.969</td>
<td align="center">0.1318</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">46</td>
<td align="center">0.2668</td>
<td align="center">0.0058</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Negative Exponential Weighted size ratio

``` r
mivariable <- 'newsr'
s <- get(paste0('aov_', mivariable))

s$summ_comparison %>% 
  pander(round=4, caption=paste0('Mean values (', mivariable,')'))
```

<table style="width:79%;">
<caption>Mean values (newsr)</caption>
<colgroup>
<col width="11%" />
<col width="13%" />
<col width="13%" />
<col width="15%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">CA_High</td>
<td align="center">0.4837733</td>
<td align="center">0.6224122</td>
<td align="center">0.16070614</td>
<td align="center">a</td>
<td align="center">newsr</td>
</tr>
<tr class="even">
<td align="center">CA_Low</td>
<td align="center">0.1792381</td>
<td align="center">0.2232725</td>
<td align="center">0.05764871</td>
<td align="center">a</td>
<td align="center">newsr</td>
</tr>
<tr class="odd">
<td align="center">SJ_High</td>
<td align="center">0.6168525</td>
<td align="center">0.9008731</td>
<td align="center">0.28488108</td>
<td align="center">a</td>
<td align="center">newsr</td>
</tr>
<tr class="even">
<td align="center">SJ_Low</td>
<td align="center">0.1762010</td>
<td align="center">0.2855108</td>
<td align="center">0.09028646</td>
<td align="center">a</td>
<td align="center">newsr</td>
</tr>
</tbody>
</table>

``` r
tm <- s$tm

pander(tm, round=5,
       caption=paste0('ANOVA table (', mivariable,')'), 
       missing = '', emphasize.strong.cells = 
               which(tm < 0.1 & tm == tm$p.value, arr.ind = T))
```

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
<td align="center">3</td>
<td align="center">1.717</td>
<td align="center">0.5724</td>
<td align="center">1.86</td>
<td align="center">0.1497</td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">46</td>
<td align="center">14.16</td>
<td align="center">0.3078</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Size ratio proportional to distance

``` r
mivariable <- 'srd'
s <- get(paste0('aov_', mivariable))

s$summ_comparison %>% 
  pander(round=4, caption=paste0('Mean values (', mivariable,')'))
```

<table style="width:78%;">
<caption>Mean values (srd)</caption>
<colgroup>
<col width="11%" />
<col width="13%" />
<col width="13%" />
<col width="13%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">CA_High</td>
<td align="center">0.9084877</td>
<td align="center">0.6290275</td>
<td align="center">0.1624142</td>
<td align="center">a</td>
<td align="center">srd</td>
</tr>
<tr class="even">
<td align="center">CA_Low</td>
<td align="center">0.8896226</td>
<td align="center">0.4384576</td>
<td align="center">0.1132093</td>
<td align="center">a</td>
<td align="center">srd</td>
</tr>
<tr class="odd">
<td align="center">SJ_High</td>
<td align="center">1.3883389</td>
<td align="center">0.5049906</td>
<td align="center">0.1596921</td>
<td align="center">a</td>
<td align="center">srd</td>
</tr>
<tr class="even">
<td align="center">SJ_Low</td>
<td align="center">0.8345799</td>
<td align="center">0.3811389</td>
<td align="center">0.1205267</td>
<td align="center">a</td>
<td align="center">srd</td>
</tr>
</tbody>
</table>

``` r
tm <- s$tm

pander(tm, round=5,
       caption=paste0('ANOVA table (', mivariable,')'), 
       missing = '', emphasize.strong.cells = 
               which(tm < 0.1 & tm == tm$p.value, arr.ind = T))
```

<table style="width:78%;">
<caption>ANOVA table (srd)</caption>
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
<td align="center">3</td>
<td align="center">2.077</td>
<td align="center">0.6924</td>
<td align="center">2.692</td>
<td align="center"><strong>0.05708</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">46</td>
<td align="center">11.83</td>
<td align="center">0.2572</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

### Size difference proportional to distance

``` r
mivariable <- 'sdd'
s <- get(paste0('aov_', mivariable))

s$summ_comparison %>% 
  pander(round=4, caption=paste0('Mean values (', mivariable,')'))
```

<table style="width:81%;">
<caption>Mean values (sdd)</caption>
<colgroup>
<col width="11%" />
<col width="15%" />
<col width="13%" />
<col width="15%" />
<col width="11%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
<th align="center">tukey</th>
<th align="center">variable</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">CA_High</td>
<td align="center">-0.4931479</td>
<td align="center">0.4017918</td>
<td align="center">0.10374219</td>
<td align="center">a</td>
<td align="center">sdd</td>
</tr>
<tr class="even">
<td align="center">CA_Low</td>
<td align="center">-0.4142691</td>
<td align="center">0.2291280</td>
<td align="center">0.05916059</td>
<td align="center">ab</td>
<td align="center">sdd</td>
</tr>
<tr class="odd">
<td align="center">SJ_High</td>
<td align="center">-0.2353267</td>
<td align="center">0.1100053</td>
<td align="center">0.03478672</td>
<td align="center">ab</td>
<td align="center">sdd</td>
</tr>
<tr class="even">
<td align="center">SJ_Low</td>
<td align="center">-0.1827803</td>
<td align="center">0.0795404</td>
<td align="center">0.02515288</td>
<td align="center">b</td>
<td align="center">sdd</td>
</tr>
</tbody>
</table>

``` r
tm <- s$tm

pander(tm, round=5,
       caption=paste0('ANOVA table (', mivariable,')'), 
       missing = '', emphasize.strong.cells = 
               which(tm < 0.1 & tm == tm$p.value, arr.ind = T))
```

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
<td align="center">3</td>
<td align="center">0.7787</td>
<td align="center">0.2596</td>
<td align="center">3.778</td>
<td align="center"><strong>0.01665</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">46</td>
<td align="center">3.161</td>
<td align="center">0.06872</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>
