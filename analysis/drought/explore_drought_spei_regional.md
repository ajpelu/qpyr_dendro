Drought data
============

-   Obtain data of drought index SPEI from [SPEI Global Drought Monitor](http://sac.csic.es/spei/map/maps.html)
-   Query data from Sierra Nevada \[36.75, -3.75\], \[37.25, -3.25\]

Prepare data
------------

``` r
# Get file names
myfiles <- list.files(path = paste(di, "/data_raw/spei_all", sep=""), pattern = "\\.csv$")

mydf <- data.frame() 

# Loop to read files and prepare data
for (j in myfiles){ 
  aux <- read.csv(file=paste(di, "/data_raw/spei_all/", j, sep= ""),
              header = TRUE,
              sep = ',')
  
  # Remove csv and get name 
  name_aux <- str_replace(j, ".csv", "") 
  
  # Get lat long
  latlong <- str_replace(name_aux, "SPEI_", "")
  
  mylat <- as.numeric(str_split_fixed(latlong, "_", 2))[1]
  mylong <- as.numeric(str_split_fixed(latlong, "_", 2))[2]
  
  aux$lat <- mylat
  aux$long <- mylong 

  # Split time 
  # Get year 
  aux$year <- as.numeric(str_extract(aux$DATA, "[0-9]+"))
  
  # Get month 
  aux$month <- str_extract(aux$DATA, "[aA-zZ]+")
  
  # Variable month in number 
  aux$months <- match(aux$month, month.abb)
  
  
  # assign(name_aux, aux)
  
  mydf <- rbind(mydf, aux)
}
```

Select data for SPEI\_1, SPEI\_3, SPEI\_6, SPEI\_12, SPEI\_24, and SPEI\_48 and compute the mean of the 6 cells (0.5º size)

``` r
spei <- mydf %>% 
  select(SPEI_1,SPEI_3,SPEI_6,SPEI_12,SPEI_24, SPEI_48, lat, long, year, months) 

# Get mean values of the all cells (4 celss ) 
# and create a date format variable 
spei_mean <- spei %>% 
  select(-lat, -long) %>% 
  group_by(year,months) %>% 
  summarise(spei1 = mean(SPEI_1),
            spei3 = mean(SPEI_3),
            spei6 = mean(SPEI_6),
            spei12 = mean(SPEI_12),
            spei24 = mean(SPEI_24),
            spei48 = mean(SPEI_48)) %>%
  mutate(date = lubridate::ymd(paste(year, months, "01"))) 

# Melting data and compute a sing auxiliar column to colour bars 
spei_mean_melt <- melt(spei_mean, id.vars = c("year", "months", "date"))
spei_mean_melt$sign <- ifelse(spei_mean_melt$value > 0, "pos", "neg")

spei_mean_melt2000 <- spei_mean_melt %>% 
  filter(year >= 2000)
```

### Plot

``` r
label_variables <- c('spei1' = '1-month',
                     'spei3' = '3-month',
                     'spei6' = '6-month',
                     'spei12' = '12-month',
                     'spei24' = '24-month',
                     'spei48' = '48-month')


d <- ggplot(spei_mean_melt, aes(x=date, y=value, fill=sign)) +  
  geom_bar(stat = "identity") + 
  facet_wrap(~variable, ncol=1, labeller = as_labeller(label_variables)) + 
  scale_fill_manual(values = c("pos" = "darkblue", "neg" = "red")) +
  theme_bw()  + 
  labs(title= 'Drought evolution for Sierra Nevada',
    x= '',
    y='SPEI') +
  theme(strip.background = element_rect(fill = "white"),
        legend.position = "none") 

d
```

    ## Warning: Removed 88 rows containing missing values (position_stack).

![](explore_drought_spei_regional_files/figure-markdown_github/unnamed-chunk-3-1.png)

``` r
# >2000
d2000 <- ggplot(spei_mean_melt2000, aes(x=date, y=value, fill=sign)) +  
  geom_bar(stat = "identity") + 
  facet_wrap(~variable, ncol=1, labeller = as_labeller(label_variables)) + 
  scale_fill_manual(values = c("pos" = "darkblue", "neg" = "red")) +
  theme_bw()  + 
  labs(title= 'Drought evolution for Sierra Nevada (From year 2000)',
    x= '',
    y='SPEI') +
  theme(strip.background = element_rect(fill = "white"),
        legend.position = "none") 

d2000
```

![](explore_drought_spei_regional_files/figure-markdown_github/unnamed-chunk-3-2.png)

Explore 3, 6 months scales
==========================

``` r
spei_mean_melt1970 <- spei_mean_melt %>% 
  filter(year >= 1970) %>%
  filter(variable %in% c('spei3', 'spei6'))


d1970 <- ggplot(spei_mean_melt1970, aes(x=date, y=value, fill=sign)) +  
  geom_bar(stat = "identity") + 
  facet_wrap(~variable, ncol=1, labeller = as_labeller(label_variables)) + 
  scale_fill_manual(values = c("pos" = "darkblue", "neg" = "red")) +
  theme_bw()  + 
  labs(title= 'Drought evolution for Sierra Nevada (From year 1970)',
    x= '',
    y='SPEI') +
  theme(strip.background = element_rect(fill = "white"),
        legend.position = "none") +
  scale_x_date(date_breaks = "2 year", date_labels = "%Y")

d1970
```

![](explore_drought_spei_regional_files/figure-markdown_github/unnamed-chunk-4-1.png)

``` r
### Export all pdfs
di_export <- paste0(di, "/out/fig/drought") 

pdf(file=paste0(di_export, "/spei_sn_all.pdf"), height = 10, width =9)
d 
```

    ## Warning: Removed 88 rows containing missing values (position_stack).

``` r
dev.off() 
```

    ## quartz_off_screen 
    ##                 2

``` r
pdf(file=paste0(di_export, "/spei_sn_all_2000.pdf"), height = 10, width =9)
d2000
dev.off()
```

    ## quartz_off_screen 
    ##                 2

``` r
pdf(file=paste0(di_export, "/spei_sn_all_1970.pdf"), height = 5, width =9)
d1970
dev.off()
```

    ## quartz_off_screen 
    ##                 2
