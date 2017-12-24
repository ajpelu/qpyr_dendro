## Compute RWI with splines 
# rwdf: a ring-width dataframe. row: years; col: id_cores
# nsmooth: size of the wavelength (0.67*long serie; ej.: 30 years) 

# Return: a dataframe with RWI value

computeSpline <- function (rwdf, nsmooth) {
  
  require(dplyr)
  require(dplR)
  
  # rwl_rwi <- data.frame()
  rwl_rwi <- data.frame(year = as.numeric(row.names(rwdf)))
  
  # ID cores 
  cores <- colnames(rwdf)
  
  for (i in cores) {
    # 1 # Select core (serie)
    id_core <- i
    
    # 2 # Select ring width serie 
    rws <- rwdf[[id_core]]
    
    # 3 # Detrended serie
    names(rws) <- rownames(rwdf)
    
    serie_suavizada <- detrend.series(y = rws, method = "Spline",
                                      y.name = id_core, nyrs = nsmooth, 
                                      make.plot = FALSE) 
    serie_suavizada <- as.data.frame(serie_suavizada) 
    colnames(serie_suavizada) <- id_core 
    serie_suavizada$year <- as.numeric(row.names(serie_suavizada))
    
    # 4 # Join another detrended series
    rwl_rwi <- rwl_rwi %>% inner_join(serie_suavizada, by = "year") %>% as.data.frame()
  }
  
  row.names(rwl_rwi) <- rwl_rwi$year 
  rwl_rwi <- rwl_rwi %>% dplyr::select(-year) %>% as.data.frame()
  
  return(rwl_rwi)
}     

