``` r
# library("plyr")
# library('dplyr')
library("scales")
library('tidyverse')
```

Trajectories EVI mean
=====================

``` r
# Read data
evi <- read.csv(file=paste(di, "/data/evi/evi_mean.csv", sep=""), header = TRUE, sep = ',')


evi <- evi %>% 
  mutate(
    clu_pop = as.factor(case_when(
      pop == 1 ~ "Camarate",
      pop %in% c(2,3,4,5) ~ 'Northern slope',
      pop %in% c(6,7,8) ~ 'Southern slope',
      pop == 9 ~ 'out')),
    clu_pop2 = as.factor(case_when(
      pop %in% c(1,2,3,4,5) ~ 'Northern slope',
      pop %in% c(6,7,8) ~ 'Southern slope',
      pop == 9 ~ 'out'))) %>% 
  filter(clu_pop != 'out')
```

global
------

``` r
traj <- evi %>% dplyr::group_by(pop, year) %>% 
  dplyr::summarise(mean = mean(evi),
            sd = sd(evi))

traj_mean <- traj %>% 
  group_by(year) %>% 
  dplyr::summarise(meanOfmean = mean(mean), 
            sdOfmean = sd(mean),
            seOfmean = sdOfmean/sqrt(length(mean)),
            meanOfsd = mean(sd),
            sdOfsd = sd(sd),
            seOfsd = sdOfsd /sqrt(length(sd))) %>% 
  as.data.frame()


traj_plot <- traj_mean %>% 
  ggplot(aes(x=meanOfmean, y=meanOfsd, label=year)) +
  geom_errorbar(aes(ymin=meanOfsd - seOfsd, ymax=meanOfsd + seOfsd)) + 
  geom_errorbarh(aes(xmin=meanOfmean - seOfmean, xmax=meanOfmean + seOfmean)) + 
  geom_path(colour='gray') +
  geom_point(size=3, shape=21, fill='white') + 
  geom_text(hjust = 0.001, nudge_x = 0.001) + 
  geom_vline(aes(xintercept = mean(meanOfmean)), colour='red') +
  geom_hline(aes(yintercept = mean(meanOfsd)), colour ='red')+
  theme_bw() + xlab('mean') + ylab('variance') + 
  theme(strip.background = element_rect(fill = "white"), 
        legend.position="none") 

traj_plot 
```

![](explore_evi_mean_files/figure-markdown_github/trajectories_evi-1.png)

``` r
pdf(file=paste0(di, "/out/trajectories/plot_trajectories_evi.pdf"), height = 6, width =6)
traj_plot
dev.off()
```

    ## quartz_off_screen 
    ##                 2

by cluster pop
--------------

``` r
traj_mean_pop <- traj %>% 
  mutate(clu_pop = as.factor(ifelse(pop %in% c(1,2,3,4,5), 'N', 'S'))) %>% 
  group_by(clu_pop,year) %>% 
  dplyr::summarise(meanOfmean = mean(mean), 
            sdOfmean = sd(mean),
            seOfmean = sdOfmean/sqrt(length(mean)),
            meanOfsd = mean(sd),
            sdOfsd = sd(sd),
            seOfsd = sdOfsd /sqrt(length(sd))) %>%
  as.data.frame() 

line_traj_mean_pop <- traj_mean_pop %>% 
  group_by(clu_pop) %>% 
  dplyr::summarise(
    meanOfmean = mean(meanOfmean), 
    meanOfsd = mean(meanOfsd)
  )


traj_plot_pop <- ggplot(traj_mean_pop,
  aes(x=meanOfmean, y=meanOfsd, label=year)) +
  geom_errorbar(aes(ymin=meanOfsd - seOfsd, ymax=meanOfsd + seOfsd)) + 
  geom_errorbarh(aes(xmin=meanOfmean - seOfmean, xmax=meanOfmean + seOfmean)) + 
  geom_path(colour='gray') +
  geom_point(size=3, shape=21, fill='white') +
  geom_text(hjust = 0.001, nudge_x = 0.001) + 
  facet_wrap(~clu_pop) +
  theme_bw() + xlab('mean') + ylab('variance') + 
  theme(strip.background = element_rect(fill = "white"), 
        legend.position="none") 

traj_plot_pop <- 
  traj_plot_pop + 
  geom_vline(aes(xintercept = meanOfmean), line_traj_mean_pop,  colour='red') +
  geom_hline(aes(yintercept = meanOfsd), line_traj_mean_pop, colour ='red') 

traj_plot_pop
```

![](explore_evi_mean_files/figure-markdown_github/trajectories_evi_clu-1.png)

``` r
pdf(file=paste0(di, "/out/trajectories/plot_trajectories_evi_clu.pdf"), height = 6, width =10)
traj_plot_pop
dev.off()
```

    ## quartz_off_screen 
    ##                 2

EVI profiles
============

``` r
# Read data
iv <- read.csv(file=paste(di, "/data/evi/iv_composite.csv", sep=""), header = TRUE, sep = ',')
```

Prepare data
------------

``` r
evi_profile_dat <- iv %>% 
  group_by(composite) %>% 
  dplyr::summarise(mean=mean(evi, na.rm=T),
            sd = sd(evi, na.rm=T),
            se = sd/sqrt(length(evi))) %>% 
  mutate(composite_dates = 
           plyr::mapvalues(composite,
                           c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23),
                           c('01-01','01-17','02-02','02-18','03-06','03-22','04-07','04-23',
                             '05-09','05-25','06-10','06-26','07-12','07-28','08-13','08-29',
                             '09-14','09-30','10-16','11-01','11-17','12-03','12-19'))) %>%
  mutate(cd = as.Date(composite_dates, format = '%m-%d'))


ndvi_profile_dat <- iv %>% 
  group_by(composite) %>% 
  dplyr::summarise(mean=mean(ndvi, na.rm=TRUE),
            sd = sd(ndvi, na.rm=TRUE),
            se = sd/sqrt(length(ndvi))) %>% 
  mutate(composite_dates = 
           plyr::mapvalues(composite,
                           c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23),
                           c('01-01','01-17','02-02','02-18','03-06','03-22','04-07','04-23',
                             '05-09','05-25','06-10','06-26','07-12','07-28','08-13','08-29',
                             '09-14','09-30','10-16','11-01','11-17','12-03','12-19'))) %>%
  mutate(cd = as.Date(composite_dates, format = '%m-%d'))
```

Plot EVI profile
----------------

``` r
micolor <- '#455883'

evi_profile <- ggplot(evi_profile_dat, aes(cd, y=mean)) + 
  geom_errorbar(aes(ymin = mean - 10*se, ymax= mean + 10*se), width=4, colour=micolor, size=.8) + 
  #geom_errorbar(aes(ymin = mean - sd, ymax= mean + sd), width=4, colour='black') +
  geom_line(colour=micolor, size=.8) + 
  geom_point(size=3,colour=micolor) +
  geom_point(size=1.5, colour='white')+
  scale_x_date(labels = function(x) format(x, "%b"),
               breaks = date_breaks('month')) + 
  ylab('EVI') + xlab('Date') + 
  theme_bw() +
  theme(panel.grid.major=element_blank(),
        panel.grid.minor=element_blank()) +
  theme_classic()
#format(x, "%d-%b") 

print(evi_profile)
```

![](explore_evi_mean_files/figure-markdown_github/evi_profile-1.png)

``` r
pdf(file=paste0(di, "/out/evi_profiles/plot_profile_evi.pdf"), height = 8, width = 12)
evi_profile
dev.off()
```

    ## quartz_off_screen 
    ##                 2

Plot NDVI profile
-----------------

``` r
ndvi_profile <- ggplot(ndvi_profile_dat, aes(cd, y=mean)) + 
  geom_errorbar(aes(ymin = mean - 10*se, ymax= mean + 10*se), width=4, colour=micolor, size=.8) + 
  #geom_errorbar(aes(ymin = mean - sd, ymax= mean + sd), width=4, colour='black') +
  geom_line(colour=micolor, size=.8) + 
  geom_point(size=3,colour=micolor) +
  geom_point(size=1.5, colour='white')+
  scale_x_date(labels = function(x) format(x, "%b"),
               breaks = date_breaks('month')) + 
  ylab('NDVI') + xlab('Date') + 
  theme_bw() +
  theme(panel.grid.major=element_blank(),
        panel.grid.minor=element_blank()) +
  theme_classic()
#format(x, "%d-%b") 

print(ndvi_profile)
```

![](explore_evi_mean_files/figure-markdown_github/ndvi_profile-1.png)

``` r
pdf(file=paste0(di, "/out/evi_profiles/plot_profile_ndvi.pdf"), height = 8, width = 12)
ndvi_profile
dev.off()
```

    ## quartz_off_screen 
    ##                 2

Comparing 2005 and 2012 with reference
--------------------------------------

``` r
drought_years <- c(2005, 2012)

evi_profile_dat_ref <- iv %>% 
  filter(!year %in% drought_years) %>% 
  group_by(composite) %>% 
  dplyr::summarise(mean=mean(evi, na.rm=TRUE),
            sd = sd(evi, na.rm=TRUE),
            se = sd/sqrt(length(evi))) %>% 
  mutate(composite_dates = 
           plyr::mapvalues(composite,
                           c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23),
                           c('01-01','01-17','02-02','02-18','03-06','03-22','04-07','04-23',
                             '05-09','05-25','06-10','06-26','07-12','07-28','08-13','08-29',
                             '09-14','09-30','10-16','11-01','11-17','12-03','12-19'))) %>%
  mutate(cd = as.Date(composite_dates, format = '%m-%d')) %>% 
  mutate(period = 'reference')

evi_profile_dat_2005 <- iv %>% 
  filter(year == 2005) %>% 
  group_by(composite) %>% 
  dplyr::summarise(mean=mean(evi, na.rm=TRUE),
            sd = sd(evi, na.rm=TRUE),
            se = sd/sqrt(length(evi))) %>% 
  mutate(composite_dates = 
           plyr::mapvalues(composite,
                           c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23),
                           c('01-01','01-17','02-02','02-18','03-06','03-22','04-07','04-23',
                             '05-09','05-25','06-10','06-26','07-12','07-28','08-13','08-29',
                             '09-14','09-30','10-16','11-01','11-17','12-03','12-19'))) %>%
  mutate(cd = as.Date(composite_dates, format = '%m-%d')) %>% 
  mutate(period = '2005')

evi_profile_dat_2012 <- iv %>% 
  filter(year == 2012) %>% 
  group_by(composite) %>% 
  dplyr::summarise(mean=mean(evi, na.rm=TRUE),
            sd = sd(evi, na.rm=TRUE),
            se = sd/sqrt(length(evi))) %>% 
  mutate(composite_dates = 
           plyr::mapvalues(composite,
                           c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23),
                           c('01-01','01-17','02-02','02-18','03-06','03-22','04-07','04-23',
                             '05-09','05-25','06-10','06-26','07-12','07-28','08-13','08-29',
                             '09-14','09-30','10-16','11-01','11-17','12-03','12-19'))) %>%
  mutate(cd = as.Date(composite_dates, format = '%m-%d')) %>% 
  mutate(period = '2012')

# Join the three dataframes
evi_profile_compara_dat <- rbind(evi_profile_dat_ref, evi_profile_dat_2005, evi_profile_dat_2012)
```

``` r
# colref <- '#455883'
# colref2 <- '#10253F'
# col2005 <- '#00BA38'
# col2012 <- '#F8766D'

col2012 <- '#0700fe'
col2005 <- '#19e00b'
colref <- '#7b7b7b'


profile_compara <- ggplot(evi_profile_compara_dat, aes(cd, y=mean, color=period)) + 
  geom_errorbar(aes(ymin = mean - 2*se, ymax= mean + 2*se), width=3, size=.5) + 
  #geom_errorbar(aes(ymin = mean - sd, ymax= mean + sd), width=4, colour='black') + 
  geom_line(size=.9) + 
  geom_point(size=3, fill='white', shape=21) +
  scale_x_date(labels = function(x) format(x, "%b"),
               breaks = date_breaks('month')) + 
  ylab('EVI') + xlab('Date') + 
  theme_bw() +
  theme_classic() + 
  theme(panel.grid.major=element_blank(),
        panel.grid.minor=element_blank()) +
  scale_color_manual(values=c(col2005, col2012, colref))

#format(x, "%d-%b") 

profile_compara
```

![](explore_evi_mean_files/figure-markdown_github/evi_profile_compara-1.png)

``` r
pdf(file=paste0(di, "/out/evi_profiles/plot_evi_profiles_compara.pdf"), height = 8, width = 12)
profile_compara
dev.off()
```

    ## quartz_off_screen 
    ##                 2