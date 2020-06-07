
library("tidyverse")
library("here")
library("ggpubr")

source(here::here('/script/R/custom_functions.R'))


elev <- read_csv(here::here("./data/elev.csv"))

sj_lowcode  <- paste0('A', str_pad(1:10, 2, pad='0'))
sj_highcode <- paste0('A', 11:20)
ca_lowcode <- c(paste0('B', str_pad(1:10, 2, pad='0')),
                paste0('B', 26:30))
ca_highcode <- paste0('B', 11:25)


elev <- elev %>%
  mutate(site = ifelse(name %in% sj_lowcode, 'SJ-Low',
                       ifelse(name %in% sj_highcode, 'SJ-High',
                              ifelse(name %in% ca_lowcode, 'CA-Low', 'CA-High')))) 

elev %>% ggplot(aes(y=elev_mde, x= site, colour = site)) + 
  geom_boxplot() + 
  geom_jitter(width = 0.2) + 
  theme_bw() + 
  theme(legend.position = "none")
ylab("Elevation (m)")


sj <- elev %>% filter(site %in% c("SJ-Low", "SJ-High")) 


ggboxplot(elev, x = "site", y = "elev_mde", 
          color = "site",
          ylab = "Elevation", xlab = "Site") + 
  scale_y_continuous(
    breaks = seq(1150, 2000, by=50))


t.test(elev_mde ~ site, data = sj) 

ca <- elev %>% filter(site %in% c("CA-Low", "CA-High")) 
t.test(elev_mde ~ site, data = ca) 


<!-- # Create subset to compare between sites  -->
  <!-- caL <- ca[,c("CA0101","CA0102","CA0201","CA0202","CA0301","CA0302","CA0401","CA0402","CA0501","CA0502", -->
                      <!--              "CA0601","CA0602","CA0701","CA0702","CA0801","CA0802","CA0901","CA0902","CA1001","CA1002", -->
                      <!--              "CA2601","CA2602","CA2701","CA2702","CA2801","CA2802","CA2901","CA2902","CA3001","CA3002")]  -->
  <!-- caH <- ca[, c("CA1101","CA1102","CA1201","CA1202","CA1301","CA1302","CA1401","CA1402","CA1501","CA1502", -->
                       <!--               "CA1601","CA1602","CA1701","CA1702","CA1801","CA1802","CA1901","CA1902","CA2001","CA2002", -->
                       <!--               "CA2101","CA2102","CA2201","CA2202","CA2301","CA2302","CA2401","CA2402","CA2501","CA2502")] -->
  
  <!-- sjL <- sj[, c("SJ0101","SJ0102","SJ0201","SJ0202","SJ0301","SJ0302","SJ0401","SJ0402","SJ0501","SJ0502", -->
                       <!--               "SJ0601","SJ0602","SJ0603","SJ0701","SJ0702","SJ0801","SJ0802","SJ0901","SJ0902","SJ0903", -->
                       <!--               "SJ1001","SJ1002","SJ1003")] -->
  <!-- sjH <- sj[, c("SJ1101","SJ1102","SJ1103","SJ1201","SJ1202","SJ1203","SJ1301","SJ1302","SJ1303","SJ1401", -->
                       <!--               "SJ1402","SJ1501","SJ1502","SJ1601","SJ1602","SJ1701","SJ1702","SJ1703","SJ1801","SJ1802", -->
                       <!--               "SJ1901","SJ1902","SJ2001","SJ2003","SJ2002")] -->
  