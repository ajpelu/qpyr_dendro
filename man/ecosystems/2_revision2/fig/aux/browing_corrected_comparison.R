library("tidyverse")

anomalias_evimean <- 
  read.csv(file="./data/anomalies/anomalias_evimean.csv", header = TRUE, sep = ',')

anomalias_evimean <- anomalias_evimean %>% 
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




sa2005 <- anomalias_evimean %>% 
  filter(y == 2005) %>% 
  mutate(type = ifelse(sa < -1, "browning", 
                       ifelse(sa > 1, "greening", "no change"))) %>% 
  group_by(clu_pop2, type) %>% 
  dplyr::summarise(count_clu = n()) %>% 
  group_by(clu_pop2) %>% 
  mutate(per = round(count_clu / sum(count_clu)*100, 2),
         y = 2005) 

sa2012 <- anomalias_evimean %>% filter(y == 2012) %>% 
  mutate(type = ifelse(sa < -1, "browning", 
                       ifelse(sa > 1, "greening", "no change"))) %>% 
  group_by(clu_pop2, type) %>% 
  dplyr::summarise(count_clu = n()) %>% 
  group_by(clu_pop2) %>% 
  mutate(per = round(count_clu / sum(count_clu)*100, 2),
         y = 2012) 

per_sa <- sa2005 %>% rbind(sa2012) %>% as.data.frame()


## corrected 
anomalias_evimeanc <- 
  read.csv(file="./data/anomalies/anomalias_evimean_corrected.csv", header = TRUE, sep = ',')
anomalias_evimeanc <- anomalias_evimeanc %>% 
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




sa2005c <- anomalias_evimeanc %>% 
  filter(y == 2005) %>% 
  mutate(type = ifelse(sa < -1, "browning", 
                       ifelse(sa > 1, "greening", "no change"))) %>% 
  group_by(clu_pop2, type) %>% 
  dplyr::summarise(count_clu = n()) %>% 
  group_by(clu_pop2) %>% 
  mutate(per = round(count_clu / sum(count_clu)*100, 2),
         y = 2005) 

sa2012c <- anomalias_evimeanc %>% filter(y == 2012) %>% 
  mutate(type = ifelse(sa < -1, "browning", 
                       ifelse(sa > 1, "greening", "no change"))) %>% 
  group_by(clu_pop2, type) %>% 
  dplyr::summarise(count_clu = n()) %>% 
  group_by(clu_pop2) %>% 
  mutate(per = round(count_clu / sum(count_clu)*100, 2),
         y = 2012) 

per_sac <- sa2005c %>% rbind(sa2012c) %>% as.data.frame()

a <- per_sa %>% mutate(f = "original") %>% 
  bind_rows(per_sac %>% mutate(f = "no removed"))

write.csv(per_sac, file='./out/anomalies/evi/percen_browing_greeningcorrected.csv', row.names = F)




