``` r
library("tidyverse")
library("stringr")
library("dplR")
library("knitr")
library("pander")
```

Read y Prepare data
===================

-   Leer datos `rwl` de SJ y CA

<!-- -->

    ## There does not appear to be a header in the rwl file
    ## There are 48 series
    ## 1        SNA0101      1947    2016   0.01
    ## 2        SNA0102      1947    2016   0.01
    ## 3        SNA0201      1946    2016   0.01
    ## 4        SNA0202      1948    2016   0.01
    ## 5        SNA0301      1949    2016   0.01
    ## 6        SNA0302      1948    2016   0.01
    ## 7        SNA0401      1947    2016   0.01
    ## 8        SNA0402      1947    2016   0.01
    ## 9        SNA0501      1953    2016   0.01
    ## 10       SNA0502      1948    2016   0.01
    ## 11       SNA0601      1948    2016   0.01
    ## 12       SNA0602      1957    2016   0.01
    ## 13       SNA0603      1947    2012   0.01
    ## 14       SNA0701      1954    2016   0.01
    ## 15       SNA0702      1947    2016   0.01
    ## 16       SNA0801      1949    2016   0.01
    ## 17       SNA0802      1951    2016   0.01
    ## 18       SNA0901      1947    2016   0.01
    ## 19       SNA0902      1947    2016   0.01
    ## 20       SNA0903      1947    2002   0.01
    ## 21       SNA1001      1950    2016   0.01
    ## 22       SNA1002      1953    2016   0.01
    ## 23       SNA1003      1948    2008   0.01
    ## 24       SNA1101      1940    2016   0.01
    ## 25       SNA1102      1929    2016   0.01
    ## 26       SNA1103      1942    1994   0.01
    ## 27       SNA1201      1929    2016   0.01
    ## 28       SNA1202      1929    2016   0.01
    ## 29       SNA1203      1927    1983   0.01
    ## 30       SNA1301      1960    2016   0.01
    ## 31       SNA1302      1949    2016   0.01
    ## 32       SNA1303      1949    2011   0.01
    ## 33       SNA1401      1930    2016   0.01
    ## 34       SNA1402      1949    2016   0.01
    ## 35       SNA1501      1952    2016   0.01
    ## 36       SNA1502      1948    2016   0.01
    ## 37       SNA1601      1959    2016   0.01
    ## 38       SNA1602      1927    2016   0.01
    ## 39       SNA1701      1926    2016   0.01
    ## 40       SNA1702      1930    2016   0.01
    ## 41       SNA1703      1931    2016   0.01
    ## 42       SNA1801      1937    2016   0.01
    ## 43       SNA1802      1936    2016   0.01
    ## 44       SNA1901      1921    2016   0.01
    ## 45       SNA1902      1924    2016   0.01
    ## 46       SNA2001      1932    2016   0.01
    ## 47       SNA2003      1932    2016   0.01
    ## 48       SNA2002      1934    2016   0.01

    ## There does not appear to be a header in the rwl file
    ## There are 60 series
    ## 1        SNB0101      1899    2016   0.01
    ## 2        SNB0102      1902    2016   0.01
    ## 3        SNB0201      1916    2016   0.01
    ## 4        SNB0202      1876    2016   0.01
    ## 5        SNB0301      1862    2016   0.01
    ## 6        SNB0302      1862    2016   0.01
    ## 7        SNB0401      1870    2016   0.01
    ## 8        SNB0402      1866    2016   0.01
    ## 9        SNB0501      1864    2016   0.01
    ## 10       SNB0502g     1867    2016   0.01
    ## 11       SNB0601      1860    2016   0.01
    ## 12       SNB0602      1873    2016   0.01
    ## 13       SNB0701      1851    2016   0.01
    ## 14       SNB0702g     1861    2016   0.01
    ## 15       SNB0801g     1851    2016   0.01
    ## 16       SNB0802g     1853    2016   0.01
    ## 17       SNB0901g     1836    2016   0.01
    ## 18       SNB0902      1844    2016   0.01
    ## 19       SNB1001      1868    2016   0.01
    ## 20       SNB1002      1870    2016   0.01
    ## 21       SNB1101      1949    2016   0.01
    ## 22       SNB1102      1893    2016   0.01
    ## 23       SNB1201      1867    2016   0.01
    ## 24       SNB1202      1834    2016   0.01
    ## 25       SNB1301      1865    2016   0.01
    ## 26       SNB1302      1874    2016   0.01
    ## 27       SNB1401      1843    2016   0.01
    ## 28       SNB1402      1848    2016   0.01
    ## 29       SNB1501      1898    2016   0.01
    ## 30       SNB1502      1927    2016   0.01
    ## 31       SNB1601      1846    2016   0.01
    ## 32       SNB1602      1857    2016   0.01
    ## 33       SNB1701      1856    2016   0.01
    ## 34       SNB1702      1853    2016   0.01
    ## 35       SNB1801      1827    2016   0.01
    ## 36       SNB1802      1843    2016   0.01
    ## 37       SNB1901      1888    2016   0.01
    ## 38       SNB1902      1901    2016   0.01
    ## 39       SNB2001      1830    2016   0.01
    ## 40       SNB2002g     1837    2016   0.01
    ## 41       SNB2101      1863    2016   0.01
    ## 42       SNB2102      1858    2016   0.01
    ## 43       SNB2201g     1819    2016   0.01
    ## 44       SNB2202g     1822    2016   0.01
    ## 45       SNB2301g     1832    2016   0.01
    ## 46       SNB2302      1819    2016   0.01
    ## 47       SNB2401      1829    2016   0.01
    ## 48       SNB2402      1831    2016   0.01
    ## 49       SNB2501      1831    2016   0.01
    ## 50       SNB2502      1839    2016   0.01
    ## 51       SNB2601      1872    2016   0.01
    ## 52       SNB2602      1867    2016   0.01
    ## 53       SNB2701      1865    2016   0.01
    ## 54       SNB2702g     1863    2016   0.01
    ## 55       SNB2801      1860    2016   0.01
    ## 56       SNB2802      1866    2016   0.01
    ## 57       SNB2901      1877    2016   0.01
    ## 58       SNB2902      1892    2016   0.01
    ## 59       SNB3001      1867    2016   0.01
    ## 60       SNB3002      1874    2016   0.01

Computar RWI para tres sitios CA\_High, CA\_Low, SJ.

Preparar datos para computar RWI
================================

``` r
source(paste0(di, 'script/R/computeSpline.R'))
source(paste0(di, 'script/R/rw_byTree.R'))
```

``` r
# Replace SNA by SJ and SNB by CA
names(ca) <- stringr::str_replace(names(ca), "SNB", "CA") 
names(sj) <- stringr::str_replace(names(sj), "SNA", "SJ")

# Remove g in name of some cores of CA. 
names(ca) <- stringr::str_replace(names(ca), "g", "")
```

-   Crear dataframes `rwl` por cada sitio CA\_High, CA\_Low, SJ

``` r
# Create subset to compare between sites 
caL <- ca[,c("CA0101","CA0102","CA0201","CA0202","CA0301","CA0302","CA0401","CA0402","CA0501","CA0502",
             "CA0601","CA0602","CA0701","CA0702","CA0801","CA0802","CA0901","CA0902","CA1001","CA1002",
             "CA2601","CA2602","CA2701","CA2702","CA2801","CA2802","CA2901","CA2902","CA3001","CA3002")] 
caH <- ca[, c("CA1101","CA1102","CA1201","CA1202","CA1301","CA1302","CA1401","CA1402","CA1501","CA1502",
              "CA1601","CA1602","CA1701","CA1702","CA1801","CA1802","CA1901","CA1902","CA2001","CA2002",
              "CA2101","CA2102","CA2201","CA2202","CA2301","CA2302","CA2401","CA2402","CA2501","CA2502")]

# remove the rows with NA across all columns 
caL <- caL[rowSums(is.na(caL))!=ncol(caL), ]
```

### Summary Dendro

-   Summary stats of RWL

``` r
rwl_stat_sj <- rwl.stats(sj)
rwl_stat_caH <- rwl.stats(caH)
rwl_stat_caL <- rwl.stats(caL)

rwl_stat_sites <- rbind(rwl_stat_sj, rwl_stat_caH, rwl_stat_caL) %>% 
  mutate(
  site = as.factor(case_when(
    series %in% names(sj) ~ "sj", 
    series %in% names(caH) ~ "caH", 
    series %in% names(caL) ~ "caL")),
  tree = as.numeric(substr(series, 3, 4)),
  radi = as.numeric(substr(series, 5, 6))
  )

# average age 
age_sites <- rwl_stat_sites %>% 
  group_by(site) %>% 
  dplyr::summarise(age_mean = mean(year), 
         age_std = sd(year)) %>% as.data.frame()

pander(age_sites) 
```

<table style="width:40%;">
<colgroup>
<col width="9%" />
<col width="15%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">age_mean</th>
<th align="center">age_std</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">161</td>
<td align="center">32.2</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">148.5</td>
<td align="center">16.54</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">72.56</td>
<td align="center">11.14</td>
</tr>
</tbody>
</table>

``` r
write.csv(age_sites, file=paste(di, "data/dendro_summary/site3_avg_ages.csv", sep=""), row.names = FALSE)


rwl_sites_summ <- rwl_stat_sites %>% 
  group_by(site) %>% 
  dplyr::summarise(n_trees = length(unique(tree)),
                   n_radii =n(), 
                   year_first = min(first), 
                   year_last = max(last), 
                   year_length = max(year),
                   rw_mean = mean(mean), 
                   rw_std = mean(stdev),
                   sens1 = mean(sens1), 
                   sens2 = mean(sens2), 
                   ar1 = mean(ar1)) %>% 
  as.data.frame()

pander(rwl_sites_summ)
```

<table>
<caption>Table continues below</caption>
<colgroup>
<col width="9%" />
<col width="13%" />
<col width="13%" />
<col width="17%" />
<col width="16%" />
<col width="18%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">n_trees</th>
<th align="center">n_radii</th>
<th align="center">year_first</th>
<th align="center">year_last</th>
<th align="center">year_length</th>
<th align="center">rw_mean</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">15</td>
<td align="center">30</td>
<td align="center">1819</td>
<td align="center">2016</td>
<td align="center">198</td>
<td align="center">1.5</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">15</td>
<td align="center">30</td>
<td align="center">1836</td>
<td align="center">2016</td>
<td align="center">181</td>
<td align="center">1.253</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">20</td>
<td align="center">48</td>
<td align="center">1921</td>
<td align="center">2016</td>
<td align="center">96</td>
<td align="center">1.725</td>
</tr>
</tbody>
</table>

<table style="width:46%;">
<colgroup>
<col width="12%" />
<col width="11%" />
<col width="11%" />
<col width="11%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">rw_std</th>
<th align="center">sens1</th>
<th align="center">sens2</th>
<th align="center">ar1</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">0.8794</td>
<td align="center">0.2068</td>
<td align="center">0.2033</td>
<td align="center">0.8271</td>
</tr>
<tr class="even">
<td align="center">0.7813</td>
<td align="center">0.2087</td>
<td align="center">0.2084</td>
<td align="center">0.7987</td>
</tr>
<tr class="odd">
<td align="center">1.207</td>
<td align="center">0.3183</td>
<td align="center">0.3193</td>
<td align="center">0.6919</td>
</tr>
</tbody>
</table>

-   sample deepth

``` r
# sample depth 
sampleDepth <- function(x, site){ 
  x$samps <- rowSums(!is.na(x))
  x$year <- row.names(x)
  x$site <- site
  out <- x[,c("samps", "year", "site")]
  return(out)
} 

d_sj <- sampleDepth(sj, site='sj')
d_caL <- sampleDepth(caL, site='caL')
d_caH <- sampleDepth(caH, site='caH')

d_sites <- rbind(d_sj, d_caH, d_caL)


d <- d_sites %>% 
  filter(samps >= 5) %>% 
  group_by(site) %>% 
  slice(which.min(year)) %>% 
  mutate(
    year = as.numeric(year),
    length_year = (2016 - year + 1)) %>%  
  as.data.frame() 
 
pander(d) 
```

<table style="width:49%;">
<colgroup>
<col width="11%" />
<col width="9%" />
<col width="9%" />
<col width="18%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">samps</th>
<th align="center">year</th>
<th align="center">site</th>
<th align="center">length_year</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">5</td>
<td align="center">1829</td>
<td align="center">caH</td>
<td align="center">188</td>
</tr>
<tr class="even">
<td align="center">5</td>
<td align="center">1853</td>
<td align="center">caL</td>
<td align="center">164</td>
</tr>
<tr class="odd">
<td align="center">5</td>
<td align="center">1927</td>
<td align="center">sj</td>
<td align="center">90</td>
</tr>
</tbody>
</table>

-   Combining tables

``` r
df <- d %>% 
  dplyr::select(-samps, -year) %>% 
  rename(year_length5 = length_year) %>% 
  left_join(rwl_sites_summ, by='site') %>% 
  dplyr::select(
    site, n_trees, n_radii, 
    first_year = year_first, last_year = year_last, 
    length_year = year_length, length_year5 = year_length5, 
    rw_mean, rw_std, ms2 = sens2, ar1)

pander(df)
```

<table>
<caption>Table continues below</caption>
<colgroup>
<col width="8%" />
<col width="12%" />
<col width="12%" />
<col width="16%" />
<col width="15%" />
<col width="17%" />
<col width="17%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">n_trees</th>
<th align="center">n_radii</th>
<th align="center">first_year</th>
<th align="center">last_year</th>
<th align="center">length_year</th>
<th align="center">length_year5</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caH</td>
<td align="center">15</td>
<td align="center">30</td>
<td align="center">1819</td>
<td align="center">2016</td>
<td align="center">198</td>
<td align="center">188</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">15</td>
<td align="center">30</td>
<td align="center">1836</td>
<td align="center">2016</td>
<td align="center">181</td>
<td align="center">164</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">20</td>
<td align="center">48</td>
<td align="center">1921</td>
<td align="center">2016</td>
<td align="center">96</td>
<td align="center">90</td>
</tr>
</tbody>
</table>

<table style="width:46%;">
<colgroup>
<col width="13%" />
<col width="12%" />
<col width="9%" />
<col width="9%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">rw_mean</th>
<th align="center">rw_std</th>
<th align="center">ms2</th>
<th align="center">ar1</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">1.5</td>
<td align="center">0.8794</td>
<td align="center">0.2033</td>
<td align="center">0.8271</td>
</tr>
<tr class="even">
<td align="center">1.253</td>
<td align="center">0.7813</td>
<td align="center">0.2084</td>
<td align="center">0.7987</td>
</tr>
<tr class="odd">
<td align="center">1.725</td>
<td align="center">1.207</td>
<td align="center">0.3193</td>
<td align="center">0.6919</td>
</tr>
</tbody>
</table>

-   Summary stats of Residual chronos

``` r
rwi_stats <- read.csv(file=paste(di, "data/dendro_summary/site3_dendro_rwi.csv", sep=""),  header=TRUE, sep=',')
```

Dendro table
============

``` r
dendro_summary <- rwi_stats %>% 
  dplyr::select(rbar.wt, eps, site) %>% 
  inner_join(df, by='site') %>% 
  dplyr::select(site:ar1, rbar.wt, eps)

write.csv(dendro_summary, file=paste(di, "data/dendro_summary/site3_dendro_summary.csv", sep=""), row.names = FALSE)

pander(dendro_summary, caption='Dendrochronological summary by sites') 
```

<table>
<caption>Dendrochronological summary by sites (continued below)</caption>
<colgroup>
<col width="8%" />
<col width="12%" />
<col width="12%" />
<col width="16%" />
<col width="15%" />
<col width="17%" />
<col width="17%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">n_trees</th>
<th align="center">n_radii</th>
<th align="center">first_year</th>
<th align="center">last_year</th>
<th align="center">length_year</th>
<th align="center">length_year5</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">caL</td>
<td align="center">15</td>
<td align="center">30</td>
<td align="center">1836</td>
<td align="center">2016</td>
<td align="center">181</td>
<td align="center">164</td>
</tr>
<tr class="even">
<td align="center">caH</td>
<td align="center">15</td>
<td align="center">30</td>
<td align="center">1819</td>
<td align="center">2016</td>
<td align="center">198</td>
<td align="center">188</td>
</tr>
<tr class="odd">
<td align="center">sj</td>
<td align="center">20</td>
<td align="center">48</td>
<td align="center">1921</td>
<td align="center">2016</td>
<td align="center">96</td>
<td align="center">90</td>
</tr>
</tbody>
</table>

<table style="width:67%;">
<colgroup>
<col width="13%" />
<col width="12%" />
<col width="9%" />
<col width="9%" />
<col width="13%" />
<col width="6%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">rw_mean</th>
<th align="center">rw_std</th>
<th align="center">ms2</th>
<th align="center">ar1</th>
<th align="center">rbar.wt</th>
<th align="center">eps</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">1.253</td>
<td align="center">0.7813</td>
<td align="center">0.2084</td>
<td align="center">0.7987</td>
<td align="center">0.563</td>
<td align="center">0.897</td>
</tr>
<tr class="even">
<td align="center">1.5</td>
<td align="center">0.8794</td>
<td align="center">0.2033</td>
<td align="center">0.8271</td>
<td align="center">0.513</td>
<td align="center">0.907</td>
</tr>
<tr class="odd">
<td align="center">1.725</td>
<td align="center">1.207</td>
<td align="center">0.3193</td>
<td align="center">0.6919</td>
<td align="center">0.797</td>
<td align="center">0.959</td>
</tr>
</tbody>
</table>
