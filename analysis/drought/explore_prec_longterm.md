``` r
source(here::here('script/R', 'hydro_year.R'))
```

``` r
ltdf <- read.csv(file=here::here('data_raw/meteo/', 'long_term_data_rediam_data.txt'), header=T, sep=';', dec=',')

ltdf <- ltdf %>% 
  dplyr::select(cod = INDICATIVO, VARIABLE, FECHA, VALOR) %>% 
  dplyr::mutate(fecha = as.Date(FECHA, format='%d/%m/%Y'),
         month = lubridate::month(fecha),
         hmonth = ifelse(month <= 8, month + 4, month -8), 
         hyear = hydro_year(fecha),
         hyear_f = paste0(hyear-1,'-', hyear))


st5514 <- ltdf %>% 
  filter(VARIABLE == 'PM1') %>% 
  filter(cod == '5514') %>% 
  filter(hyear >= 1950) %>% 
  dplyr::select(fecha, month, hmonth, hyear, hyear_f, pre=VALOR)


df <- st5514 %>% 
  group_by(hyear_f) %>% 
  dplyr::mutate(csum = cumsum(pre)) %>% 
  filter(hmonth == 12) %>% 
  dplyr::select(-month, -pre, -fecha) %>% as.data.frame()

meandf <- mean(df$csum)
sddf <- sd(df$csum)


prec_hydrol <- ggplot(df, aes(x=hyear, y=csum)) + 
  geom_point() + theme_bw() + 
  geom_hline(yintercept = meandf) + 
  geom_hline(yintercept = meandf + 2*sddf, color ='blue', linetype = 'dashed') +
  geom_hline(yintercept = meandf - 2*sddf, color ='red', linetype = 'dashed') +
    geom_hline(yintercept = meandf + 1*sddf, color ='blue', linetype = 'dotted') +
  geom_hline(yintercept = meandf  - 1*sddf, color ='red', linetype = 'dotted') +
  scale_x_continuous(breaks=seq(1950,2020, by=5)) +
  geom_text_repel(
    data = subset(df, csum < (meandf - 1*sddf)),
    aes(label = hyear)) +
  ylab('Cumulative prec (hydrological year)')

pdf(here::here('/out/precipitation_2sd', 'prec_hydrol.pdf'), width=12, height = 9)
prec_hydrol
dev.off()
```

    ## quartz_off_screen 
    ##                 2

``` r
df2sd <- df %>% filter(csum < (meandf - 2*sddf)) %>% as.data.frame()
pander(df2sd)
```

    ## Error in eval(expr, envir, enclos): could not find function "pander"

``` r
write.csv(df2sd, here::here("/data/sequias", "prec19502012_2sd.csv"), row.names = FALSE)

df1sd <- df %>% filter(csum < (meandf - 1*sddf)) %>% as.data.frame()
pander(df1sd)
```

    ## Error in eval(expr, envir, enclos): could not find function "pander"

``` r
write.csv(df1sd, here::here("/data/sequias", "prec19502012_1sd.csv"), row.names = FALSE)
```
