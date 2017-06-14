# Script to parser XML data from CLIMA-REDIAM
# @ajpelu 2017

library('XML')
library('tidyverse')
library('stringr')

# WD 
machine <- 'ajpelu'
# machine <- 'ajpeluLap'
di <- paste0('/Users/', machine, '/Dropbox/phd/phd_repos/qpyr_dendro/', sep='')

# read xmls 
f <- list.files(paste0(di, 'data_raw/meteo/'), pattern = '*.xml')


# Load function 
source(paste0(di, 'script/R/parseaXMLclima.R'))

# Set path 
mypath <- paste0(di, 'data_raw/meteo/') 

# # Loop to process all data 
# for (i in 1:length(f)){ 
#   d <- parseaXMLclima(f[i], path=mypath)
#   name_d <- str_replace(f[i], pattern = '.xml', '')
#   assign(name_d, d)
# }

d_base <- parseaXMLclima("5514_base_aerea_dialy.xml", mypath) 
m_base <- parseaXMLclima("5514_base_aerea_monthly.xml", mypath) 
m_cartuja <- parseaXMLclima("5515_cartuja_monthly.xml", mypath) 
m_soportujar <- parseaXMLclima("6246_soportujaar_monthly.xml", mypath) 
m_lanjaron <- parseaXMLclima("6258_lanjaron_monthly.xml", mypath) 



# Daily data
write.csv(d_base$values, row.names = FALSE,
          file = paste0(di, '/data_raw/meteo/5514_base_aerea_dialy.csv')) 

write.csv(m_base$values, row.names = FALSE,
          file = paste0(di, '/data_raw/meteo/5514_base_aerea_monthly.csv')) 

write.csv(m_cartuja$values, row.names = FALSE,
          file = paste0(di, '/data_raw/meteo/5515_cartuja_monthly.csv')) 

write.csv(m_soportujar$values, row.names = FALSE,
          file = paste0(di, '/data_raw/meteo/6246_soportujaar_monthly.csv')) 

write.csv(m_lanjaron$values, row.names = FALSE,
          file = paste0(di, '/data_raw/meteo/6258_lanjaron_monthly.csv')) 




