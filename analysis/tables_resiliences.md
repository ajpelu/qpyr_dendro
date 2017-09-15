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

### Tablas

``` r
evi_a <- mhuber_eviA %>% 
  mutate(M.Huber = round(M.Huber, 4),
         lower.ci = round(lower.ci, 4),
         upper.ci = round(upper.ci, 4)) %>% 
  unite("ci", c("lower.ci", "upper.ci"), sep=", ") %>% 
  mutate(ci = paste0('(', ci, ')')) %>% 
  unite("value", c("M.Huber", "ci"), sep= " ") %>%
  dplyr::select(-MonoLetter, -n) %>% 
  unite("value", c("value", "Letter"), sep= "^") %>% 
  dplyr::select(var, disturb_year, value) %>% as.data.frame()

evi_a %>% pander() 
```

<table style="width:64%;">
<colgroup>
<col width="8%" />
<col width="20%" />
<col width="34%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">var</th>
<th align="center">disturb_year</th>
<th align="center">value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">rc</td>
<td align="center">2005</td>
<td align="center">1.1197 (1.1131, 1.1262)^a</td>
</tr>
<tr class="even">
<td align="center">rc</td>
<td align="center">2012</td>
<td align="center">1.0571 (1.0537, 1.0604)^b</td>
</tr>
<tr class="odd">
<td align="center">rt</td>
<td align="center">2005</td>
<td align="center">0.8584 (0.8535, 0.8633)^a</td>
</tr>
<tr class="even">
<td align="center">rt</td>
<td align="center">2012</td>
<td align="center">0.9431 (0.9396, 0.9466)^b</td>
</tr>
<tr class="odd">
<td align="center">rs</td>
<td align="center">2005</td>
<td align="center">0.9585 (0.9553, 0.9617)^a</td>
</tr>
<tr class="even">
<td align="center">rs</td>
<td align="center">2012</td>
<td align="center">0.9947 (0.9913, 0.998)^b</td>
</tr>
<tr class="odd">
<td align="center">rrs</td>
<td align="center">2005</td>
<td align="center">0.0999 (0.0948, 0.1051)^a</td>
</tr>
<tr class="even">
<td align="center">rrs</td>
<td align="center">2012</td>
<td align="center">0.0533 (0.0502, 0.0563)^b</td>
</tr>
</tbody>
</table>
