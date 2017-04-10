``` r
library("tidyverse")
library("dplR")
```

Read data
=========

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
    ## There is 1 series
    ## 1        SNA0101      2014    2016   0.01

Algunos árboles tienen 3 cores. Sin embargo, no los tres cores llegan hasta la corteza, por lo tanto, no podemos utilizar el diametro para estimar bai. Vamos a realizar lo siguiente:

-   Crear dos datasets:
    -   Dataset con series de datos que llegan hasta corteza (`sj_cor`)
    -   Dataset con series de datos que no llegan hasta corteza (`sj_sin`): se trata de cores que no llegan hasta la corteza.
-   Para el cálculo del BAI, en el dataset `sj` utilizamos el diámetro medido en campo. En el caso del dataset `sj_sin` utilizamos la suma de todos los diámetros (:red\_circle: `$TODO$ ASK to Guillermo`)

``` r
# Get summary ring-width series
sj_summ <- summary(sj)

# Get names cores with last year different to 2016 
id_cores_no_bark <- sj_summ %>% 
  filter(last != 2016) %>% select(series) %>% mutate(series = factor(series)) 

id_cores_no_bark <- unname(unlist(id_cores_no_bark))

# Subbet datasets 
sj_cor <- sj[which(! colnames(sj) %in% (id_cores_no_bark))]
sj_sin <- sj[which(colnames(sj) %in% (id_cores_no_bark))]
```

Lectura y preparación de datos de diámetro

``` r
compete <- read.csv(file=paste0(di, '/data_raw/dendro_competence.csv'), header=TRUE, sep=',')

# Compute diameter (mm)
compete <- compete %>% 
  mutate(dn_mm = (perim_mm / pi))
         
# Get only focal trees, and only selected variables 
ft <- compete %>% 
  filter(sp=='Focal') %>% 
  filter(id_focal!='Fresno') %>% 
  select(id_focal, loc, dn_mm, height_cm)

# Select only SJ trees and 
ft_sj <- ft %>% filter(loc=='SJ')


# get Create a dataframe with core ID
cores <- data.frame(id_cores=colnames(sj))

# Extract replicate and Tree ID from core ID 
cores <- cores %>% 
  mutate(id_focal = as.factor(stringr::str_sub(id_cores, 3,5)),
         id_replica = stringr::str_sub(id_cores, 6,8))

# Create df with diameter and height for each core ID 
diam_cores <- cores %>% inner_join(ft_sj, by='id_focal') %>% 
  select(id_cores, dn_mm)
```

    ## Warning in inner_join_impl(x, y, by$x, by$y, suffix$x, suffix$y): joining
    ## factors with different levels, coercing to character vector

``` r
# remove diamm of cores without bark 
diam_cores_sj <- diam_cores %>% filter(! id_cores %in% id_cores_no_bark)
```

Cómputo del BAI
---------------

He construido una funcion para el computo del BAI, teniendo en cuenta la aproximación de (Piovesa et al. 2008)

``` r
## BAI Function Piovesan 

i <- "SNA0101"

bai_piovesan <- function(rwdf, diam_df){
  # rwdf: a ringwidth dataframe. row: years; col: id_cores
  # diam_df: a dataframe with diameter and id_core (two columns) 
  
  # Output 
  bai <- rwdf 
  
  # length years in Ring-width Data frame 
  vec_ly <- seq_len(nrow(rwdf))

  # ID cores 
  cores <- colnames(rwdf)
  
  for (i in cores){ 
    # 1 # Select core 
    id_core <- i 
    
    # 2 # Select serie 
    rs <- rwdf[[id_core]]
    
    # 3 # Select diameter 
    dbh <- subset(diam_df, id_cores == id_core)
    dbh <- dbh[,2]
    
    # 4 # Prepare data to compute bai 
    #### Omit NA 
    rsomit <- na.omit(rs)
    
    #### Revert w 
    rs_rev <- rev(rsomit)
    
    # Cumsum rever w
    # cum_rs_rev <- cumsum(rs_rev)
    cum_rs_rev <- c(0, cumsum(rs_rev))
    
    # Compute d_{t} 
    d <- dbh - 2*cum_rs_rev
    
    # Remove last element 
    d <- d[-length(d)]
    
    # Bai
    b <- rev((pi/4) * ((d)^2 - (d - 2*rs_rev)^2))
 
    # Store BAI and NA 
    ### Which elements are NA? 
    na <- attributes(rsomit)$na.action
    ### Which ones no? 
    no_na <- vec_ly[!vec_ly %in% na]
    ### Put bai in those element with no NA
    bai[no_na, i] <- b 
  }
  bai 
}




# Test 
b_test_piovesan <- bai_piovesan(rwdf = sj_cor, diam_df = diam_cores_sj)
b_test_dplR <- bai.out(rwl = sj_cor, diam = diam_cores_sj)
```

Piovesa, G., F. Biondi, A. D. Filippo, A. Alessandrini, and M. Maugeri. 2008. Drought-driven growth reduction in old beech (fagus sylvatica l.) forests of the central apennines, italy. Global Change Biology 14:1265–1281.
