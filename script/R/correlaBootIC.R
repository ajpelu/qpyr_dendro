# Function to compute correlation between two series and compute IC by boot 
# - df_suaviza: df with smoothed series (the two series together, by rbind), and the following attributes: 
#  * yearss
#  * bai_smooth: the value of bai smoothed
#  * size_window: the size of window used to smoothed the serie (centred moving average)
#  * cronomame: the name of the chrono 
# - tipos_correla: types of correlation. ie: tc <- c('spearman', 'pearson')
# - years_suavizado: the length of years of smoothed used (i.e. 40)
# - name_comparison: name to the two series comparison. i.e.: 'sjL-sjH'
# BootIC are computed using the following parameters: 
# * replicates = 1000 
# * ic = 0.95 
# * type of interval = "bca"


correlaBootIC <- function(df_suaviza, tipos_correla, years_suavizado, 
                          name_comparison){
  
  ys <- as.numeric(years_suavizado)
  nc <- as.character(name_comparison)
  
  out_correla <- c() 
  for (m in tipos_correla){ 
    # Choose correlation approach 
    metodo_correla <- m
    
    out_final <- c() 
    
    for (j in 1:ys){
      aux <- df_suaviza %>% 
        filter(size_wind == j) %>%
        dplyr::select(-size_wind) %>% 
        spread(crononame, bai_smooth) %>% 
        na.omit() %>% # to compare the series in the years they are overlapping 
        as.data.frame() 
      
      # Put years as rownames and delete yearss variable
      rownames(aux) <- aux$yearss 
      aux1 <- aux[,-1]
      
      # Names the series 
      names(aux1) <- c('a', 'b')
      
      # Get real value of correlation between smoothed series 
      coeff_correlation <- cor.test(aux1$a, aux1$b, method = metodo_correla)$estimate 
      
      ## Bootstratp to ger CI 
      ### Function to apply 
      correlationTest <- function(x,index){
        ct <- cor.test(x$a[index], x$b[index], method = metodo_correla)
        return(ct$estimate)
        }
      
      ### boostrap   
      boot_cor <- boot(aux1, correlationTest, R=1000)
      ### CI
      bci <- boot.ci(boot_cor, conf = 0.95, type = 'bca')
      
      # Output results 
      estimate <- bci$t0 # Estimate coefficient
      ci_lower <- bci$bca[4] # Lower CI
      ci_upper <- bci$bca[5] # Upper CI
      
      out <- as.data.frame(cbind(estimate, ci_lower, ci_upper))
      
      # Smoothing year (window size)
      out$size <- j 
      
      out_final <- rbind(out_final, out) 
      }
    
    # set name of comparison
    out_final$name_comparison <- nc
    out_final$metodo_correla <- m
    
    out_correla <- rbind(out_correla, out_final)
  }
  return(out_correla)
}


