# vector 
# install.packages('rowr')
library('rowr')
library('zoo')

x <- 1:10

y <- c(1,2,1,3,1,2,4,3,2,1)





y <- c(1,2,3,5,4,6,7,6,5,4,8)
rollApply(y, sum, window = 10, align = 'left')

rollapply(y, width = 10, sum, align = 'left', partial=TRUE)
rollapply(y, width = 11, sum, align = 'right', partial=TRUE)





rollApply(y, sum, window = 2, align='right')



rw <- data.frame(rw=c(1,2,3,5,4,6,7,6,5,4,8))

rw <- rw %>% 
  mutate(g2= rollapply(rw, width = 10, sum, align = 'left', partial=TRUE), 
         g1_nolag = rollapply(rw, width = 11, sum, align = 'right', partial=TRUE),
         rw_lag = lag(rw, 1),
         g1_previous10 = rollapply(rw_lag, width = 10, sum, align = 'right', partial=TRUE, na.rm=T),
         g1_mio = g1_nolag - rw,
         gc = ((g2 - g1_previous10) / g1_previous10)*100,
         gc_mio = ((g2 - g1_mio) / g1_mio)*100)
        


machine <- 'ajpelu'
# machine <- 'ajpeluLap'
di <- paste('/Users/', machine, '/Dropbox/phd/phd_repos/qpyr_dendro/', sep='')

# sj 
sj <- read.rwl(fname=paste0(di, '/data_raw/dendro_ring/sn_sanjuan/sn_sanjuan.rwl'), format="tucson")






