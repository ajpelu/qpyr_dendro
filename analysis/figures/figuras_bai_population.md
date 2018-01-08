``` r
machine <- 'ajpelu'
# machine <- 'ajpeluLap'
di <- paste0('/Users/', machine, '/Dropbox/phd/phd_repos/qpyr_dendro/', sep = '')
```

Read and prepare data
=====================

``` r
crono <- read.csv(file=paste(di, "data/cronos_medias/cronos_sites.csv", sep=""), header=TRUE, sep=',')
pop <- read.csv(file=paste0(di, "data_raw/population/demography.csv"), header = TRUE)
```

``` r
year_select <- c(1842, 1857, 1860, 1877, 1887, 1897, 1900, 1910, 1920, 1930, 1940, 1950, 1960, 1970, 1981, 1991, 1996, 2000, 2005, 2010, 2015)
pop <- pop %>% filter(year %in% year_select)
```

Pop SJ
======

``` r
pop_sj <- crono %>% filter(site == 'SJ') %>%  
  ggplot(aes(x=year, y=bai_mean/100)) +
  theme_bw() + ylab('BAI') + 
  theme(panel.grid = element_blank(),
        legend.position = c(0.1,.8),
        strip.background = element_blank()) +
  geom_bar(data = pop, aes(x=year, y=gu / 1500), stat = 'identity', fill="#ABABAB") + 
  geom_ribbon(aes(ymin = (bai_mean - bai_se)/100,
                  ymax = (bai_mean + bai_se)/100,
                  fill=site), alpha=.6, colour=NA) +
  geom_line(aes(color = site), size=1) + 
  scale_y_continuous(sec.axis = sec_axis(~ .*1500, name = '# inhabitants', breaks = c(0,1500, 3000, 4500))) +
  scale_colour_manual(values = '#7570b3') +
  scale_fill_manual(values = '#7570b3')
pop_sj
```

![](figuras_bai_population_files/figure-markdown_github/population_bai_sj-1.png)

``` r
fileplot <- paste0(di, '/out/bai_population/bai_pop_sj.pdf') 
ggsave(filename=fileplot, plot=pop_sj, width=12, height = 5)
pop_sj
```

![](figuras_bai_population_files/figure-markdown_github/unnamed-chunk-4-1.png)

``` r
dev.off()
```

    ## null device 
    ##           1

Pop CA
======

``` r
pop_ca <- crono %>% filter(site != 'SJ') %>%  
  ggplot(aes(x=year, y=bai_mean/100)) +
  theme_bw() + ylab('BAI') + 
  theme(panel.grid = element_blank(),
        legend.position = c(0.1,.8),
        strip.background = element_blank()) +
  geom_bar(data = pop, aes(x=year, y=ca / 300), stat = 'identity', fill="#ABABAB") + 
  geom_ribbon(aes(ymin = (bai_mean - bai_se)/100,
                  ymax = (bai_mean + bai_se)/100,
                  fill=site), alpha=.6, colour=NA) +
  geom_line(aes(color = site), size=1) + 
  scale_y_continuous(sec.axis = sec_axis(~ .*300, name = '# inhabitants', breaks = c(0,500, 1000))) +
  scale_colour_manual(values = c('#e7298a','#1b9e77')) +
  scale_fill_manual(values = c('#e7298a','#1b9e77')) 
```

``` r
fileplot <- paste0(di, '/out/bai_population/bai_pop_ca.pdf') 
ggsave(filename=fileplot, plot=pop_ca, width=12, height = 5)
pop_ca
```

![](figuras_bai_population_files/figure-markdown_github/unnamed-chunk-5-1.png)

``` r
dev.off()
```

    ## null device 
    ##           1
