``` r
library("tidyverse")
library("dplR")
library("stringr")
library("knitr")
library('gtable')
library('grid')
library('gridExtra')
library('pander')
library('broom')
library('effects')
```

Resilience
==========

-   Calcularemos las métricas resiliencia de (<span class="citeproc-not-found" data-reference-id="Lloret2011">**???**</span>) sobre el crecimiento.
-   Vamos a calcularlas sobre el BAI de cada árbol.
-   Utilizaremos tres sitios: SJ, CAH y CAL (ver [./analysis/analysis\_chronologies.md]('./analysis/analysis_chronologies.md))

Prepare data
------------

-   Leer datos `rwl` de SJ y CA
-   Leer datos de diametros de los focal tree

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

``` r
source(paste0(di, 'script/R/rw_byTree.R'))
source(paste0(di, 'script/R/bai_piovesan.R'))
source(paste0(di, 'script/R/baiResilience.R'))
```

-   Crear dataframes `rwl` por cada sitio CA\_High, CA\_Low, SJ\_High. SJ\_Low

``` r
# Replace SNA by SJ and SNB by CA
names(ca) <- stringr::str_replace(names(ca), "SNB", "CA") 
names(sj) <- stringr::str_replace(names(sj), "SNA", "SJ")

# Remove g in name of some cores of CA. 
names(ca) <- stringr::str_replace(names(ca), "g", "")
```

``` r
# Create subset to compare between sites 
caL <- ca[,c("CA0101","CA0102","CA0201","CA0202","CA0301","CA0302","CA0401","CA0402","CA0501","CA0502",
             "CA0601","CA0602","CA0701","CA0702","CA0801","CA0802","CA0901","CA0902","CA1001","CA1002",
             "CA2601","CA2602","CA2701","CA2702","CA2801","CA2802","CA2901","CA2902","CA3001","CA3002")] 
caH <- ca[, c("CA1101","CA1102","CA1201","CA1202","CA1301","CA1302","CA1401","CA1402","CA1501","CA1502",
              "CA1601","CA1602","CA1701","CA1702","CA1801","CA1802","CA1901","CA1902","CA2001","CA2002",
              "CA2101","CA2102","CA2201","CA2202","CA2301","CA2302","CA2401","CA2402","CA2501","CA2502")]
```

-   Lectura y preparación de datos de diámetro

``` r
# Prepare Diameter data 

# Compute diameter (mm)
compete <- compete %>% 
  mutate(dn_mm = (perim_mm / pi))

# Change name focal according to loc
compete <- compete %>% 
  mutate(id_focalLoc = stringr::str_replace_all(id_focal, c("A" = "SJ", "B" = "CA")))

         
# Get only focal trees, and only selected variables 
ft <- compete %>% 
  filter(sp=='Focal') %>% 
  filter(id_focal!='Fresno') %>% 
  dplyr::select(id_focal, id_focalLoc, loc, dn_mm, height_cm) 

# Set levels of eleveation 
ca_lowcode <- c(paste0('CA', str_pad(1:10, 2, pad='0')),
            paste0('CA', 26:30))
ca_highcode <- paste0('CA', 11:25)

ft <- ft %>% 
  mutate(site = as.factor(
    ifelse(id_focalLoc %in% ca_lowcode, 'CAL', 
           ifelse(id_focalLoc %in% ca_highcode, 'CAH', 'SJ'))))
```

Aggregate RW by tree
====================

-   Agregar valores medios de RW por site (obtenemos sj\_tree / caL\_tree, caH\_tree)
-   ver fun rw\_byTree o utilizar treeMean (dplR)

``` r
# Remember snc = structure of core name SJ0101 (site | tree | core)
sj_tree <- rw_byTree(sj, snc =c(2,2,2), locname = 'SJ')
caL_tree <- rw_byTree(caL, snc =c(2,2,2), locname = 'CA')
caH_tree <- rw_byTree(caH, snc =c(2,2,2), locname = 'CA')
```

-   Crear diferentes dataset de diametro por sitio

``` r
diam <- ft %>%
  mutate(diameter = dn_mm, 
         id = id_focalLoc) %>%
  dplyr::select(id, diameter, site) %>% 
  split(.$site) 


d_caH <- diam$CAH[,c('id','diameter')]
d_caL <- diam$CAL[,c('id','diameter')]
d_sj <- diam$SJ[,c('id','diameter')]
```

Cómputo del BAI por site
------------------------

-   He construido una funcion para el computo del BAI, teniendo en cuenta la aproximación de (Piovesa et al. 2008). Es similar a `bai.out`

``` r
bai_sj <- bai_piovesan(rwdf = sj_tree, diam_df = d_sj)
bai_caH <- bai_piovesan(rwdf = caH_tree, diam_df = d_caH)
bai_caL <- bai_piovesan(rwdf = caL_tree, diam_df = d_caL)

# Set class to bai object 
# Esto es para que funcionen algunas otras funciones de dplR 
bais <- c('bai_sj', 'bai_caH', 'bai_caL')

for (i in bais){
  aux <- get(i)
  
  class(aux) <- c('rwl', 'data.frame')
  
  assign(i, aux)
}
```

Resilience
----------

-   Computar métricas de resiliencia BAI para los tres sitios.
-   Computar tres eventos climáticos: 1995, 2005, 2012
-   Computar dos ventanas temporales: 2 y 3

``` r
# Drought years 
dyears <- c(1995, 2005, 2012)

# SJ 
res_4_sj <- baiResilience(bai_sj, event_years = dyears, window = 4)
res_3_sj <- baiResilience(bai_sj, event_years = dyears, window = 3)
res_2_sj <- baiResilience(bai_sj, event_years = dyears, window = 2)

# caL
res_4_caL <- baiResilience(bai_caL, event_years = dyears, window = 4)
res_3_caL <- baiResilience(bai_caL, event_years = dyears, window = 3)
res_2_caL <- baiResilience(bai_caL, event_years = dyears, window = 2)

# caH
res_4_caH <- baiResilience(bai_caH, event_years = dyears, window = 4)
res_3_caH <- baiResilience(bai_caH, event_years = dyears, window = 3)
res_2_caH <- baiResilience(bai_caH, event_years = dyears, window = 2)
```

### Computar correlaciones ventanas temporales

``` r
# Vector with objects name
obj <- c('res_2_sj', 'res_3_sj', 'res_4_sj',
         'res_2_caL', 'res_3_caL', 'res_4_caL',
         'res_2_caH', 'res_3_caH', 'res_4_caH')

correla_ws <- c()

for (i in obj){ 
  x <- get(i)
  xres <- x$resilience
  out <- xres %>% 
    mutate(ws = paste0('ws_', as.character(str_extract(i, "([0-9])"))),
           site = str_replace(i, "res_[0-9]_", '')) %>%
    select(-disturb_year, -tree)
             
  correla_ws <- bind_rows(correla_ws, out)

}

# Split by window size 
correla <- correla_ws %>% split(.$ws) 

# Change names 
names(correla[["ws_2"]])[1:4] <- paste0(names(correla[["ws_2"]])[1:4], '2')
names(correla[["ws_3"]])[1:4] <- paste0(names(correla[["ws_3"]])[1:4], '3')
names(correla[["ws_4"]])[1:4] <- paste0(names(correla[["ws_4"]])[1:4], '4')

cor2 <- correla[["ws_2"]] %>% select(-ws) %>% mutate(ind = row_number())
cor3 <- correla[["ws_3"]] %>% select(-ws) %>% mutate(ind = row_number())
cor4 <- correla[["ws_4"]] %>% select(-ws) %>% mutate(ind = row_number())


correlations <- inner_join(cor2, cor3, by='ind') %>% inner_join(cor4, by='ind')


# Resistance
aux_coefs <- c()

model <- lm(rt2~rt3, data=correlations)
p_rt23 <- correlations %>% ggplot(aes(rt2, rt3)) + 
  geom_point(aes(colour=site.x)) + theme_bw() + geom_smooth(method = 'lm', se=FALSE) + 
  ggtitle(paste('rt (R2) = ', round(summary(model)$r.squared, 3))) + 
  theme(legend.position = c(.2, .75))
aux <- as.data.frame(cbind('rt','2-3', as.numeric(summary(model)$r.squared)))
aux_coefs <- rbind(aux_coefs, aux)

model <- lm(rt2~rt4, data=correlations)
p_rt24 <- correlations %>% ggplot(aes(rt2, rt4)) + 
  geom_point(aes(colour=site.x)) + theme_bw() + geom_smooth(method = 'lm', se=FALSE) + 
  ggtitle(paste('rt (R2) = ', round(summary(model)$r.squared, 3))) +
  theme(legend.position = 'none')
aux <- as.data.frame(cbind('rt','2-4', as.numeric(summary(model)$r.squared)))
aux_coefs <- rbind(aux_coefs, aux)

model <- lm(rt3~rt4, data=correlations)
p_rt34 <- correlations %>% ggplot(aes(rt3, rt4)) + 
  geom_point(aes(colour=site.x)) + theme_bw() + geom_smooth(method = 'lm', se=FALSE) + 
  ggtitle(paste('rt (R2) = ', round(summary(model)$r.squared, 3))) +
  theme(legend.position = 'none')
aux <- as.data.frame(cbind('rt','3-4', as.numeric(summary(model)$r.squared)))
aux_coefs <- rbind(aux_coefs, aux)

grid.arrange(p_rt23, p_rt24, p_rt34,ncol=3) 
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-11-1.png)

``` r
# Recovery 
model <- lm(rc2~rc3, data=correlations)
p_rc23 <- correlations %>% ggplot(aes(rc2, rc3)) + 
  geom_point(aes(colour=site.x)) + theme_bw() + geom_smooth(method = 'lm', se=FALSE) + 
  ggtitle(paste('rc (R2) = ', round(summary(model)$r.squared, 3))) + 
  theme(legend.position = c(.2, .75))
aux <- as.data.frame(cbind('rc','2-3', as.numeric(summary(model)$r.squared)))
aux_coefs <- rbind(aux_coefs, aux)


model <- lm(rc2~rc4, data=correlations)
p_rc24 <- correlations %>% ggplot(aes(rc2, rc4)) + 
  geom_point(aes(colour=site.x)) + theme_bw() + geom_smooth(method = 'lm', se=FALSE) + 
  ggtitle(paste('rc (R2) = ', round(summary(model)$r.squared, 3))) +
  theme(legend.position = 'none')
aux <- as.data.frame(cbind('rc','2-4', as.numeric(summary(model)$r.squared)))
aux_coefs <- rbind(aux_coefs, aux)


model <- lm(rc3~rc4, data=correlations)
p_rc34 <- correlations %>% ggplot(aes(rc3, rc4)) + 
  geom_point(aes(colour=site.x)) + theme_bw() + geom_smooth(method = 'lm', se=FALSE) + 
  ggtitle(paste('rc (R2) = ', round(summary(model)$r.squared, 3))) +
  theme(legend.position = 'none')
aux <- as.data.frame(cbind('rc','3-4', as.numeric(summary(model)$r.squared)))
aux_coefs <- rbind(aux_coefs, aux)


grid.arrange(p_rc23, p_rc24, p_rc34,ncol=3) 
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-11-2.png)

``` r
# Resilience
model <- lm(rs2~rs3, data=correlations)
p_rs23 <- correlations %>% ggplot(aes(rs2, rs3)) + 
  geom_point(aes(colour=site.x)) + theme_bw() + geom_smooth(method = 'lm', se=FALSE) + 
  ggtitle(paste('rs (R2) = ', round(summary(model)$r.squared, 3))) + 
  theme(legend.position = c(.2, .75))
aux <- as.data.frame(cbind('rs','2-3', as.numeric(summary(model)$r.squared)))
aux_coefs <- rbind(aux_coefs, aux)

model <- lm(rs2~rs4, data=correlations)
p_rs24 <- correlations %>% ggplot(aes(rs2, rs4)) + 
  geom_point(aes(colour=site.x)) + theme_bw() + geom_smooth(method = 'lm', se=FALSE) + 
  ggtitle(paste('rs (R2) = ', round(summary(model)$r.squared, 3))) +
  theme(legend.position = 'none')
aux <- as.data.frame(cbind('rs','2-4', as.numeric(summary(model)$r.squared)))
aux_coefs <- rbind(aux_coefs, aux)

model <- lm(rs3~rs4, data=correlations)
p_rs34 <- correlations %>% ggplot(aes(rs3, rs4)) + 
  geom_point(aes(colour=site.x)) + theme_bw() + geom_smooth(method = 'lm', se=FALSE) + 
  ggtitle(paste('rs (R2) = ', round(summary(model)$r.squared, 3))) +
  theme(legend.position = 'none')
aux <- as.data.frame(cbind('rs','3-4', as.numeric(summary(model)$r.squared)))
aux_coefs <- rbind(aux_coefs, aux)

grid.arrange(p_rs23, p_rs24, p_rs34,ncol=3) 
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-11-3.png)

``` r
# Relative Resilience
model <- lm(rrs2~rrs3, data=correlations)
p_rrs23 <- correlations %>% ggplot(aes(rrs2, rrs3)) + 
  geom_point(aes(colour=site.x)) + theme_bw() + geom_smooth(method = 'lm', se=FALSE) + 
  ggtitle(paste('rrs (R2) = ', round(summary(model)$r.squared, 3))) + 
  theme(legend.position = c(.2, .75))
aux <- as.data.frame(cbind('rrs','2-3', as.numeric(summary(model)$r.squared)))
aux_coefs <- rbind(aux_coefs, aux)

model <- lm(rrs2~rrs4, data=correlations)
p_rrs24 <- correlations %>% ggplot(aes(rrs2, rrs4)) + 
  geom_point(aes(colour=site.x)) + theme_bw() + geom_smooth(method = 'lm', se=FALSE) + 
  ggtitle(paste('rrs (R2) = ', round(summary(model)$r.squared, 3))) +
  theme(legend.position = 'none')
aux <- as.data.frame(cbind('rrs','2-4', as.numeric(summary(model)$r.squared)))
aux_coefs <- rbind(aux_coefs, aux)

model <- lm(rrs3~rrs4, data=correlations)
p_rrs34 <- correlations %>% ggplot(aes(rrs3, rrs4)) + 
  geom_point(aes(colour=site.x)) + theme_bw() + geom_smooth(method = 'lm', se=FALSE) + 
  ggtitle(paste('rrs (R2) = ', round(summary(model)$r.squared, 3))) +
  theme(legend.position = 'none')
aux <- as.data.frame(cbind('rrs','3-4', as.numeric(summary(model)$r.squared)))
aux_coefs <- rbind(aux_coefs, aux)

grid.arrange(p_rrs23, p_rrs24, p_rrs34,ncol=3) 
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-11-4.png)

``` r
names(aux_coefs) <- c('var', 'window_size', 'r2')

write.csv(aux_coefs, file=paste0(di, '/out/correla_resilience/correla_window_size.csv'), row.names = F)
```

``` r
aux_coefs %>% pander()
```

<table style="width:51%;">
<colgroup>
<col width="8%" />
<col width="19%" />
<col width="23%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">var</th>
<th align="center">window_size</th>
<th align="center">r2</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">rt</td>
<td align="center">2-3</td>
<td align="center">0.916882284149449</td>
</tr>
<tr class="even">
<td align="center">rt</td>
<td align="center">2-4</td>
<td align="center">0.804404303544226</td>
</tr>
<tr class="odd">
<td align="center">rt</td>
<td align="center">3-4</td>
<td align="center">0.954056995082479</td>
</tr>
<tr class="even">
<td align="center">rc</td>
<td align="center">2-3</td>
<td align="center">0.940435462578806</td>
</tr>
<tr class="odd">
<td align="center">rc</td>
<td align="center">2-4</td>
<td align="center">0.875357103621433</td>
</tr>
<tr class="even">
<td align="center">rc</td>
<td align="center">3-4</td>
<td align="center">0.977309191655523</td>
</tr>
<tr class="odd">
<td align="center">rs</td>
<td align="center">2-3</td>
<td align="center">0.887274876125786</td>
</tr>
<tr class="even">
<td align="center">rs</td>
<td align="center">2-4</td>
<td align="center">0.764147394080222</td>
</tr>
<tr class="odd">
<td align="center">rs</td>
<td align="center">3-4</td>
<td align="center">0.955085073886915</td>
</tr>
<tr class="even">
<td align="center">rrs</td>
<td align="center">2-3</td>
<td align="center">0.914381250472491</td>
</tr>
<tr class="odd">
<td align="center">rrs</td>
<td align="center">2-4</td>
<td align="center">0.848277808345292</td>
</tr>
<tr class="even">
<td align="center">rrs</td>
<td align="center">3-4</td>
<td align="center">0.978980936308473</td>
</tr>
</tbody>
</table>

Nos quedamos con 3 años de ventana temporal.

Plots Crecimiento
=================

Boxplot with outliers
---------------------

``` r
gsj <- res_3_sj$growth %>% mutate(site='SJ')
gcaL <- res_3_caL$growth %>% mutate(site='caL')
gcaH <- res_3_caH$growth %>% mutate(site='caH')

g <- bind_rows(gsj, gcaL, gcaH)

# Export csv 
write.csv(g, file=paste0(di, 'data/resilience/crecimientos_drought.csv'), row.names = FALSE)

g %>% mutate(disturb = recode(disturb, 
                              dr = '1_dr', pre = '0_pre', post = '2_post')) %>%
  ggplot(aes(y=mean_period/100, x=disturb)) + 
  geom_boxplot() + 
  facet_grid(site~disturb_year, scales='free_y') + 
  theme_bw()
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-13-1.png)

Mean + se
---------

``` r
g %>% 
  mutate(disturb = recode(disturb, dr = '1_dr', pre = '0_pre', post = '2_post')) %>%
  group_by(disturb, disturb_year, site) %>% 
  summarise(mean = mean(mean_period),
            sd = sd(mean_period),
            se = sd/sqrt(length(mean_period))) %>%
  ggplot(aes(y=mean/100, x=disturb)) + 
  geom_errorbar(aes(ymin=mean/100 - se/100, 
                    ymax=mean/100 + se/100),
                width = 0.2) +
  geom_point(size=2, shape=21, fill='white') + 
  facet_grid(site~disturb_year, scales='free_y') + 
  theme_bw() + ylab('BAI (cm2/year)') + 
  theme(panel.grid = element_blank())
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-14-1.png)

``` r
pgrowht <- g %>% 
  mutate(disturb = recode(disturb, dr = '1_dr', pre = '0_pre', post = '2_post')) %>%
  group_by(disturb, disturb_year, site) %>% 
  summarise(mean = mean(mean_period),
            sd = sd(mean_period),
            se = sd/sqrt(length(mean_period))) %>%
  ggplot(aes(y=mean/100, x=disturb, colour=site)) + 
  geom_errorbar(aes(ymin=mean/100 - se/100, 
                    ymax=mean/100 + se/100),
                width = 0.15) +
  geom_point(size=3, aes(shape=site), fill='white') + 
  geom_line(aes(group=site))+
  facet_wrap(~disturb_year, scales='free_y') + 
  theme_bw() + ylab('BAI (cm2/year)') + 
  theme(panel.grid = element_blank())

pgrowht
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-15-1.png)

``` r
ggsave(plot=pgrowht, width=8, height = 4,
       filename=paste0(di, 'out/fig/resilience/bai_events.pdf')) 
```

``` r
g %>% 
  mutate(disturb = recode(disturb, dr = '1_dr', pre = '0_pre', post = '2_post')) %>%
  group_by(site, disturb_year, disturb) %>% 
  summarise(mean = mean(mean_period/100),
            sd = sd(mean_period/100),
            se = sd/sqrt(length(mean_period/100))) %>% pander() 
```

<table style="width:86%;">
<colgroup>
<col width="9%" />
<col width="20%" />
<col width="13%" />
<col width="13%" />
<col width="13%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">site</th>
<th align="center">disturb_year</th>
<th align="center">disturb</th>
<th align="center">mean</th>
<th align="center">sd</th>
<th align="center">se</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">SJ</td>
<td align="center">1995</td>
<td align="center">0_pre</td>
<td align="center">4.949360</td>
<td align="center">2.401841</td>
<td align="center">0.5370680</td>
</tr>
<tr class="even">
<td align="center">SJ</td>
<td align="center">1995</td>
<td align="center">1_dr</td>
<td align="center">3.102071</td>
<td align="center">1.394718</td>
<td align="center">0.3118683</td>
</tr>
<tr class="odd">
<td align="center">SJ</td>
<td align="center">1995</td>
<td align="center">2_post</td>
<td align="center">11.037538</td>
<td align="center">6.507541</td>
<td align="center">1.4551304</td>
</tr>
<tr class="even">
<td align="center">SJ</td>
<td align="center">2005</td>
<td align="center">0_pre</td>
<td align="center">15.038941</td>
<td align="center">5.521582</td>
<td align="center">1.2346633</td>
</tr>
<tr class="odd">
<td align="center">SJ</td>
<td align="center">2005</td>
<td align="center">1_dr</td>
<td align="center">6.437153</td>
<td align="center">2.358030</td>
<td align="center">0.5272715</td>
</tr>
<tr class="even">
<td align="center">SJ</td>
<td align="center">2005</td>
<td align="center">2_post</td>
<td align="center">6.966562</td>
<td align="center">2.409606</td>
<td align="center">0.5388042</td>
</tr>
<tr class="odd">
<td align="center">SJ</td>
<td align="center">2012</td>
<td align="center">0_pre</td>
<td align="center">13.666405</td>
<td align="center">6.457739</td>
<td align="center">1.4439943</td>
</tr>
<tr class="even">
<td align="center">SJ</td>
<td align="center">2012</td>
<td align="center">1_dr</td>
<td align="center">9.729436</td>
<td align="center">3.218183</td>
<td align="center">0.7196077</td>
</tr>
<tr class="odd">
<td align="center">SJ</td>
<td align="center">2012</td>
<td align="center">2_post</td>
<td align="center">13.804918</td>
<td align="center">4.651000</td>
<td align="center">1.0399953</td>
</tr>
<tr class="even">
<td align="center">caH</td>
<td align="center">1995</td>
<td align="center">0_pre</td>
<td align="center">20.078179</td>
<td align="center">24.072135</td>
<td align="center">6.2153984</td>
</tr>
<tr class="odd">
<td align="center">caH</td>
<td align="center">1995</td>
<td align="center">1_dr</td>
<td align="center">9.923127</td>
<td align="center">9.845728</td>
<td align="center">2.5421560</td>
</tr>
<tr class="even">
<td align="center">caH</td>
<td align="center">1995</td>
<td align="center">2_post</td>
<td align="center">23.735572</td>
<td align="center">27.143508</td>
<td align="center">7.0084236</td>
</tr>
<tr class="odd">
<td align="center">caH</td>
<td align="center">2005</td>
<td align="center">0_pre</td>
<td align="center">27.216860</td>
<td align="center">25.581156</td>
<td align="center">6.6050261</td>
</tr>
<tr class="even">
<td align="center">caH</td>
<td align="center">2005</td>
<td align="center">1_dr</td>
<td align="center">23.290311</td>
<td align="center">21.057950</td>
<td align="center">5.4371394</td>
</tr>
<tr class="odd">
<td align="center">caH</td>
<td align="center">2005</td>
<td align="center">2_post</td>
<td align="center">20.963604</td>
<td align="center">21.794923</td>
<td align="center">5.6274250</td>
</tr>
<tr class="even">
<td align="center">caH</td>
<td align="center">2012</td>
<td align="center">0_pre</td>
<td align="center">31.763565</td>
<td align="center">32.285075</td>
<td align="center">8.3359704</td>
</tr>
<tr class="odd">
<td align="center">caH</td>
<td align="center">2012</td>
<td align="center">1_dr</td>
<td align="center">24.015379</td>
<td align="center">25.334862</td>
<td align="center">6.5414332</td>
</tr>
<tr class="even">
<td align="center">caH</td>
<td align="center">2012</td>
<td align="center">2_post</td>
<td align="center">24.552089</td>
<td align="center">25.215397</td>
<td align="center">6.5105875</td>
</tr>
<tr class="odd">
<td align="center">caL</td>
<td align="center">1995</td>
<td align="center">0_pre</td>
<td align="center">9.855063</td>
<td align="center">5.080906</td>
<td align="center">1.3118843</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">1995</td>
<td align="center">1_dr</td>
<td align="center">5.577226</td>
<td align="center">2.229862</td>
<td align="center">0.5757479</td>
</tr>
<tr class="odd">
<td align="center">caL</td>
<td align="center">1995</td>
<td align="center">2_post</td>
<td align="center">10.070205</td>
<td align="center">5.500586</td>
<td align="center">1.4202452</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">2005</td>
<td align="center">0_pre</td>
<td align="center">13.698045</td>
<td align="center">6.730193</td>
<td align="center">1.7377283</td>
</tr>
<tr class="odd">
<td align="center">caL</td>
<td align="center">2005</td>
<td align="center">1_dr</td>
<td align="center">12.187221</td>
<td align="center">6.548989</td>
<td align="center">1.6909416</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">2005</td>
<td align="center">2_post</td>
<td align="center">9.832373</td>
<td align="center">4.307852</td>
<td align="center">1.1122825</td>
</tr>
<tr class="odd">
<td align="center">caL</td>
<td align="center">2012</td>
<td align="center">0_pre</td>
<td align="center">15.506432</td>
<td align="center">7.571946</td>
<td align="center">1.9550681</td>
</tr>
<tr class="even">
<td align="center">caL</td>
<td align="center">2012</td>
<td align="center">1_dr</td>
<td align="center">14.447602</td>
<td align="center">7.411388</td>
<td align="center">1.9136121</td>
</tr>
<tr class="odd">
<td align="center">caL</td>
<td align="center">2012</td>
<td align="center">2_post</td>
<td align="center">13.717155</td>
<td align="center">7.050255</td>
<td align="center">1.8203679</td>
</tr>
</tbody>
</table>

Anovas Resiliencia
==================

``` r
# Prepara data 
rsj <- res_3_sj$resilience %>% mutate(site='SJ')
rcaL<- res_3_caL$resilience %>% mutate(site='caL')
rcaH <- res_3_caH$resilience %>% mutate(site='caH')

re <- bind_rows(rsj, rcaL, rcaH)
re$disturb_year <- as.factor(re$disturb_year)
re$site <- as.factor(re$site)

# Export csv 
write.csv(re, file=paste0(di, 'data/resilience/resilience_bai.csv'), row.names = FALSE)
```

Custom functions
----------------

``` r
# Custom Function to compute ANOVAS
aovas <- function(df, vars, resp_var){ 
  require('dplyr')
  require('broom')
  
  # Create subset 
  dfsel <- df %>% dplyr::select_(.dots=c(vars, resp_var)) 
    
  
  # Model 
  myformula <- as.formula(paste0(resp_var,  " ~ ",
                                 paste(vars, collapse = '*')))
  
  mymodel <- aov(myformula, data=dfsel)
  
  # Output model Summary http://my.ilstu.edu/~wjschne/444/ANOVA.html#(1)
  model_coeff <- broom::tidy(mymodel)
  model_summary <- broom::glance(mymodel)
  
  out <- c() 
  out$model_coeff <- model_coeff
  out$model_summary <- model_summary
  out$mymodel <- mymodel
  
  return(out)
}


# Post-Hoc comparison
phc <- function(mymodel, resp_var){
  require(lsmeans)

  # Disturb Event 
  ph_event <- lsmeans(mymodel, pairwise ~ disturb_year, adjust = "tukey")
  
  # differences letters 
  cld_event <- cld(ph_event, alpha   = 0.01, 
                   Letters = letters, 
                   adjust  = "tukey")
  
  # Site  
  ph_site <- lsmeans(mymodel, pairwise ~ site, adjust = "tukey")
  cld_site <- cld(ph_site, alpha   = 0.01, 
                 Letters = letters, 
                 adjust  = "tukey")

  # interaction 
  ph_i <- lsmeans(mymodel, pairwise ~ disturb_year:site, adjust = "tukey")
  
  # Objets for plot
  aux_ph_site <- as.data.frame(summary(ph_site$lsmeans)) 
  aux_ph_site <- aux_ph_site %>% mutate(var = resp_var)
  aux_ph_event <- as.data.frame(summary(ph_event$lsmeans)) 
  aux_ph_event <- aux_ph_event %>% mutate(var = resp_var)
  aux_ph_i <- as.data.frame(summary(ph_i$lsmeans)) 
  aux_ph_i <- aux_ph_i %>% mutate(var = resp_var)
  
  # Return objects
  cat('\n### Event ###\n')
  print(ph_event)
  print(cld_event)
  cat('\n### Clu pop ###\n')
  print(ph_site)
  print(cld_site)
  cat('\n### Event:Clu pop ###\n')
  print(ph_i)
  return(list(aux_ph_site, aux_ph_event, aux_ph_i))
}
```

``` r
vars <- c('disturb_year','site')
```

Recovery
--------

``` r
# Variable
resp_var <- 'rc'

# AOV
aov_rc <- aovas(re, vars=vars, resp_var = resp_var)
```

``` r
mc <- aov_rc$model_coeff

pander(mc, round=5,
       caption = paste0("ANOVA table: ", resp_var), missing = '', 
       emphasize.strong.cells = 
         which(mc < 0.1 & mc == mc$p.value, arr.ind = T))
```

<table style="width:85%;">
<caption>ANOVA table: rc</caption>
<colgroup>
<col width="25%" />
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
<td align="center">disturb_year</td>
<td align="center">2</td>
<td align="center">91.04</td>
<td align="center">45.52</td>
<td align="center">77.14</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="even">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">24.64</td>
<td align="center">12.32</td>
<td align="center">20.88</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="odd">
<td align="center">disturb_year:site</td>
<td align="center">4</td>
<td align="center">17.02</td>
<td align="center">4.255</td>
<td align="center">7.211</td>
<td align="center"><strong>3e-05</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">141</td>
<td align="center">83.21</td>
<td align="center">0.5901</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

``` r
gm <- aov_rc$model_summary

gm <- apply(gm, 1, formatC, digits = 2, format = "f") %>% t()
colnames(gm) <- paste0("$",c("R^2","\\mathrm{adj}R^2","\\sigma_e","F","p","df_m","\\mathrm{logLik}","AIC","BIC","\\mathrm{dev}","df_e"),"$")
rownames(gm) <- "Statistic"
pander(t(gm)) 
```

<table style="width:49%;">
<colgroup>
<col width="33%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center"> </th>
<th align="center">Statistic</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>R</em><sup>2</sup></span></strong></td>
<td align="center">0.61</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>a</em><em>d</em><em>j</em><em>R</em><sup>2</sup></span></strong></td>
<td align="center">0.59</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>σ</em><sub><em>e</em></sub></span></strong></td>
<td align="center">0.77</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>F</em></span></strong></td>
<td align="center">28.11</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>p</em></span></strong></td>
<td align="center">0.00</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>d</em><em>f</em><sub><em>m</em></sub></span></strong></td>
<td align="center">9.00</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>l</em><em>o</em><em>g</em><em>L</em><em>i</em><em>k</em></span></strong></td>
<td align="center">-168.65</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>A</em><em>I</em><em>C</em></span></strong></td>
<td align="center">357.29</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>B</em><em>I</em><em>C</em></span></strong></td>
<td align="center">387.40</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>d</em><em>e</em><em>v</em></span></strong></td>
<td align="center">83.21</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>d</em><em>f</em><sub><em>e</em></sub></span></strong></td>
<td align="center">141.00</td>
</tr>
</tbody>
</table>

### Post hoc comparison

``` r
# Post hoc Define model
mymodel <- aov_rc$mymodel
postH_rc <- phc(mymodel = mymodel, resp_var = resp_var)
```

    ## 
    ## ### Event ###
    ## $lsmeans
    ##  disturb_year    lsmean        SE  df  lower.CL upper.CL
    ##  1995         2.6025795 0.1096419 141 2.3858250 2.819334
    ##  2005         0.9460722 0.1096419 141 0.7293177 1.162827
    ##  2012         1.1643064 0.1096419 141 0.9475520 1.381061
    ## 
    ## Results are averaged over the levels of: site 
    ## Confidence level used: 0.95 
    ## 
    ## $contrasts
    ##  contrast      estimate       SE  df t.ratio p.value
    ##  1995 - 2005  1.6565073 0.155057 141  10.683  <.0001
    ##  1995 - 2012  1.4382730 0.155057 141   9.276  <.0001
    ##  2005 - 2012 -0.2182343 0.155057 141  -1.407  0.3398
    ## 
    ## Results are averaged over the levels of: site 
    ## P value adjustment: tukey method for comparing a family of 3 estimates 
    ## 
    ##  disturb_year    lsmean        SE  df  lower.CL upper.CL .group
    ##  2005         0.9460722 0.1096419 141 0.6811300 1.211014  a    
    ##  2012         1.1643064 0.1096419 141 0.8993643 1.429249  a    
    ##  1995         2.6025795 0.1096419 141 2.3376373 2.867522   b   
    ## 
    ## Results are averaged over the levels of: site 
    ## Confidence level used: 0.95 
    ## Conf-level adjustment: sidak method for 3 estimates 
    ## P value adjustment: tukey method for comparing a family of 3 estimates 
    ## significance level used: alpha = 0.01 
    ## 
    ## ### Clu pop ###
    ## $lsmeans
    ##  site   lsmean         SE  df  lower.CL upper.CL
    ##  SJ   2.107125 0.09917481 141 1.9110632 2.303187
    ##  caH  1.425855 0.11451720 141 1.1994624 1.652248
    ##  caL  1.179978 0.11451720 141 0.9535853 1.406371
    ## 
    ## Results are averaged over the levels of: disturb_year 
    ## Confidence level used: 0.95 
    ## 
    ## $contrasts
    ##  contrast   estimate        SE  df t.ratio p.value
    ##  SJ - caH  0.6812699 0.1514920 141   4.497  <.0001
    ##  SJ - caL  0.9271470 0.1514920 141   6.120  <.0001
    ##  caH - caL 0.2458771 0.1619518 141   1.518  0.2855
    ## 
    ## Results are averaged over the levels of: disturb_year 
    ## P value adjustment: tukey method for comparing a family of 3 estimates 
    ## 
    ##  site   lsmean         SE  df  lower.CL upper.CL .group
    ##  caL  1.179978 0.11451720 141 0.9032549 1.456701  a    
    ##  caH  1.425855 0.11451720 141 1.1491320 1.702578  a    
    ##  SJ   2.107125 0.09917481 141 1.8674758 2.346774   b   
    ## 
    ## Results are averaged over the levels of: disturb_year 
    ## Confidence level used: 0.95 
    ## Conf-level adjustment: sidak method for 3 estimates 
    ## P value adjustment: tukey method for comparing a family of 3 estimates 
    ## significance level used: alpha = 0.01 
    ## 
    ## ### Event:Clu pop ###
    ## $lsmeans
    ##  disturb_year site    lsmean        SE  df  lower.CL upper.CL
    ##  1995         SJ   3.7606678 0.1717758 141 3.4210788 4.100257
    ##  2005         SJ   1.1150292 0.1717758 141 0.7754402 1.454618
    ##  2012         SJ   1.4456780 0.1717758 141 1.1060890 1.785267
    ##  1995         caH  2.3069627 0.1983496 141 1.9148391 2.699086
    ##  2005         caH  0.8836738 0.1983496 141 0.4915502 1.275797
    ##  2012         caH  1.0869288 0.1983496 141 0.6948052 1.479052
    ##  1995         caL  1.7401079 0.1983496 141 1.3479843 2.132231
    ##  2005         caL  0.8395136 0.1983496 141 0.4473900 1.231637
    ##  2012         caL  0.9603126 0.1983496 141 0.5681890 1.352436
    ## 
    ## Confidence level used: 0.95 
    ## 
    ## $contrasts
    ##  contrast               estimate        SE  df t.ratio p.value
    ##  1995,SJ - 2005,SJ    2.64563863 0.2429277 141  10.891  <.0001
    ##  1995,SJ - 2012,SJ    2.31498982 0.2429277 141   9.530  <.0001
    ##  1995,SJ - 1995,caH   1.45370507 0.2623919 141   5.540  <.0001
    ##  1995,SJ - 2005,caH   2.87699401 0.2623919 141  10.964  <.0001
    ##  1995,SJ - 2012,caH   2.67373900 0.2623919 141  10.190  <.0001
    ##  1995,SJ - 1995,caL   2.02055992 0.2623919 141   7.701  <.0001
    ##  1995,SJ - 2005,caL   2.92115422 0.2623919 141  11.133  <.0001
    ##  1995,SJ - 2012,caL   2.80035525 0.2623919 141  10.672  <.0001
    ##  2005,SJ - 2012,SJ   -0.33064881 0.2429277 141  -1.361  0.9103
    ##  2005,SJ - 1995,caH  -1.19193356 0.2623919 141  -4.543  0.0004
    ##  2005,SJ - 2005,caH   0.23135538 0.2623919 141   0.882  0.9936
    ##  2005,SJ - 2012,caH   0.02810037 0.2623919 141   0.107  1.0000
    ##  2005,SJ - 1995,caL  -0.62507870 0.2623919 141  -2.382  0.3019
    ##  2005,SJ - 2005,caL   0.27551559 0.2623919 141   1.050  0.9800
    ##  2005,SJ - 2012,caL   0.15471662 0.2623919 141   0.590  0.9996
    ##  2012,SJ - 1995,caH  -0.86128475 0.2623919 141  -3.282  0.0342
    ##  2012,SJ - 2005,caH   0.56200419 0.2623919 141   2.142  0.4495
    ##  2012,SJ - 2012,caH   0.35874918 0.2623919 141   1.367  0.9081
    ##  2012,SJ - 1995,caL  -0.29442989 0.2623919 141  -1.122  0.9700
    ##  2012,SJ - 2005,caL   0.60616440 0.2623919 141   2.310  0.3432
    ##  2012,SJ - 2012,caL   0.48536543 0.2623919 141   1.850  0.6490
    ##  1995,caH - 2005,caH  1.42328894 0.2805087 141   5.074  <.0001
    ##  1995,caH - 2012,caH  1.22003393 0.2805087 141   4.349  0.0009
    ##  1995,caH - 1995,caL  0.56685486 0.2805087 141   2.021  0.5317
    ##  1995,caH - 2005,caL  1.46744915 0.2805087 141   5.231  <.0001
    ##  1995,caH - 2012,caL  1.34665019 0.2805087 141   4.801  0.0001
    ##  2005,caH - 2012,caH -0.20325501 0.2805087 141  -0.725  0.9984
    ##  2005,caH - 1995,caL -0.85643409 0.2805087 141  -3.053  0.0654
    ##  2005,caH - 2005,caL  0.04416021 0.2805087 141   0.157  1.0000
    ##  2005,caH - 2012,caL -0.07663876 0.2805087 141  -0.273  1.0000
    ##  2012,caH - 1995,caL -0.65317908 0.2805087 141  -2.329  0.3324
    ##  2012,caH - 2005,caL  0.24741522 0.2805087 141   0.882  0.9936
    ##  2012,caH - 2012,caL  0.12661625 0.2805087 141   0.451  1.0000
    ##  1995,caL - 2005,caL  0.90059430 0.2805087 141   3.211  0.0422
    ##  1995,caL - 2012,caL  0.77979533 0.2805087 141   2.780  0.1307
    ##  2005,caL - 2012,caL -0.12079897 0.2805087 141  -0.431  1.0000
    ## 
    ## P value adjustment: tukey method for comparing a family of 9 estimates

### Plots

``` r
#### ~ Site
ps <- plot(effect("site",mymodel))
#### ~ Disturb Year
pd <- plot(effect('disturb_year', mymodel))
#### Disturb Year:Site
picollapse <- plot(effect("disturb_year:site",mymodel), multiline = TRUE, ci.style = 'bars')
pi <- plot(effect("disturb_year:site",mymodel), layout=c(3,1))
```

``` r
ps
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-25-1.png)

``` r
pd
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-26-1.png)

``` r
picollapse
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-27-1.png)

``` r
pi
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-28-1.png)

Resistance
----------

``` r
# Variable
resp_var <- 'rt'

# AOV
aov_rt <- aovas(re, vars=vars, resp_var = resp_var)
```

``` r
mc <- aov_rt$model_coeff

pander(mc, round=5,
       caption = paste0("ANOVA table: ", resp_var), missing = '', 
       emphasize.strong.cells = 
         which(mc < 0.1 & mc == mc$p.value, arr.ind = T))
```

<table style="width:85%;">
<caption>ANOVA table: rt</caption>
<colgroup>
<col width="25%" />
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
<td align="center">disturb_year</td>
<td align="center">2</td>
<td align="center">1.143</td>
<td align="center">0.5713</td>
<td align="center">28.49</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="even">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">0.8879</td>
<td align="center">0.4439</td>
<td align="center">22.14</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="odd">
<td align="center">disturb_year:site</td>
<td align="center">4</td>
<td align="center">1.743</td>
<td align="center">0.4358</td>
<td align="center">21.74</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">141</td>
<td align="center">2.827</td>
<td align="center">0.02005</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

``` r
gm <- aov_rt$model_summary

gm <- apply(gm, 1, formatC, digits = 2, format = "f") %>% t()
colnames(gm) <- paste0("$",c("R^2","\\mathrm{adj}R^2","\\sigma_e","F","p","df_m","\\mathrm{logLik}","AIC","BIC","\\mathrm{dev}","df_e"),"$")
rownames(gm) <- "Statistic"
pander(t(gm)) 
```

<table style="width:49%;">
<colgroup>
<col width="33%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center"> </th>
<th align="center">Statistic</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>R</em><sup>2</sup></span></strong></td>
<td align="center">0.57</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>a</em><em>d</em><em>j</em><em>R</em><sup>2</sup></span></strong></td>
<td align="center">0.55</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>σ</em><sub><em>e</em></sub></span></strong></td>
<td align="center">0.14</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>F</em></span></strong></td>
<td align="center">23.53</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>p</em></span></strong></td>
<td align="center">0.00</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>d</em><em>f</em><sub><em>m</em></sub></span></strong></td>
<td align="center">9.00</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>l</em><em>o</em><em>g</em><em>L</em><em>i</em><em>k</em></span></strong></td>
<td align="center">85.01</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>A</em><em>I</em><em>C</em></span></strong></td>
<td align="center">-150.03</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>B</em><em>I</em><em>C</em></span></strong></td>
<td align="center">-119.92</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>d</em><em>e</em><em>v</em></span></strong></td>
<td align="center">2.83</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>d</em><em>f</em><sub><em>e</em></sub></span></strong></td>
<td align="center">141.00</td>
</tr>
</tbody>
</table>

### Post hoc comparison

``` r
# Post hoc Define model
mymodel <- aov_rt$mymodel
postH_rc <- phc(mymodel = mymodel, resp_var = resp_var)
```

    ## 
    ## ### Event ###
    ## $lsmeans
    ##  disturb_year    lsmean         SE  df  lower.CL  upper.CL
    ##  1995         0.5933021 0.02020965 141 0.5533490 0.6332552
    ##  2005         0.7483129 0.02020965 141 0.7083599 0.7882660
    ##  2012         0.8166033 0.02020965 141 0.7766502 0.8565564
    ## 
    ## Results are averaged over the levels of: site 
    ## Confidence level used: 0.95 
    ## 
    ## $contrasts
    ##  contrast       estimate         SE  df t.ratio p.value
    ##  1995 - 2005 -0.15501083 0.02858076 141  -5.424  <.0001
    ##  1995 - 2012 -0.22330118 0.02858076 141  -7.813  <.0001
    ##  2005 - 2012 -0.06829036 0.02858076 141  -2.389  0.0475
    ## 
    ## Results are averaged over the levels of: site 
    ## P value adjustment: tukey method for comparing a family of 3 estimates 
    ## 
    ##  disturb_year    lsmean         SE  df  lower.CL  upper.CL .group
    ##  1995         0.5933021 0.02020965 141 0.5444669 0.6421374  a    
    ##  2005         0.7483129 0.02020965 141 0.6994777 0.7971482   b   
    ##  2012         0.8166033 0.02020965 141 0.7677681 0.8654385   b   
    ## 
    ## Results are averaged over the levels of: site 
    ## Confidence level used: 0.95 
    ## Conf-level adjustment: sidak method for 3 estimates 
    ## P value adjustment: tukey method for comparing a family of 3 estimates 
    ## significance level used: alpha = 0.01 
    ## 
    ## ### Clu pop ###
    ## $lsmeans
    ##  site    lsmean         SE  df  lower.CL  upper.CL
    ##  SJ   0.6245302 0.01828031 141 0.5883913 0.6606691
    ##  caH  0.7248455 0.02110829 141 0.6831159 0.7665752
    ##  caL  0.8088426 0.02110829 141 0.7671130 0.8505722
    ## 
    ## Results are averaged over the levels of: disturb_year 
    ## Confidence level used: 0.95 
    ## 
    ## $contrasts
    ##  contrast     estimate         SE  df t.ratio p.value
    ##  SJ - caH  -0.10031531 0.02792364 141  -3.592  0.0013
    ##  SJ - caL  -0.18431239 0.02792364 141  -6.601  <.0001
    ##  caH - caL -0.08399708 0.02985163 141  -2.814  0.0154
    ## 
    ## Results are averaged over the levels of: disturb_year 
    ## P value adjustment: tukey method for comparing a family of 3 estimates 
    ## 
    ##  site    lsmean         SE  df  lower.CL  upper.CL .group
    ##  SJ   0.6245302 0.01828031 141 0.5803571 0.6687034  a    
    ##  caH  0.7248455 0.02110829 141 0.6738388 0.7758523   b   
    ##  caL  0.8088426 0.02110829 141 0.7578359 0.8598494   b   
    ## 
    ## Results are averaged over the levels of: disturb_year 
    ## Confidence level used: 0.95 
    ## Conf-level adjustment: sidak method for 3 estimates 
    ## P value adjustment: tukey method for comparing a family of 3 estimates 
    ## significance level used: alpha = 0.01 
    ## 
    ## ### Event:Clu pop ###
    ## $lsmeans
    ##  disturb_year site    lsmean         SE  df  lower.CL  upper.CL
    ##  1995         SJ   0.6456938 0.03166243 141 0.5830993 0.7082882
    ##  2005         SJ   0.4606116 0.03166243 141 0.3980172 0.5232061
    ##  2012         SJ   0.7672853 0.03166243 141 0.7046908 0.8298797
    ##  1995         caH  0.5351747 0.03656063 141 0.4628969 0.6074526
    ##  2005         caH  0.8845609 0.03656063 141 0.8122830 0.9568388
    ##  2012         caH  0.7548010 0.03656063 141 0.6825231 0.8270788
    ##  1995         caL  0.5990379 0.03656063 141 0.5267600 0.6713157
    ##  2005         caL  0.8997663 0.03656063 141 0.8274884 0.9720441
    ##  2012         caL  0.9277237 0.03656063 141 0.8554458 1.0000015
    ## 
    ## Confidence level used: 0.95 
    ## 
    ## $contrasts
    ##  contrast               estimate         SE  df t.ratio p.value
    ##  1995,SJ - 2005,SJ    0.18508210 0.04477744 141   4.133  0.0020
    ##  1995,SJ - 2012,SJ   -0.12159151 0.04477744 141  -2.715  0.1519
    ##  1995,SJ - 1995,caH   0.11051901 0.04836516 141   2.285  0.3582
    ##  1995,SJ - 2005,caH  -0.23886715 0.04836516 141  -4.939  0.0001
    ##  1995,SJ - 2012,caH  -0.10910721 0.04836516 141  -2.256  0.3761
    ##  1995,SJ - 1995,caL   0.04665589 0.04836516 141   0.965  0.9884
    ##  1995,SJ - 2005,caL  -0.25407253 0.04836516 141  -5.253  <.0001
    ##  1995,SJ - 2012,caL  -0.28202993 0.04836516 141  -5.831  <.0001
    ##  2005,SJ - 2012,SJ   -0.30667361 0.04477744 141  -6.849  <.0001
    ##  2005,SJ - 1995,caH  -0.07456309 0.04836516 141  -1.542  0.8338
    ##  2005,SJ - 2005,caH  -0.42394925 0.04836516 141  -8.766  <.0001
    ##  2005,SJ - 2012,caH  -0.29418931 0.04836516 141  -6.083  <.0001
    ##  2005,SJ - 1995,caL  -0.13842622 0.04836516 141  -2.862  0.1072
    ##  2005,SJ - 2005,caL  -0.43915464 0.04836516 141  -9.080  <.0001
    ##  2005,SJ - 2012,caL  -0.46711203 0.04836516 141  -9.658  <.0001
    ##  2012,SJ - 1995,caH   0.23211053 0.04836516 141   4.799  0.0001
    ##  2012,SJ - 2005,caH  -0.11727564 0.04836516 141  -2.425  0.2789
    ##  2012,SJ - 2012,caH   0.01248430 0.04836516 141   0.258  1.0000
    ##  2012,SJ - 1995,caL   0.16824740 0.04836516 141   3.479  0.0188
    ##  2012,SJ - 2005,caL  -0.13248102 0.04836516 141  -2.739  0.1438
    ##  2012,SJ - 2012,caL  -0.16043842 0.04836516 141  -3.317  0.0308
    ##  1995,caH - 2005,caH -0.34938616 0.05170453 141  -6.757  <.0001
    ##  1995,caH - 2012,caH -0.21962622 0.05170453 141  -4.248  0.0013
    ##  1995,caH - 1995,caL -0.06386313 0.05170453 141  -1.235  0.9473
    ##  1995,caH - 2005,caL -0.36459155 0.05170453 141  -7.051  <.0001
    ##  1995,caH - 2012,caL -0.39254894 0.05170453 141  -7.592  <.0001
    ##  2005,caH - 2012,caH  0.12975994 0.05170453 141   2.510  0.2364
    ##  2005,caH - 1995,caL  0.28552304 0.05170453 141   5.522  <.0001
    ##  2005,caH - 2005,caL -0.01520539 0.05170453 141  -0.294  1.0000
    ##  2005,caH - 2012,caL -0.04316278 0.05170453 141  -0.835  0.9956
    ##  2012,caH - 1995,caL  0.15576310 0.05170453 141   3.013  0.0729
    ##  2012,caH - 2005,caL -0.14496533 0.05170453 141  -2.804  0.1235
    ##  2012,caH - 2012,caL -0.17292272 0.05170453 141  -3.344  0.0284
    ##  1995,caL - 2005,caL -0.30072842 0.05170453 141  -5.816  <.0001
    ##  1995,caL - 2012,caL -0.32868582 0.05170453 141  -6.357  <.0001
    ##  2005,caL - 2012,caL -0.02795739 0.05170453 141  -0.541  0.9998
    ## 
    ## P value adjustment: tukey method for comparing a family of 9 estimates

### Plots

``` r
#### ~ Site
ps <- plot(effect("site",mymodel))
#### ~ Disturb Year
pd <- plot(effect('disturb_year', mymodel))
#### Disturb Year:Site
picollapse <- plot(effect("disturb_year:site",mymodel), multiline = TRUE, ci.style = 'bars')
pi <- plot(effect("disturb_year:site",mymodel), layout=c(3,1))
```

``` r
ps
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-34-1.png)

``` r
pd
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-35-1.png)

``` r
picollapse
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-36-1.png)

``` r
pi
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-37-1.png)

Relative Resilience
-------------------

``` r
# Variable
resp_var <- 'rrs'

# AOV
aov_rrs <- aovas(re, vars=vars, resp_var = resp_var)
```

``` r
mc <- aov_rrs$model_coeff

pander(mc, round=5,
       caption = paste0("ANOVA table: ", resp_var), missing = '', 
       emphasize.strong.cells = 
         which(mc < 0.1 & mc == mc$p.value, arr.ind = T))
```

<table style="width:85%;">
<caption>ANOVA table: rrs</caption>
<colgroup>
<col width="25%" />
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
<td align="center">disturb_year</td>
<td align="center">2</td>
<td align="center">30.1</td>
<td align="center">15.05</td>
<td align="center">108.7</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="even">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">9.83</td>
<td align="center">4.915</td>
<td align="center">35.5</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="odd">
<td align="center">disturb_year:site</td>
<td align="center">4</td>
<td align="center">5.868</td>
<td align="center">1.467</td>
<td align="center">10.6</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">141</td>
<td align="center">19.52</td>
<td align="center">0.1384</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

``` r
gm <- aov_rrs$model_summary

gm <- apply(gm, 1, formatC, digits = 2, format = "f") %>% t()
colnames(gm) <- paste0("$",c("R^2","\\mathrm{adj}R^2","\\sigma_e","F","p","df_m","\\mathrm{logLik}","AIC","BIC","\\mathrm{dev}","df_e"),"$")
rownames(gm) <- "Statistic"
pander(t(gm)) 
```

<table style="width:49%;">
<colgroup>
<col width="33%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center"> </th>
<th align="center">Statistic</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>R</em><sup>2</sup></span></strong></td>
<td align="center">0.70</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>a</em><em>d</em><em>j</em><em>R</em><sup>2</sup></span></strong></td>
<td align="center">0.68</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>σ</em><sub><em>e</em></sub></span></strong></td>
<td align="center">0.37</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>F</em></span></strong></td>
<td align="center">41.35</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>p</em></span></strong></td>
<td align="center">0.00</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>d</em><em>f</em><sub><em>m</em></sub></span></strong></td>
<td align="center">9.00</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>l</em><em>o</em><em>g</em><em>L</em><em>i</em><em>k</em></span></strong></td>
<td align="center">-59.91</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>A</em><em>I</em><em>C</em></span></strong></td>
<td align="center">139.81</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>B</em><em>I</em><em>C</em></span></strong></td>
<td align="center">169.92</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>d</em><em>e</em><em>v</em></span></strong></td>
<td align="center">19.52</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>d</em><em>f</em><sub><em>e</em></sub></span></strong></td>
<td align="center">141.00</td>
</tr>
</tbody>
</table>

### Post hoc comparison

``` r
# Post hoc Define model
mymodel <- aov_rrs$mymodel
postH_rc <- phc(mymodel = mymodel, resp_var = resp_var)
```

    ## 
    ## ### Event ###
    ## $lsmeans
    ##  disturb_year      lsmean         SE  df     lower.CL  upper.CL
    ##  1995          0.89895149 0.05310627 141  0.793964043 1.0039389
    ##  2005         -0.07268135 0.05310627 141 -0.177668799 0.0323061
    ##  2012          0.11047515 0.05310627 141  0.005487701 0.2154626
    ## 
    ## Results are averaged over the levels of: site 
    ## Confidence level used: 0.95 
    ## 
    ## $contrasts
    ##  contrast      estimate        SE  df t.ratio p.value
    ##  1995 - 2005  0.9716328 0.0751036 141  12.937  <.0001
    ##  1995 - 2012  0.7884763 0.0751036 141  10.499  <.0001
    ##  2005 - 2012 -0.1831565 0.0751036 141  -2.439  0.0420
    ## 
    ## Results are averaged over the levels of: site 
    ## P value adjustment: tukey method for comparing a family of 3 estimates 
    ## 
    ##  disturb_year      lsmean         SE  df    lower.CL   upper.CL .group
    ##  2005         -0.07268135 0.05310627 141 -0.20100905 0.05564635  a    
    ##  2012          0.11047515 0.05310627 141 -0.01785255 0.23880285  a    
    ##  1995          0.89895149 0.05310627 141  0.77062379 1.02727919   b   
    ## 
    ## Results are averaged over the levels of: site 
    ## Confidence level used: 0.95 
    ## Conf-level adjustment: sidak method for 3 estimates 
    ## P value adjustment: tukey method for comparing a family of 3 estimates 
    ## significance level used: alpha = 0.01 
    ## 
    ## ### Clu pop ###
    ## $lsmeans
    ##  site     lsmean         SE  df    lower.CL  upper.CL
    ##  SJ   0.65357791 0.04803643 141  0.55861318 0.7485426
    ##  caH  0.20766004 0.05546769 141  0.09800423 0.3173159
    ##  caL  0.07550735 0.05546769 141 -0.03414847 0.1851632
    ## 
    ## Results are averaged over the levels of: disturb_year 
    ## Confidence level used: 0.95 
    ## 
    ## $contrasts
    ##  contrast   estimate         SE  df t.ratio p.value
    ##  SJ - caH  0.4459179 0.07337685 141   6.077  <.0001
    ##  SJ - caL  0.5780706 0.07337685 141   7.878  <.0001
    ##  caH - caL 0.1321527 0.07844315 141   1.685  0.2146
    ## 
    ## Results are averaged over the levels of: disturb_year 
    ## P value adjustment: tukey method for comparing a family of 3 estimates 
    ## 
    ##  site     lsmean         SE  df    lower.CL  upper.CL .group
    ##  caL  0.07550735 0.05546769 141 -0.05852656 0.2095413  a    
    ##  caH  0.20766004 0.05546769 141  0.07362613 0.3416940  a    
    ##  SJ   0.65357791 0.04803643 141  0.53750114 0.7696547   b   
    ## 
    ## Results are averaged over the levels of: disturb_year 
    ## Confidence level used: 0.95 
    ## Conf-level adjustment: sidak method for 3 estimates 
    ## P value adjustment: tukey method for comparing a family of 3 estimates 
    ## significance level used: alpha = 0.01 
    ## 
    ## ### Event:Clu pop ###
    ## $lsmeans
    ##  disturb_year site      lsmean         SE  df   lower.CL   upper.CL
    ##  1995         SJ    1.60983933 0.08320153 141  1.4453556 1.77432305
    ##  2005         SJ    0.03528048 0.08320153 141 -0.1292032 0.19976421
    ##  2012         SJ    0.31561391 0.08320153 141  0.1511302 0.48009764
    ##  1995         caH   0.67490775 0.09607285 141  0.4849783 0.86483719
    ##  2005         caH  -0.11035142 0.09607285 141 -0.3002809 0.07957802
    ##  2012         caH   0.05842381 0.09607285 141 -0.1315056 0.24835325
    ##  1995         caL   0.41210741 0.09607285 141  0.2221780 0.60203685
    ##  2005         caL  -0.14297310 0.09607285 141 -0.3329025 0.04695635
    ##  2012         caL  -0.04261226 0.09607285 141 -0.2325417 0.14731718
    ## 
    ## Confidence level used: 0.95 
    ## 
    ## $contrasts
    ##  contrast               estimate        SE  df t.ratio p.value
    ##  1995,SJ - 2005,SJ    1.57455885 0.1176647 141  13.382  <.0001
    ##  1995,SJ - 2012,SJ    1.29422542 0.1176647 141  10.999  <.0001
    ##  1995,SJ - 1995,caH   0.93493158 0.1270924 141   7.356  <.0001
    ##  1995,SJ - 2005,caH   1.72019075 0.1270924 141  13.535  <.0001
    ##  1995,SJ - 2012,caH   1.55141552 0.1270924 141  12.207  <.0001
    ##  1995,SJ - 1995,caL   1.19773192 0.1270924 141   9.424  <.0001
    ##  1995,SJ - 2005,caL   1.75281243 0.1270924 141  13.792  <.0001
    ##  1995,SJ - 2012,caL   1.65245159 0.1270924 141  13.002  <.0001
    ##  2005,SJ - 2012,SJ   -0.28033343 0.1176647 141  -2.382  0.3018
    ##  2005,SJ - 1995,caH  -0.63962727 0.1270924 141  -5.033  0.0001
    ##  2005,SJ - 2005,caH   0.14563191 0.1270924 141   1.146  0.9659
    ##  2005,SJ - 2012,caH  -0.02314333 0.1270924 141  -0.182  1.0000
    ##  2005,SJ - 1995,caL  -0.37682692 0.1270924 141  -2.965  0.0826
    ##  2005,SJ - 2005,caL   0.17825358 0.1270924 141   1.403  0.8952
    ##  2005,SJ - 2012,caL   0.07789274 0.1270924 141   0.613  0.9995
    ##  2012,SJ - 1995,caH  -0.35929383 0.1270924 141  -2.827  0.1168
    ##  2012,SJ - 2005,caH   0.42596534 0.1270924 141   3.352  0.0278
    ##  2012,SJ - 2012,caH   0.25719010 0.1270924 141   2.024  0.5297
    ##  2012,SJ - 1995,caL  -0.09649349 0.1270924 141  -0.759  0.9977
    ##  2012,SJ - 2005,caL   0.45858701 0.1270924 141   3.608  0.0124
    ##  2012,SJ - 2012,caL   0.35822618 0.1270924 141   2.819  0.1192
    ##  1995,caH - 2005,caH  0.78525917 0.1358675 141   5.780  <.0001
    ##  1995,caH - 2012,caH  0.61648394 0.1358675 141   4.537  0.0004
    ##  1995,caH - 1995,caL  0.26280034 0.1358675 141   1.934  0.5914
    ##  1995,caH - 2005,caL  0.81788085 0.1358675 141   6.020  <.0001
    ##  1995,caH - 2012,caL  0.71752001 0.1358675 141   5.281  <.0001
    ##  2005,caH - 2012,caH -0.16877523 0.1358675 141  -1.242  0.9455
    ##  2005,caH - 1995,caL -0.52245883 0.1358675 141  -3.845  0.0055
    ##  2005,caH - 2005,caL  0.03262167 0.1358675 141   0.240  1.0000
    ##  2005,caH - 2012,caL -0.06773916 0.1358675 141  -0.499  0.9999
    ##  2012,caH - 1995,caL -0.35368360 0.1358675 141  -2.603  0.1947
    ##  2012,caH - 2005,caL  0.20139691 0.1358675 141   1.482  0.8620
    ##  2012,caH - 2012,caL  0.10103607 0.1358675 141   0.744  0.9980
    ##  1995,caL - 2005,caL  0.55508050 0.1358675 141   4.085  0.0023
    ##  1995,caL - 2012,caL  0.45471967 0.1358675 141   3.347  0.0282
    ##  2005,caL - 2012,caL -0.10036083 0.1358675 141  -0.739  0.9981
    ## 
    ## P value adjustment: tukey method for comparing a family of 9 estimates

### Plots

``` r
#### ~ Site
ps <- plot(effect("site",mymodel))
#### ~ Disturb Year
pd <- plot(effect('disturb_year', mymodel))
#### Disturb Year:Site
picollapse <- plot(effect("disturb_year:site",mymodel), multiline = TRUE, ci.style = 'bars')
pi <- plot(effect("disturb_year:site",mymodel), layout=c(3,1))
```

``` r
ps
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-43-1.png)

``` r
pd
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-44-1.png)

``` r
picollapse
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-45-1.png)

``` r
pi
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-46-1.png)

Resilience
----------

``` r
# Variable
resp_var <- 'rs'

# AOV
aov_rs <- aovas(re, vars=vars, resp_var = resp_var)
```

``` r
mc <- aov_rs$model_coeff

pander(mc, round=5,
       caption = paste0("ANOVA table: ", resp_var), missing = '', 
       emphasize.strong.cells = 
         which(mc < 0.1 & mc == mc$p.value, arr.ind = T))
```

<table style="width:85%;">
<caption>ANOVA table: rs</caption>
<colgroup>
<col width="25%" />
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
<td align="center">disturb_year</td>
<td align="center">2</td>
<td align="center">21.71</td>
<td align="center">10.86</td>
<td align="center">76.18</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="even">
<td align="center">site</td>
<td align="center">2</td>
<td align="center">4.972</td>
<td align="center">2.486</td>
<td align="center">17.44</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="odd">
<td align="center">disturb_year:site</td>
<td align="center">4</td>
<td align="center">12.62</td>
<td align="center">3.156</td>
<td align="center">22.14</td>
<td align="center"><strong>0</strong></td>
</tr>
<tr class="even">
<td align="center">Residuals</td>
<td align="center">141</td>
<td align="center">20.09</td>
<td align="center">0.1425</td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody>
</table>

``` r
gm <- aov_rs$model_summary

gm <- apply(gm, 1, formatC, digits = 2, format = "f") %>% t()
colnames(gm) <- paste0("$",c("R^2","\\mathrm{adj}R^2","\\sigma_e","F","p","df_m","\\mathrm{logLik}","AIC","BIC","\\mathrm{dev}","df_e"),"$")
rownames(gm) <- "Statistic"
pander(t(gm)) 
```

<table style="width:49%;">
<colgroup>
<col width="33%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center"> </th>
<th align="center">Statistic</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>R</em><sup>2</sup></span></strong></td>
<td align="center">0.66</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>a</em><em>d</em><em>j</em><em>R</em><sup>2</sup></span></strong></td>
<td align="center">0.64</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>σ</em><sub><em>e</em></sub></span></strong></td>
<td align="center">0.38</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>F</em></span></strong></td>
<td align="center">34.48</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>p</em></span></strong></td>
<td align="center">0.00</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>d</em><em>f</em><sub><em>m</em></sub></span></strong></td>
<td align="center">9.00</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>l</em><em>o</em><em>g</em><em>L</em><em>i</em><em>k</em></span></strong></td>
<td align="center">-62.08</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>A</em><em>I</em><em>C</em></span></strong></td>
<td align="center">144.16</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>B</em><em>I</em><em>C</em></span></strong></td>
<td align="center">174.26</td>
</tr>
<tr class="even">
<td align="center"><strong><span class="math inline"><em>d</em><em>e</em><em>v</em></span></strong></td>
<td align="center">20.09</td>
</tr>
<tr class="odd">
<td align="center"><strong><span class="math inline"><em>d</em><em>f</em><sub><em>e</em></sub></span></strong></td>
<td align="center">141.00</td>
</tr>
</tbody>
</table>

### Post hoc comparison

``` r
# Post hoc Define model
mymodel <- aov_rs$mymodel
postH_rc <- phc(mymodel = mymodel, resp_var = resp_var)
```

    ## 
    ## ### Event ###
    ## $lsmeans
    ##  disturb_year    lsmean         SE  df  lower.CL  upper.CL
    ##  1995         1.4922536 0.05388052 141 1.3857355 1.5987717
    ##  2005         0.6756316 0.05388052 141 0.5691135 0.7821497
    ##  2012         0.9270785 0.05388052 141 0.8205604 1.0335965
    ## 
    ## Results are averaged over the levels of: site 
    ## Confidence level used: 0.95 
    ## 
    ## $contrasts
    ##  contrast      estimate         SE  df t.ratio p.value
    ##  1995 - 2005  0.8166220 0.07619856 141  10.717  <.0001
    ##  1995 - 2012  0.5651752 0.07619856 141   7.417  <.0001
    ##  2005 - 2012 -0.2514469 0.07619856 141  -3.300  0.0035
    ## 
    ## Results are averaged over the levels of: site 
    ## P value adjustment: tukey method for comparing a family of 3 estimates 
    ## 
    ##  disturb_year    lsmean         SE  df  lower.CL  upper.CL .group
    ##  2005         0.6756316 0.05388052 141 0.5454330 0.8058302  a    
    ##  2012         0.9270785 0.05388052 141 0.7968798 1.0572771   b   
    ##  1995         1.4922536 0.05388052 141 1.3620550 1.6224522    c  
    ## 
    ## Results are averaged over the levels of: site 
    ## Confidence level used: 0.95 
    ## Conf-level adjustment: sidak method for 3 estimates 
    ## P value adjustment: tukey method for comparing a family of 3 estimates 
    ## significance level used: alpha = 0.01 
    ## 
    ## ### Clu pop ###
    ## $lsmeans
    ##  site    lsmean         SE  df  lower.CL  upper.CL
    ##  SJ   1.2781081 0.04873676 141 1.1817589 1.3744574
    ##  caH  0.9325056 0.05627636 141 0.8212511 1.0437601
    ##  caL  0.8843500 0.05627636 141 0.7730954 0.9956045
    ## 
    ## Results are averaged over the levels of: disturb_year 
    ## Confidence level used: 0.95 
    ## 
    ## $contrasts
    ##  contrast    estimate         SE  df t.ratio p.value
    ##  SJ - caH  0.34560255 0.07444663 141   4.642  <.0001
    ##  SJ - caL  0.39375817 0.07444663 141   5.289  <.0001
    ##  caH - caL 0.04815562 0.07958680 141   0.605  0.8176
    ## 
    ## Results are averaged over the levels of: disturb_year 
    ## P value adjustment: tukey method for comparing a family of 3 estimates 
    ## 
    ##  site    lsmean         SE  df  lower.CL upper.CL .group
    ##  caL  0.8843500 0.05627636 141 0.7483619 1.020338  a    
    ##  caH  0.9325056 0.05627636 141 0.7965175 1.068494  a    
    ##  SJ   1.2781081 0.04873676 141 1.1603390 1.395877   b   
    ## 
    ## Results are averaged over the levels of: disturb_year 
    ## Confidence level used: 0.95 
    ## Conf-level adjustment: sidak method for 3 estimates 
    ## P value adjustment: tukey method for comparing a family of 3 estimates 
    ## significance level used: alpha = 0.01 
    ## 
    ## ### Event:Clu pop ###
    ## $lsmeans
    ##  disturb_year site    lsmean         SE  df  lower.CL  upper.CL
    ##  1995         SJ   2.2555331 0.08441455 141 2.0886513 2.4224149
    ##  2005         SJ   0.4958921 0.08441455 141 0.3290104 0.6627739
    ##  2012         SJ   1.0828992 0.08441455 141 0.9160174 1.2497809
    ##  1995         caH  1.2100825 0.09747352 141 1.0173840 1.4027810
    ##  2005         caH  0.7742095 0.09747352 141 0.5815110 0.9669080
    ##  2012         caH  0.8132248 0.09747352 141 0.6205263 1.0059232
    ##  1995         caL  1.0111453 0.09747352 141 0.8184468 1.2038437
    ##  2005         caL  0.7567932 0.09747352 141 0.5640947 0.9494917
    ##  2012         caL  0.8851114 0.09747352 141 0.6924129 1.0778099
    ## 
    ## Confidence level used: 0.95 
    ## 
    ## $contrasts
    ##  contrast               estimate        SE  df t.ratio p.value
    ##  1995,SJ - 2005,SJ    1.75964095 0.1193802 141  14.740  <.0001
    ##  1995,SJ - 2012,SJ    1.17263391 0.1193802 141   9.823  <.0001
    ##  1995,SJ - 1995,caH   1.04545060 0.1289454 141   8.108  <.0001
    ##  1995,SJ - 2005,caH   1.48132360 0.1289454 141  11.488  <.0001
    ##  1995,SJ - 2012,caH   1.44230831 0.1289454 141  11.185  <.0001
    ##  1995,SJ - 1995,caL   1.24438781 0.1289454 141   9.651  <.0001
    ##  1995,SJ - 2005,caL   1.49873989 0.1289454 141  11.623  <.0001
    ##  1995,SJ - 2012,caL   1.37042166 0.1289454 141  10.628  <.0001
    ##  2005,SJ - 2012,SJ   -0.58700705 0.1193802 141  -4.917  0.0001
    ##  2005,SJ - 1995,caH  -0.71419036 0.1289454 141  -5.539  <.0001
    ##  2005,SJ - 2005,caH  -0.27831735 0.1289454 141  -2.158  0.4386
    ##  2005,SJ - 2012,caH  -0.31733264 0.1289454 141  -2.461  0.2603
    ##  2005,SJ - 1995,caL  -0.51525314 0.1289454 141  -3.996  0.0032
    ##  2005,SJ - 2005,caL  -0.26090106 0.1289454 141  -2.023  0.5299
    ##  2005,SJ - 2012,caL  -0.38921929 0.1289454 141  -3.018  0.0718
    ##  2012,SJ - 1995,caH  -0.12718331 0.1289454 141  -0.986  0.9866
    ##  2012,SJ - 2005,caH   0.30868970 0.1289454 141   2.394  0.2955
    ##  2012,SJ - 2012,caH   0.26967441 0.1289454 141   2.091  0.4834
    ##  2012,SJ - 1995,caL   0.07175391 0.1289454 141   0.556  0.9998
    ##  2012,SJ - 2005,caL   0.32610599 0.1289454 141   2.529  0.2273
    ##  2012,SJ - 2012,caL   0.19778776 0.1289454 141   1.534  0.8376
    ##  1995,caH - 2005,caH  0.43587301 0.1378484 141   3.162  0.0484
    ##  1995,caH - 2012,caH  0.39685772 0.1378484 141   2.879  0.1028
    ##  1995,caH - 1995,caL  0.19893722 0.1378484 141   1.443  0.8790
    ##  1995,caH - 2005,caL  0.45328930 0.1378484 141   3.288  0.0336
    ##  1995,caH - 2012,caL  0.32497107 0.1378484 141   2.357  0.3158
    ##  2005,caH - 2012,caH -0.03901529 0.1378484 141  -0.283  1.0000
    ##  2005,caH - 1995,caL -0.23693579 0.1378484 141  -1.719  0.7340
    ##  2005,caH - 2005,caL  0.01741629 0.1378484 141   0.126  1.0000
    ##  2005,caH - 2012,caL -0.11090194 0.1378484 141  -0.805  0.9966
    ##  2012,caH - 1995,caL -0.19792050 0.1378484 141  -1.436  0.8820
    ##  2012,caH - 2005,caL  0.05643158 0.1378484 141   0.409  1.0000
    ##  2012,caH - 2012,caL -0.07188665 0.1378484 141  -0.521  0.9999
    ##  1995,caL - 2005,caL  0.25435208 0.1378484 141   1.845  0.6521
    ##  1995,caL - 2012,caL  0.12603385 0.1378484 141   0.914  0.9918
    ##  2005,caL - 2012,caL -0.12831823 0.1378484 141  -0.931  0.9908
    ## 
    ## P value adjustment: tukey method for comparing a family of 9 estimates

### Plots

``` r
#### ~ Site
ps <- plot(effect("site",mymodel))
#### ~ Disturb Year
pd <- plot(effect('disturb_year', mymodel))
#### Disturb Year:Site
picollapse <- plot(effect("disturb_year:site",mymodel), multiline = TRUE, ci.style = 'bars')
pi <- plot(effect("disturb_year:site",mymodel), layout=c(3,1))
```

``` r
ps
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-52-1.png)

``` r
pd
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-53-1.png)

``` r
picollapse
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-54-1.png)

``` r
pi
```

![](analysis_resilience_bai_files/figure-markdown_github/unnamed-chunk-55-1.png)

References
==========

Piovesa, G., F. Biondi, A. D. Filippo, A. Alessandrini, and M. Maugeri. 2008. Drought-driven growth reduction in old beech (fagus sylvatica l.) forests of the central apennines, italy. Global Change Biology 14:1265–1281.
