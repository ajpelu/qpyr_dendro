``` r
library("tidyverse")
library("pander")
```

Read data from EVI
==================

``` r
# Estos datos vienen del repo de modis_resilience (/analysis/explore_Resilience.Rmd)
mhuber_evi <- read.csv(file=paste0(di, '/out/anovas_resilience/huber_evi/robust_mhuber.csv'), header = TRUE, sep=",")
mhuber_eviA <- read.csv(file=paste0(di, '/out/anovas_resilience/huber_evi/robust_mhuber_a.csv'), header = TRUE, sep=",")
mhuber_eviB <- read.csv(file=paste0(di, '/out/anovas_resilience/huber_evi/robust_mhuber_b.csv'), header = TRUE, sep=",")
```

``` r
# Estos datos vienen del repo de modis_resilience (/analysis/explore_Resilience.Rmd)
mhuber_bai <- read.csv(file=paste0(di, '/out/anovas_resilience/robust_mhuber.csv'), header = TRUE, sep=",")
mhuber_baiA <- read.csv(file=paste0(di, '/out/anovas_resilience/robust_mhuber_a.csv'), header = TRUE, sep=",")
mhuber_baiB <- read.csv(file=paste0(di, '/out/anovas_resilience/robust_mhuber_b.csv'), header = TRUE, sep=",")
```

### Tablas Disturb year

``` r
evi_a <- mhuber_eviA %>% 
  mutate(M.Huber = round(M.Huber, 4),
         lower.ci = round(lower.ci, 4),
         upper.ci = round(upper.ci, 4)) %>% 
  unite("ci", c("lower.ci", "upper.ci"), sep=", ") %>% 
  mutate(ci = paste0('(', ci, ')')) %>% 
  unite("value_EVI", c("M.Huber", "ci"), sep= " ") %>%
  dplyr::select(-MonoLetter, -n) %>% 
  dplyr::select(var, disturb_year, value_EVI, letter_EVI=Letter) %>% as.data.frame() 

evi_a %>% pander() 
```

<table style="width:79%;">
<colgroup>
<col width="8%" />
<col width="20%" />
<col width="33%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">var</th>
<th align="center">disturb_year</th>
<th align="center">value_EVI</th>
<th align="center">letter_EVI</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">rc</td>
<td align="center">2005</td>
<td align="center">1.1197 (1.1131, 1.1262)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rc</td>
<td align="center">2012</td>
<td align="center">1.0571 (1.0537, 1.0604)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">rt</td>
<td align="center">2005</td>
<td align="center">0.8584 (0.8535, 0.8633)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rt</td>
<td align="center">2012</td>
<td align="center">0.9431 (0.9396, 0.9466)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">rs</td>
<td align="center">2005</td>
<td align="center">0.9585 (0.9553, 0.9617)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rs</td>
<td align="center">2012</td>
<td align="center">0.9947 (0.9913, 0.998)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">rrs</td>
<td align="center">2005</td>
<td align="center">0.0999 (0.0948, 0.1051)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rrs</td>
<td align="center">2012</td>
<td align="center">0.0533 (0.0502, 0.0563)</td>
<td align="center">b</td>
</tr>
</tbody>
</table>

``` r
bai_a <- mhuber_baiA %>% 
  mutate(M.Huber = round(M.Huber, 4),
         lower.ci = round(lower.ci, 4),
         upper.ci = round(upper.ci, 4)) %>% 
  unite("ci", c("lower.ci", "upper.ci"), sep=", ") %>% 
  mutate(ci = paste0('(', ci, ')')) %>% 
  unite("value_BAI", c("M.Huber", "ci"), sep= " ") %>%
  dplyr::select(-MonoLetter, -n) %>% 
  dplyr::select(var, disturb_year, value_BAI, letter_BAI=Letter) %>% as.data.frame() 

bai_a %>% pander() 
```

<table style="width:83%;">
<colgroup>
<col width="8%" />
<col width="20%" />
<col width="37%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">var</th>
<th align="center">disturb_year</th>
<th align="center">value_BAI</th>
<th align="center">letter_BAI</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">rc</td>
<td align="center">2005</td>
<td align="center">0.9462 (0.8794, 1.0129)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rc</td>
<td align="center">2012</td>
<td align="center">1.1608 (1.0813, 1.2403)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">rt</td>
<td align="center">2005</td>
<td align="center">0.721 (0.6437, 0.7984)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rt</td>
<td align="center">2012</td>
<td align="center">0.8193 (0.7758, 0.8628)</td>
<td align="center">a</td>
</tr>
<tr class="odd">
<td align="center">rs</td>
<td align="center">2005</td>
<td align="center">0.653 (0.5852, 0.7209)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rs</td>
<td align="center">2012</td>
<td align="center">0.9107 (0.8648, 0.9567)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">rrs</td>
<td align="center">2005</td>
<td align="center">-0.0559 (-0.0993, -0.0126)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rrs</td>
<td align="center">2012</td>
<td align="center">0.1223 (0.0596, 0.185)</td>
<td align="center">b</td>
</tr>
</tbody>
</table>

``` r
mhuberA <- evi_a %>% inner_join(bai_a, by=c("var", "disturb_year"))

mhuberA %>% pander() 
```

<table style="width:79%;">
<caption>Table continues below</caption>
<colgroup>
<col width="8%" />
<col width="20%" />
<col width="33%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">var</th>
<th align="center">disturb_year</th>
<th align="center">value_EVI</th>
<th align="center">letter_EVI</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">rc</td>
<td align="center">2005</td>
<td align="center">1.1197 (1.1131, 1.1262)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rc</td>
<td align="center">2012</td>
<td align="center">1.0571 (1.0537, 1.0604)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">rt</td>
<td align="center">2005</td>
<td align="center">0.8584 (0.8535, 0.8633)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rt</td>
<td align="center">2012</td>
<td align="center">0.9431 (0.9396, 0.9466)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">rs</td>
<td align="center">2005</td>
<td align="center">0.9585 (0.9553, 0.9617)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rs</td>
<td align="center">2012</td>
<td align="center">0.9947 (0.9913, 0.998)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">rrs</td>
<td align="center">2005</td>
<td align="center">0.0999 (0.0948, 0.1051)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rrs</td>
<td align="center">2012</td>
<td align="center">0.0533 (0.0502, 0.0563)</td>
<td align="center">b</td>
</tr>
</tbody>
</table>

<table style="width:54%;">
<colgroup>
<col width="37%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">value_BAI</th>
<th align="center">letter_BAI</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">0.9462 (0.8794, 1.0129)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">1.1608 (1.0813, 1.2403)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">0.721 (0.6437, 0.7984)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">0.8193 (0.7758, 0.8628)</td>
<td align="center">a</td>
</tr>
<tr class="odd">
<td align="center">0.653 (0.5852, 0.7209)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">0.9107 (0.8648, 0.9567)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">-0.0559 (-0.0993, -0.0126)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">0.1223 (0.0596, 0.185)</td>
<td align="center">b</td>
</tr>
</tbody>
</table>

``` r
mhuberA
```

    ##   var disturb_year               value_EVI letter_EVI
    ## 1  rc         2005 1.1197 (1.1131, 1.1262)          a
    ## 2  rc         2012 1.0571 (1.0537, 1.0604)          b
    ## 3  rt         2005 0.8584 (0.8535, 0.8633)          a
    ## 4  rt         2012 0.9431 (0.9396, 0.9466)          b
    ## 5  rs         2005 0.9585 (0.9553, 0.9617)          a
    ## 6  rs         2012  0.9947 (0.9913, 0.998)          b
    ## 7 rrs         2005 0.0999 (0.0948, 0.1051)          a
    ## 8 rrs         2012 0.0533 (0.0502, 0.0563)          b
    ##                    value_BAI letter_BAI
    ## 1    0.9462 (0.8794, 1.0129)          a
    ## 2    1.1608 (1.0813, 1.2403)          b
    ## 3     0.721 (0.6437, 0.7984)          a
    ## 4    0.8193 (0.7758, 0.8628)          a
    ## 5     0.653 (0.5852, 0.7209)          a
    ## 6    0.9107 (0.8648, 0.9567)          b
    ## 7 -0.0559 (-0.0993, -0.0126)          a
    ## 8     0.1223 (0.0596, 0.185)          b

 Tablas site
============

``` r
evi_b <- mhuber_eviB %>% 
  mutate(M.Huber = round(M.Huber, 4),
         lower.ci = round(lower.ci, 4),
         upper.ci = round(upper.ci, 4)) %>% 
  unite("ci", c("lower.ci", "upper.ci"), sep=", ") %>% 
  mutate(ci = paste0('(', ci, ')')) %>% 
  unite("value_EVI", c("M.Huber", "ci"), sep= " ") %>%
  dplyr::select(-MonoLetter, -n) %>% 
  dplyr::select(var, site, value_EVI, letter_EVI=Letter) %>% as.data.frame() 

evi_b %>% pander() 
```

<table style="width:68%;">
<colgroup>
<col width="8%" />
<col width="9%" />
<col width="33%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">var</th>
<th align="center">site</th>
<th align="center">value_EVI</th>
<th align="center">letter_EVI</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">rc</td>
<td align="center">N</td>
<td align="center">1.1021 (1.0958, 1.1084)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rc</td>
<td align="center">S</td>
<td align="center">1.069 (1.0652, 1.0729)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">rt</td>
<td align="center">N</td>
<td align="center">0.8835 (0.8777, 0.8893)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rt</td>
<td align="center">S</td>
<td align="center">0.9207 (0.9167, 0.9246)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">rs</td>
<td align="center">N</td>
<td align="center">0.9701 (0.9666, 0.9737)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rs</td>
<td align="center">S</td>
<td align="center">0.983 (0.9797, 0.9864)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">rrs</td>
<td align="center">N</td>
<td align="center">0.0866 (0.0816, 0.0917)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rrs</td>
<td align="center">S</td>
<td align="center">0.063 (0.0596, 0.0664)</td>
<td align="center">b</td>
</tr>
</tbody>
</table>

``` r
bai_b <- mhuber_baiB %>% 
  mutate(M.Huber = round(M.Huber, 4),
         lower.ci = round(lower.ci, 4),
         upper.ci = round(upper.ci, 4)) %>% 
  unite("ci", c("lower.ci", "upper.ci"), sep=", ") %>% 
  mutate(ci = paste0('(', ci, ')')) %>% 
  unite("value_BAI", c("M.Huber", "ci"), sep= " ") %>%
  dplyr::select(-MonoLetter, -n) %>% 
  dplyr::select(var, site, value_BAI, letter_BAI=Letter) %>% as.data.frame() 

bai_b %>% pander() 
```

<table style="width:72%;">
<colgroup>
<col width="8%" />
<col width="9%" />
<col width="37%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">var</th>
<th align="center">site</th>
<th align="center">value_BAI</th>
<th align="center">letter_BAI</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">rc</td>
<td align="center">SJ</td>
<td align="center">1.2824 (1.1791, 1.3856)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rc</td>
<td align="center">caH</td>
<td align="center">0.9962 (0.9171, 1.0753)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">rc</td>
<td align="center">caL</td>
<td align="center">0.8972 (0.8431, 0.9514)</td>
<td align="center">b</td>
</tr>
<tr class="even">
<td align="center">rt</td>
<td align="center">SJ</td>
<td align="center">0.6116 (0.5387, 0.6846)</td>
<td align="center">a</td>
</tr>
<tr class="odd">
<td align="center">rt</td>
<td align="center">caH</td>
<td align="center">0.8157 (0.7549, 0.8764)</td>
<td align="center">b</td>
</tr>
<tr class="even">
<td align="center">rt</td>
<td align="center">caL</td>
<td align="center">0.9209 (0.8834, 0.9584)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">rs</td>
<td align="center">SJ</td>
<td align="center">0.7694 (0.6524, 0.8864)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rs</td>
<td align="center">caH</td>
<td align="center">0.7975 (0.7439, 0.8511)</td>
<td align="center">a</td>
</tr>
<tr class="odd">
<td align="center">rs</td>
<td align="center">caL</td>
<td align="center">0.8172 (0.7553, 0.8791)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rrs</td>
<td align="center">SJ</td>
<td align="center">0.1656 (0.0948, 0.2364)</td>
<td align="center">a</td>
</tr>
<tr class="odd">
<td align="center">rrs</td>
<td align="center">caH</td>
<td align="center">-0.0063 (-0.0668, 0.0541)</td>
<td align="center">ab</td>
</tr>
<tr class="even">
<td align="center">rrs</td>
<td align="center">caL</td>
<td align="center">-0.0939 (-0.1455, -0.0423)</td>
<td align="center">b</td>
</tr>
</tbody>
</table>

Tablas Interaction
==================

``` r
evi <- mhuber_evi %>% 
  mutate(M.Huber = round(M.Huber, 4),
         lower.ci = round(lower.ci, 4),
         upper.ci = round(upper.ci, 4)) %>% 
  unite("ci", c("lower.ci", "upper.ci"), sep=", ") %>% 
  mutate(ci = paste0('(', ci, ')')) %>% 
  unite("value_EVI", c("M.Huber", "ci"), sep= " ") %>%
  dplyr::select(-MonoLetter, -n) %>% 
  dplyr::select(var,  disturb_year, site, value_EVI, letter_EVI=Letter) %>% as.data.frame() 

evi %>% pander() 
```

<table style="width:89%;">
<colgroup>
<col width="8%" />
<col width="20%" />
<col width="9%" />
<col width="33%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">var</th>
<th align="center">disturb_year</th>
<th align="center">site</th>
<th align="center">value_EVI</th>
<th align="center">letter_EVI</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">rc</td>
<td align="center">2005</td>
<td align="center">N</td>
<td align="center">1.1689 (1.161, 1.1768)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rc</td>
<td align="center">2005</td>
<td align="center">S</td>
<td align="center">1.0662 (1.0584, 1.0741)</td>
<td align="center">c</td>
</tr>
<tr class="odd">
<td align="center">rc</td>
<td align="center">2012</td>
<td align="center">N</td>
<td align="center">1.0417 (1.0364, 1.047)</td>
<td align="center">b</td>
</tr>
<tr class="even">
<td align="center">rc</td>
<td align="center">2012</td>
<td align="center">S</td>
<td align="center">1.0711 (1.0674, 1.0748)</td>
<td align="center">c</td>
</tr>
<tr class="odd">
<td align="center">rt</td>
<td align="center">2005</td>
<td align="center">N</td>
<td align="center">0.819 (0.8137, 0.8243)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rt</td>
<td align="center">2005</td>
<td align="center">S</td>
<td align="center">0.9016 (0.8958, 0.9074)</td>
<td align="center">c</td>
</tr>
<tr class="odd">
<td align="center">rt</td>
<td align="center">2012</td>
<td align="center">N</td>
<td align="center">0.9472 (0.9423, 0.9521)</td>
<td align="center">b</td>
</tr>
<tr class="even">
<td align="center">rt</td>
<td align="center">2012</td>
<td align="center">S</td>
<td align="center">0.9387 (0.9336, 0.9438)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">rs</td>
<td align="center">2005</td>
<td align="center">N</td>
<td align="center">0.9553 (0.9507, 0.9599)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rs</td>
<td align="center">2005</td>
<td align="center">S</td>
<td align="center">0.9618 (0.9573, 0.9663)</td>
<td align="center">a</td>
</tr>
<tr class="odd">
<td align="center">rs</td>
<td align="center">2012</td>
<td align="center">N</td>
<td align="center">0.9855 (0.9805, 0.9905)</td>
<td align="center">b</td>
</tr>
<tr class="even">
<td align="center">rs</td>
<td align="center">2012</td>
<td align="center">S</td>
<td align="center">1.0039 (0.9996, 1.0081)</td>
<td align="center">c</td>
</tr>
<tr class="odd">
<td align="center">rrs</td>
<td align="center">2005</td>
<td align="center">N</td>
<td align="center">0.1362 (0.1304, 0.142)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rrs</td>
<td align="center">2005</td>
<td align="center">S</td>
<td align="center">0.0582 (0.0514, 0.065)</td>
<td align="center">c</td>
</tr>
<tr class="odd">
<td align="center">rrs</td>
<td align="center">2012</td>
<td align="center">N</td>
<td align="center">0.0388 (0.034, 0.0437)</td>
<td align="center">b</td>
</tr>
<tr class="even">
<td align="center">rrs</td>
<td align="center">2012</td>
<td align="center">S</td>
<td align="center">0.0662 (0.0629, 0.0695)</td>
<td align="center">c</td>
</tr>
</tbody>
</table>

``` r
bai <- mhuber_bai %>% 
  mutate(M.Huber = round(M.Huber, 4),
         lower.ci = round(lower.ci, 4),
         upper.ci = round(upper.ci, 4)) %>% 
  unite("ci", c("lower.ci", "upper.ci"), sep=", ") %>% 
  mutate(ci = paste0('(', ci, ')')) %>% 
  unite("value_BAI", c("M.Huber", "ci"), sep= " ") %>%
  dplyr::select(-MonoLetter, -n) %>% 
  dplyr::select(var, disturb_year, site, value_BAI, letter_BAI=Letter) %>% as.data.frame() 

bai %>% pander() 
```

<table style="width:93%;">
<colgroup>
<col width="8%" />
<col width="20%" />
<col width="9%" />
<col width="37%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">var</th>
<th align="center">disturb_year</th>
<th align="center">site</th>
<th align="center">value_BAI</th>
<th align="center">letter_BAI</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">rc</td>
<td align="center">2005</td>
<td align="center">SJ</td>
<td align="center">1.1122 (1.0004, 1.2241)</td>
<td align="center">abc</td>
</tr>
<tr class="even">
<td align="center">rc</td>
<td align="center">2005</td>
<td align="center">caH</td>
<td align="center">0.8866 (0.8003, 0.973)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">rc</td>
<td align="center">2005</td>
<td align="center">caL</td>
<td align="center">0.8321 (0.7326, 0.9315)</td>
<td align="center">bc</td>
</tr>
<tr class="even">
<td align="center">rc</td>
<td align="center">2012</td>
<td align="center">SJ</td>
<td align="center">1.4457 (1.3223, 1.5691)</td>
<td align="center">a</td>
</tr>
<tr class="odd">
<td align="center">rc</td>
<td align="center">2012</td>
<td align="center">caH</td>
<td align="center">1.1071 (1.0257, 1.1885)</td>
<td align="center">c</td>
</tr>
<tr class="even">
<td align="center">rc</td>
<td align="center">2012</td>
<td align="center">caL</td>
<td align="center">0.952 (0.8889, 1.015)</td>
<td align="center">bc</td>
</tr>
<tr class="odd">
<td align="center">rt</td>
<td align="center">2005</td>
<td align="center">SJ</td>
<td align="center">0.4454 (0.3751, 0.5158)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rt</td>
<td align="center">2005</td>
<td align="center">caH</td>
<td align="center">0.8921 (0.8091, 0.9751)</td>
<td align="center">bc</td>
</tr>
<tr class="odd">
<td align="center">rt</td>
<td align="center">2005</td>
<td align="center">caL</td>
<td align="center">0.9012 (0.8132, 0.9892)</td>
<td align="center">bc</td>
</tr>
<tr class="even">
<td align="center">rt</td>
<td align="center">2012</td>
<td align="center">SJ</td>
<td align="center">0.7687 (0.6839, 0.8534)</td>
<td align="center">bc</td>
</tr>
<tr class="odd">
<td align="center">rt</td>
<td align="center">2012</td>
<td align="center">caH</td>
<td align="center">0.7534 (0.6864, 0.8204)</td>
<td align="center">b</td>
</tr>
<tr class="even">
<td align="center">rt</td>
<td align="center">2012</td>
<td align="center">caL</td>
<td align="center">0.9263 (0.9001, 0.9526)</td>
<td align="center">c</td>
</tr>
<tr class="odd">
<td align="center">rs</td>
<td align="center">2005</td>
<td align="center">SJ</td>
<td align="center">0.4888 (0.4213, 0.5562)</td>
<td align="center">a</td>
</tr>
<tr class="even">
<td align="center">rs</td>
<td align="center">2005</td>
<td align="center">caH</td>
<td align="center">0.7895 (0.6913, 0.8878)</td>
<td align="center">bc</td>
</tr>
<tr class="odd">
<td align="center">rs</td>
<td align="center">2005</td>
<td align="center">caL</td>
<td align="center">0.7303 (0.6118, 0.8489)</td>
<td align="center">ac</td>
</tr>
<tr class="even">
<td align="center">rs</td>
<td align="center">2012</td>
<td align="center">SJ</td>
<td align="center">1.031 (0.93, 1.1321)</td>
<td align="center">b</td>
</tr>
<tr class="odd">
<td align="center">rs</td>
<td align="center">2012</td>
<td align="center">caH</td>
<td align="center">0.8132 (0.7413, 0.8852)</td>
<td align="center">bc</td>
</tr>
<tr class="even">
<td align="center">rs</td>
<td align="center">2012</td>
<td align="center">caL</td>
<td align="center">0.8761 (0.8394, 0.9129)</td>
<td align="center">bc</td>
</tr>
<tr class="odd">
<td align="center">rrs</td>
<td align="center">2005</td>
<td align="center">SJ</td>
<td align="center">0.0426 (-0.0066, 0.0918)</td>
<td align="center">abc</td>
</tr>
<tr class="even">
<td align="center">rrs</td>
<td align="center">2005</td>
<td align="center">caH</td>
<td align="center">-0.1075 (-0.1893, -0.0257)</td>
<td align="center">bc</td>
</tr>
<tr class="odd">
<td align="center">rrs</td>
<td align="center">2005</td>
<td align="center">caL</td>
<td align="center">-0.1424 (-0.2264, -0.0583)</td>
<td align="center">c</td>
</tr>
<tr class="even">
<td align="center">rrs</td>
<td align="center">2012</td>
<td align="center">SJ</td>
<td align="center">0.3206 (0.229, 0.4122)</td>
<td align="center">a</td>
</tr>
<tr class="odd">
<td align="center">rrs</td>
<td align="center">2012</td>
<td align="center">caH</td>
<td align="center">0.0819 (0.0275, 0.1364)</td>
<td align="center">b</td>
</tr>
<tr class="even">
<td align="center">rrs</td>
<td align="center">2012</td>
<td align="center">caL</td>
<td align="center">-0.0443 (-0.1071, 0.0185)</td>
<td align="center">bc</td>
</tr>
</tbody>
</table>
