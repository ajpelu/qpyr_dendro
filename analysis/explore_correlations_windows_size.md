-   [Filter data](#filter-data)
-   [BAI](#bai)
-   [EVI](#evi)
-   [RWI](#rwi)

Filter data
===========

``` r
library("tidyverse")
library("ggcorrplot")
library("gridExtra")
```

``` r
# Read correlation tables of BAI from: ../analysis/analysis_resilience_bai.md 
# sj 
corBai <- read.csv(file=paste0(di, '/out/correla_resilience/correla_window_size.csv'), header = TRUE)
corEvi <- read.csv(file=paste0(di, '/out/correla_resilience/correla_window_size_evi.csv'), header = TRUE)
corRwi <- read.csv(file=paste0(di, '/out/correla_resilience/correla_window_size_rwi.csv'), header = TRUE)
```

``` r
# Genera correlations matrix 

generaMatrix <- function(cordf, variable){ 
  m <- cordf %>% filter(var == variable) %>% 
    dplyr::select(-var, -window_size) %>% 
    mutate(w1 = c(2, 2, 3), 
           w2 = c(3,4,4)) 
  mf <- m %>% 
    dplyr::select(r2, w2, w1) %>% rename(w1 = w2, w2 = w1)
  
  df <- m %>% rbind(mf) %>% 
    add_row(r2 = 1, w1=2, w2=2) %>% 
    add_row(r2 = 1, w1=3, w2=3) %>% 
    add_row(r2 = 1, w1=4, w2=4) 
  
    df <- df %>% 
    mutate(w1 = case_when(
      w1 == 2 ~ 'ws2',
      w1 == 3 ~ 'ws3',
      w1 == 4 ~ 'ws4'),
      w2 = case_when(
      w2 == 2 ~ 'ws2',
      w2 == 3 ~ 'ws3',
      w2 == 4 ~ 'ws4'))

      cor_df <- as.data.frame.matrix(xtabs(r2 ~., df))

return(cor_df)
}
```

BAI
===

``` r
cor_rt <- generaMatrix(corBai, 'rt')
cor_rc <- generaMatrix(corBai, 'rc')
cor_rs <- generaMatrix(corBai, 'rs')
cor_rrs <- generaMatrix(corBai, 'rrs')
```

``` r
g_rt <- ggcorrplot(cor_rt, type='upper', lab=TRUE, title='BAI Rt', show.legend = FALSE)
g_rc <- ggcorrplot(cor_rc, type='upper', lab=TRUE, title='BAI Rc', show.legend = FALSE)
g_rs <- ggcorrplot(cor_rs, type='upper', lab=TRUE, title='BAI Rs', show.legend = FALSE)
g_rrs <- ggcorrplot(cor_rrs, type='upper', lab=TRUE, title='BAI RRs', show.legend = TRUE)
```

``` r
grid.arrange(g_rt, g_rc, g_rs, g_rrs)
```

![](explore_correlations_windows_size_files/figure-markdown_github/correla_window_bai-1.png)

EVI
===

``` r
cor_rte <- generaMatrix(corEvi, 'rt')
cor_rce <- generaMatrix(corEvi, 'rc')
cor_rse <- generaMatrix(corEvi, 'rs')
cor_rrse <- generaMatrix(corEvi, 'rrs')
```

``` r
g_rte <- ggcorrplot(cor_rte, type='upper', lab=TRUE, title='EVI Rt', show.legend = FALSE)
g_rce <- ggcorrplot(cor_rce, type='upper', lab=TRUE, title='EVI Rc', show.legend = FALSE)
g_rse <- ggcorrplot(cor_rse, type='upper', lab=TRUE, title='EVI Rs', show.legend = FALSE)
g_rrse <- ggcorrplot(cor_rrse, type='upper', lab=TRUE, title='EVI RRs', show.legend = TRUE)
```

``` r
grid.arrange(g_rte, g_rce, g_rse, g_rrse)
```

![](explore_correlations_windows_size_files/figure-markdown_github/correla_window_evi-1.png)

RWI
===

``` r
cor_rte <- generaMatrix(corRwi, 'rt')
cor_rce <- generaMatrix(corRwi, 'rc')
cor_rse <- generaMatrix(corRwi, 'rs')
cor_rrse <- generaMatrix(corRwi, 'rrs')
```

``` r
g_rte <- ggcorrplot(cor_rte, type='upper', lab=TRUE, title='RWI Rt', show.legend = FALSE)
g_rce <- ggcorrplot(cor_rce, type='upper', lab=TRUE, title='RWI Rc', show.legend = FALSE)
g_rse <- ggcorrplot(cor_rse, type='upper', lab=TRUE, title='RWI Rs', show.legend = FALSE)
g_rrse <- ggcorrplot(cor_rrse, type='upper', lab=TRUE, title='RWI RRs', show.legend = TRUE)
```

``` r
grid.arrange(g_rte, g_rce, g_rse, g_rrse)
```

![](explore_correlations_windows_size_files/figure-markdown_github/correla_window_rwi-1.png)
