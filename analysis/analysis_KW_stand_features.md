Prepare Data
============

``` r
# Compute diameter (mm)
tree <- tree %>% 
  mutate(dn_mm = (perim_mm / pi))
         

sj_code  <- paste0('A', str_pad(1:20, 2, pad='0'))
ca_lowcode <- c(paste0('B', str_pad(1:10, 2, pad='0')), paste0('B', 26:30))
ca_highcode <- paste0('B', 11:25)

tree <- tree %>% mutate(
  site = as.factor(case_when(
    id_focal %in% sj_code ~ "sj", 
    id_focal %in% ca_highcode ~ "caH", 
    id_focal %in% ca_lowcode ~ "caL")))
    
# Get only focal trees  
ft <- tree %>% 
  filter(sp=='Focal') %>% 
  filter(id_focal!='Fresno') 

# Get only no focal trees 
nft <- tree %>% 
  filter(sp!='Focal') 


# Select only variables to compare (ft)
ft_sel <- ft %>%
  mutate(dn = dn_mm / 10, 
         h = height_cm / 100) %>% 
  dplyr::select(dn, h, site) 


# Select only variable to compare (all trees)
all <- nft %>% mutate(dn = dn_mm / 10, 
                      h = height_cm / 100) %>% 
  dplyr::select(dn, h, site) %>% 
  bind_rows(ft_sel) 
```

Competition data
================

-   Read data

Kruskal-Wallis comparison
=========================

``` r
comparaKW <- function(df, mivariable){ 
  require(PMCMR)
  require(multcompView) 
  
  output <- list() 
  
  # Model formulation
  myformula <- as.formula(paste0(mivariable, " ~ site"))
  
  # Kruskal Wallis  
  kt <- kruskal.test(myformula, data = df) 
  
  # Summary AOV (broom style)
  tm <- broom::tidy(kt)
  tm$mi_variable <- mivariable
  
  # Dunn's test 
  object <- posthoc.kruskal.dunn.test(myformula, data=df, p.adjust.method = "bonferroni")
  
  # Get dataframe with letters and pvalues (#from summary.PMCMR)
  pval <- as.numeric(object$p.value)
  stat <- as.numeric(object$statistic)
  grp1 <- as.numeric(c(col(object$p.value)))
  cnam <- colnames(object$p.value)
  grp2 <- as.numeric(c(row(object$p.value)))
  rnam <- rownames(object$p.value)
  H0 <- paste(cnam[grp1], " = ", rnam[grp2])
  OK <- !is.na(pval)
  xdf <- data.frame(H0 = H0[OK], statistic = stat[OK], p.value = format.pval(pval[OK], 5))
  
  # Get letters (using multcompView) See viggnete PMCMR 
  dt_letters  <- multcompView::multcompLetters(get.pvalues(object), threshold = 0.05)
  

  output$KW <- tm
  output$post_hoc <- xdf
  output$letters <- dt_letters
  return(output)
  }
```

``` r
# Focal Tree 
kw_ft_dn <- comparaKW(ft_sel, 'dn')
kw_ft_h <- comparaKW(ft_sel, 'h')

# All trees 
kw_all_dn <- comparaKW(all, 'dn') 
kw_all_h <- comparaKW(all, 'h')

# Competence 
kw_ba <- comparaKW(compe_sel, 'ba')
kw_std <- comparaKW(compe_sel, 'std')
kw_srd <- comparaKW(compe_sel, 'srd')
kw_pd <- comparaKW(compe_sel, 'pd')
```

Export data to text files (see `/out/kw_stand_features/`)
=========================================================

``` r
variables <- c('ft_dn', 'ft_h', 'all_dn', 'all_h', 'ba', 'std', 'srd', 'pd') 

for (i in variables){ 
 
  out <- get(paste0('kw_', i))
  file_out <- file(paste0(di,'out/kw_stand_features/kw_', i, '.txt'), "w")
  sink(file_out)
  cat(paste0("VARIABLE = ",i," \n"))
  cat("\n")
  cat("KRUSKAL WALLIS \n")
  print(out$KW) 
  cat("\n")
  
  cat("POST HOC \n")
  print(out$post_hoc) 
  cat("\n")
  
  cat("Letters \n")
  print(out$letters)
  cat("\n")
  
  while (sink.number()>0) sink()
  # close(file_out)
}

while (sink.number()>0) sink()
```

``` r
variables <- c('ft_dn', 'ft_h', 'all_dn', 'all_h', 'ba', 'std', 'srd', 'pd')
output_letras <- c()

for (i in variables){ 
   
  out <- get(paste0('kw_', i))
  l <- as.data.frame(out$letters$Letters)
  l$site <- row.names(l)
  colnames(l) <- c('letter', 'site')
  l$mivariable <- i 
  
  output_letras <- rbind(output_letras, l)
} 

# Export data 
write.csv(output_letras, file=paste(di, "out/kw_stand_features/kw_letras.csv", sep=""), row.names = FALSE)
```
