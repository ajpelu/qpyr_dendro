# Read data
library('tidyverse')
library('here')

iv <- read.csv(file=here::here("/data/evi/evi_mean.csv"), header = TRUE, sep = ',')

# Prepare data
# NOTE remove pop 9 
evi <- iv %>% filter(pop != 9) %>% 
  dplyr::select(-n_composites) %>% 
  mutate(
    populations = as.factor(case_when(
    pop %in% c(1,2,3,4,5) ~ 'N',
    pop %in% c(6,7,8) ~ 'S')))

write.csv(evi, file=here::here('/data/evi/evi_paganea.csv'), row.names = F)
  
